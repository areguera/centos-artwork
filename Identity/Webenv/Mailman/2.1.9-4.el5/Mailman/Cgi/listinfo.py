# Copyright (C) 1998-2003 by the Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

"""Produce listinfo page, primary web entry-point to mailing lists.
"""

# No lock needed in this script, because we don't change data.

import os
import cgi

from Mailman import mm_cfg
from Mailman import Utils
from Mailman import MailList
from Mailman import Errors
from Mailman import i18n
from Mailman.htmlformat import *
from Mailman.Logging.Syslog import syslog

# Set up i18n
_ = i18n._
i18n.set_language(mm_cfg.DEFAULT_SERVER_LANGUAGE)



def main():
    parts = Utils.GetPathPieces()
    if not parts:
        listinfo_overview()
        return

    listname = parts[0].lower()
    try:
        mlist = MailList.MailList(listname, lock=0)
    except Errors.MMListError, e:
        # Avoid cross-site scripting attacks
        safelistname = Utils.websafe(listname)
        listinfo_overview(_('No such list <em>%(safelistname)s</em>'))
        syslog('error', 'No such list "%s": %s', listname, e)
        return

    # See if the user want to see this page in other language
    cgidata = cgi.FieldStorage()
    language = cgidata.getvalue('language')
    if not Utils.IsLanguage(language):
        language = mlist.preferred_language
    i18n.set_language(language)
    list_listinfo(mlist, language)


def listinfo_overview(msg=''):
    # Present the general listinfo overview
    hostname = Utils.get_domain()
    # Set up the document and assign it the correct language.  The only one we
    # know about at the moment is the server's default.
    doc = Document()
    doc.set_language(mm_cfg.DEFAULT_SERVER_LANGUAGE)

    legend = _('General Information') + ' - ' + _('Mailing Lists')
    doc.SetTitle(legend)

    table = Table()
    #table.AddRow([Center(Header(2, legend))])
    #table.AddCellInfo(table.GetCurrentRowIndex(), 0, colspan=2,
    #                  bgcolor=mm_cfg.WEB_HEADER_COLOR)

    # Skip any mailing lists that isn't advertised.
    advertised = []
    listnames = Utils.list_names()
    listnames.sort()

    for name in listnames:
        mlist = MailList.MailList(name, lock=0)
        if mlist.advertised:
            if mm_cfg.VIRTUAL_HOST_OVERVIEW and \
                   mlist.web_page_url.find(hostname) == -1:
                # List is for different identity of this host - skip it.
                continue
            else:
                advertised.append((mlist.GetScriptURL('listinfo'),
                                   mlist.real_name,
                                   mlist.description))
    welcome = Header(1, _('General Information')).Format()
    mailmanlink = Link(mm_cfg.MAILMAN_URL, _('Mailman')).Format()
    if not advertised:
        welcome += Paragraph(_('There currently are no publicly-advertised %(mailmanlink)s mailing lists on %(hostname)s.')).Format(css='class="strong"')
    else:
    	welcome += Paragraph(_('''Below is a listing of all the public mailing lists on %(hostname)s. Click on a list name to get more information about the list, or to subscribe, unsubscribe, and change the preferences on your subscription.''')).Format()

    # set up some local variables
    adj = msg and _('right') or ''
    siteowner = Utils.get_site_email()
    welcome += Paragraph( 
        _('''To visit the general information page for an unadvertised list, open a URL similar to this one, but with a '/' and the %(adj)s list name appended.''')).Format()
    
    welcome += Paragraph(_('''List administrators, you can visit ''') +
        Link(Utils.ScriptURL('admin'),
              _('the list admin overview page')).Format() + 
        _(''' to find the management interface for your list.''')).Format()
    welcome += Paragraph(_('''If you are having trouble using the lists, please contact ''') + 
         Link('mailto:' + siteowner, siteowner).Format()).Format()

    if advertised:
        highlight = 1
        for url, real_name, description in advertised:
            table.AddRow(
                [Link(url, real_name),
                      description or _('[no description available]')])
            if highlight:
                table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="title strong"')
                table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="title left"')
	    else:
                table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="strong"')
            	table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="left"')
            highlight = not highlight

    doc.AddItem(welcome)
    # When printing the mailing list table; avoid empty <table> tag to appear when
    # no mailing list / rows are present inside it. Empty <table> tags are a violation
    # in the "-//W3C//DTD XHTML 1.0 Transitional//EN" standard.
    if advertised:
    	doc.AddItem(table)
    doc.AddItem(MailmanLogo())
    print doc.Format()



def list_listinfo(mlist, lang):
    # Generate list specific listinfo
    doc = HeadlessDocument()
    doc.set_language(lang)

    replacements = mlist.GetStandardReplacements(lang)

    if not mlist.digestable or not mlist.nondigestable:
        replacements['<mm-digest-radio-button>'] = ""
        replacements['<mm-undigest-radio-button>'] = ""
        replacements['<mm-digest-question-start>'] = '<!-- '
        replacements['<mm-digest-question-end>'] = ' -->'
    else:
        replacements['<mm-digest-radio-button>'] = mlist.FormatDigestButton()
        replacements['<mm-undigest-radio-button>'] = \
                                                   mlist.FormatUndigestButton()
        replacements['<mm-digest-question-start>'] = ''
        replacements['<mm-digest-question-end>'] = ''
    replacements['<mm-plain-digests-button>'] = \
                                              mlist.FormatPlainDigestsButton()
    replacements['<mm-mime-digests-button>'] = mlist.FormatMimeDigestsButton()
    replacements['<mm-subscribe-box>'] = mlist.FormatBox('email', size=30)
    replacements['<mm-subscribe-button>'] = mlist.FormatButton(
        'email-button', text=_('Subscribe'))
    replacements['<mm-new-password-box>'] = mlist.FormatSecureBox('pw')
    replacements['<mm-confirm-password>'] = mlist.FormatSecureBox('pw-conf')
    replacements['<mm-subscribe-form-start>'] = mlist.FormatFormStart(
        'subscribe')
    # Roster form substitutions
    replacements['<mm-roster-form-start>'] = mlist.FormatFormStart('roster')
    replacements['<mm-roster-option>'] = mlist.FormatRosterOptionForUser(lang)
    # Options form substitutions
    replacements['<mm-options-form-start>'] = mlist.FormatFormStart('options')
    replacements['<mm-editing-options>'] = mlist.FormatEditingOption(lang)
    replacements['<mm-info-button>'] = SubmitButton('UserOptions',
                                                    _('Edit Options')).Format()
    # If only one language is enabled for this mailing list, omit the choice
    # buttons.
    if len(mlist.GetAvailableLanguages()) == 1:
        displang = ''
    else:
        displang = mlist.FormatButton('displang-button',
                                      text = _('View this page in'))
    replacements['<mm-displang-box>'] = displang
    replacements['<mm-lang-form-start>'] = mlist.FormatFormStart('listinfo')
    replacements['<mm-fullname-box>'] = mlist.FormatBox('fullname', size=30)

    # Links on header section (errormsg)
    listadmin_link = Link(Utils.ScriptURL('admin'), _('Administration')).Format()
    listinfo_link = Link(Utils.ScriptURL('listinfo'), _('General Information')).Format()
    replacements['<mm-errormsg-listinfo>'] = listinfo_link
    replacements['<mm-errormsg-listadmin>'] = listadmin_link
    replacements['<mm-errormsg-header>'] = _('Mailing Lists')

    # Do the expansion.
    doc.AddItem(mlist.ParseTags('listinfo.html', replacements, lang))
    print doc.Format()



if __name__ == "__main__":
    main()
