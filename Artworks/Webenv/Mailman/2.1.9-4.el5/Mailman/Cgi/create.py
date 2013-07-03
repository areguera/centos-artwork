# Copyright (C) 2001-2006 by the Free Software Foundation, Inc.
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
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
# USA.

"""Create mailing lists through the web."""

import sys
import os
import signal
import cgi
import sha
from types import ListType

from Mailman import mm_cfg
from Mailman import MailList
from Mailman import Message
from Mailman import Errors
from Mailman import i18n
from Mailman.htmlformat import *
from Mailman.Logging.Syslog import syslog

# Set up i18n
_ = i18n._
i18n.set_language(mm_cfg.DEFAULT_SERVER_LANGUAGE)



def main():
    doc = Document()
    doc.set_language(mm_cfg.DEFAULT_SERVER_LANGUAGE)

    cgidata = cgi.FieldStorage()
    parts = Utils.GetPathPieces()
    if parts:
        # Bad URL specification
        title = _('Bad URL specification')
        doc.SetTitle(title)
        doc.AddItem(Div(Paragraph(title)).Format(css='class="message error strong"'))
        syslog('error', 'Bad URL specification: %s', parts)
    elif cgidata.has_key('doit'):
        # We must be processing the list creation request
        process_request(doc, cgidata)
    elif cgidata.has_key('clear'):
        request_creation(doc)
    else:
        # Put up the list creation request form
        request_creation(doc)
    # Always add the footer and print the document
    doc.AddItem(Paragraph(
		_('Return to the ') +
                Link(Utils.ScriptURL('listinfo'),
                     _('general list overview')).Format() + 
    		'<br />' + _('Return to the ') +
                Link(Utils.ScriptURL('admin'),
                     _('administrative list overview')).Format()).Format())
    doc.AddItem(MailmanLogo())
    print doc.Format()



def process_request(doc, cgidata):
    # Lowercase the listname since this is treated as the "internal" name.
    listname = cgidata.getvalue('listname', '').strip().lower()
    owner    = cgidata.getvalue('owner', '').strip()
    try:
        autogen  = int(cgidata.getvalue('autogen', '0'))
    except ValueError:
        autogen = 0
    try:
        notify  = int(cgidata.getvalue('notify', '0'))
    except ValueError:
        notify = 0
    try:
        moderate = int(cgidata.getvalue('moderate',
                       mm_cfg.DEFAULT_DEFAULT_MEMBER_MODERATION))
    except ValueError:
        moderate = mm_cfg.DEFAULT_DEFAULT_MEMBER_MODERATION

    password = cgidata.getvalue('password', '').strip()
    confirm  = cgidata.getvalue('confirm', '').strip()
    auth     = cgidata.getvalue('auth', '').strip()
    langs    = cgidata.getvalue('langs', [mm_cfg.DEFAULT_SERVER_LANGUAGE])

    if not isinstance(langs, ListType):
        langs = [langs]
    # Sanity check
    safelistname = Utils.websafe(listname)
    if '@' in listname:
        request_creation(doc, cgidata,
                         _('List name must not include "@": %(safelistname)s'))
        return
    if Utils.list_exists(listname):
        # BAW: should we tell them the list already exists?  This could be
        # used to mine/guess the existance of non-advertised lists.  Then
        # again, that can be done in other ways already, so oh well.
        request_creation(doc, cgidata,
                         _('List already exists: %(safelistname)s'))
        return
    if not listname:
        request_creation(doc, cgidata,
                         _('You forgot to enter the list name'))
        return
    if not owner:
        request_creation(doc, cgidata,
                         _('You forgot to specify the list owner'))
        return

    if autogen:
        if password or confirm:
            request_creation(
                doc, cgidata,
                _('Leave the initial password (and confirmation) fields blank if you want Mailman to autogenerate the list passwords.'))
            return
        password = confirm = Utils.MakeRandomPassword(
            mm_cfg.ADMIN_PASSWORD_LENGTH)
    else:
        if password <> confirm:
            request_creation(doc, cgidata,
                             _('Initial list passwords do not match'))
            return
        if not password:
            request_creation(
                doc, cgidata,
                # The little <!-- ignore --> tag is used so that this string
                # differs from the one in bin/newlist.  The former is destined
                # for the web while the latter is destined for email, so they
                # must be different entries in the message catalog.
                _('The list password cannot be empty<!-- ignore -->'))
            return
    # The authorization password must be non-empty, and it must match either
    # the list creation password or the site admin password
    ok = 0
    if auth:
        ok = Utils.check_global_password(auth, 0)
        if not ok:
            ok = Utils.check_global_password(auth)
    if not ok:
        request_creation(
            doc, cgidata,
            _('You are not authorized to create new mailing lists'))
        return
    # Make sure the web hostname matches one of our virtual domains
    hostname = Utils.get_domain()
    if mm_cfg.VIRTUAL_HOST_OVERVIEW and \
           not mm_cfg.VIRTUAL_HOSTS.has_key(hostname):
        safehostname = Utils.websafe(hostname)
        request_creation(doc, cgidata,
                         _('Unknown virtual host: %(safehostname)s'))
        return
    emailhost = mm_cfg.VIRTUAL_HOSTS.get(hostname, mm_cfg.DEFAULT_EMAIL_HOST)
    # We've got all the data we need, so go ahead and try to create the list
    # See admin.py for why we need to set up the signal handler.
    mlist = MailList.MailList()

    def sigterm_handler(signum, frame, mlist=mlist):
        # Make sure the list gets unlocked...
        mlist.Unlock()
        # ...and ensure we exit, otherwise race conditions could cause us to
        # enter MailList.Save() while we're in the unlocked state, and that
        # could be bad!
        sys.exit(0)

    try:
        # Install the emergency shutdown signal handler
        signal.signal(signal.SIGTERM, sigterm_handler)

        pw = sha.new(password).hexdigest()
        # Guarantee that all newly created files have the proper permission.
        # proper group ownership should be assured by the autoconf script
        # enforcing that all directories have the group sticky bit set
        oldmask = os.umask(002)
        try:
            try:
                mlist.Create(listname, owner, pw, langs, emailhost)
            finally:
                os.umask(oldmask)
        except Errors.EmailAddressError, e:
            if e.args:
                s = Utils.websafe(e.args[0])
            else:
                s = Utils.websafe(owner)
            request_creation(doc, cgidata,
                             _('Bad owner email address: %(s)s'))
            return
        except Errors.MMListAlreadyExistsError:
            # MAS: List already exists so we don't need to websafe it.
            request_creation(doc, cgidata,
                             _('List already exists: %(listname)s'))
            return
        except Errors.BadListNameError, e:
            if e.args:
                s = Utils.websafe(e.args[0])
            else:
                s = Utils.websafe(listname)
            request_creation(doc, cgidata,
                             _('Illegal list name: %(s)s'))
            return
        except Errors.MMListError:
            request_creation(
                doc, cgidata,
                _('''Some unknown error occurred while creating the list. Please contact the site administrator for assistance.'''))
            return

        # Initialize the host_name and web_page_url attributes, based on
        # virtual hosting settings and the request environment variables.
        mlist.default_member_moderation = moderate
        mlist.web_page_url = mm_cfg.DEFAULT_URL_PATTERN % hostname
        mlist.host_name = emailhost
        mlist.Save()
    finally:
        # Now be sure to unlock the list.  It's okay if we get a signal here
        # because essentially, the signal handler will do the same thing.  And
        # unlocking is unconditional, so it's not an error if we unlock while
        # we're already unlocked.
        mlist.Unlock()

    # Now do the MTA-specific list creation tasks
    if mm_cfg.MTA:
        modname = 'Mailman.MTA.' + mm_cfg.MTA
        __import__(modname)
        sys.modules[modname].create(mlist, cgi=1)

    # And send the notice to the list owner.
    if notify:
        siteowner = Utils.get_site_email(mlist.host_name, 'owner')
        text = Utils.maketext(
            'newlist.txt',
            {'listname'    : listname,
             'password'    : password,
             'admin_url'   : mlist.GetScriptURL('admin', absolute=1),
             'listinfo_url': mlist.GetScriptURL('listinfo', absolute=1),
             'requestaddr' : mlist.GetRequestEmail(),
             'siteowner'   : siteowner,
             }, mlist=mlist)
        msg = Message.UserNotification(
            owner, siteowner,
            _('Your new mailing list: %(listname)s'),
            text, mlist.preferred_language)
        msg.send(mlist)

    # Success!
    listinfo_url = mlist.GetScriptURL('listinfo', absolute=1)
    admin_url = mlist.GetScriptURL('admin', absolute=1)
    create_url = Utils.ScriptURL('create')

    title = _('Mailing list creation results')
    doc.SetTitle(title)
    #doc.AddItem(Header(1, title))
    doc.addMessage(_('''You have successfully created the mailing list <tt>%(listname)s</tt>. A notification has been sent to the list owner <tt>%(owner)s</tt>.'''), css='class="message success strong"')
    doc.AddItem(Paragraph(_('You can now:')))
    ullist = UnorderedList()
    ullist.AddItem(Link(listinfo_url, _("Visit the list's info page")))
    ullist.AddItem(Link(admin_url, _("Visit the list's admin page")))
    ullist.AddItem(Link(create_url, _('Create another list')))
    doc.AddItem(ullist)


# Because the cgi module blows
class Dummy:
    def getvalue(self, name, default):
        return default
dummy = Dummy()



def request_creation(doc, cgidata=dummy, errmsg=None):
    # What virtual domain are we using?
    hostname = Utils.get_domain()
    # Set up the document
    title = _('Create a %(hostname)s Mailing List')
    table = Table()
    doc.SetTitle(title)
    # Add any error message
    if errmsg:
    	doc.AddItem(Div(Paragraph(errmsg)).Format(css='class="message error strong"'))

    # Add header
    doc.AddItem(Header(1, title))

    # Add description
    doc.AddItem(Paragraph(_('''You can create a new mailing list by entering the relevant information into the form below. The name of the mailing list will be used as the primary address for posting messages to the list, so it should be lowercased.  You will not be able to change this once the list is created.''')))

    doc.AddItem(Paragraph(_('''You also need to enter the email address of the initial list owner. Once the list is created, the list owner will be given notification, along with the initial list password.  The list owner will then be able to modify the password and add or remove additional list owners.''')))

    doc.AddItem(Paragraph(_('''If you want Mailman to automatically generate the initial list admin password, click on `Yes' in the autogenerate field below, and leave the initial list password fields empty.''')))

    doc.AddItem(Paragraph(_('''You must have the proper authorization to create new mailing lists. Each site should have a <em>list creator's</em> password, which you can enter in the field at the bottom.  Note that the site administrator's password can also be used for authentication.''')))

    # Build the form for the necessary input
    GREY = mm_cfg.WEB_ADMINITEM_COLOR
    form = Form(Utils.ScriptURL('create'))
    table = Table()

    table.AddRow([Header(3, _('List Identity'))])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, colspan=2, css='class="center"')

    listname = cgidata.getvalue('listname', '')
    # MAS: Don't websafe twice.  TextBox does it.
    table.AddRow([_('Name of list:'),
                   TextBox('listname', listname)])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    owner = cgidata.getvalue('owner', '')
    # MAS: Don't websafe twice.  TextBox does it.
    table.AddRow([_('Initial list owner address:'),
                   TextBox('owner', owner)])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    try:
        autogen = int(cgidata.getvalue('autogen', '0'))
    except ValueError:
        autogen = 0
    table.AddRow([_('Auto-generate initial list password?'),
                   RadioButtonArray('autogen', (_('No'), _('Yes')),
                                    checked=autogen,
                                    values=(0, 1))])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    safepasswd = Utils.websafe(cgidata.getvalue('password', ''))
    table.AddRow([_('Initial list password:'),
                   PasswordBox('password', safepasswd)])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    safeconfirm = Utils.websafe(cgidata.getvalue('confirm', ''))
    table.AddRow([_('Confirm initial password:'),
                   PasswordBox('confirm', safeconfirm)])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    try:
        notify = int(cgidata.getvalue('notify', '1'))
    except ValueError:
        notify = 1
    try:
        moderate = int(cgidata.getvalue('moderate',
                       mm_cfg.DEFAULT_DEFAULT_MEMBER_MODERATION))
    except ValueError:
        moderate = mm_cfg.DEFAULT_DEFAULT_MEMBER_MODERATION

    table.AddRow([Header(3,_('List Characteristics'))])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, colspan=2, css='class="center"')

    table.AddRow([
        _("""Should new members be quarantined before they are allowed to post unmoderated to this list? Answer <em>Yes</em> to hold new member postings for moderator approval by default."""),
        RadioButtonArray('moderate', (_('No'), _('Yes')),
                         checked=moderate,
                         values=(0,1))])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')
    # Create the table of initially supported languages, sorted on the long
    # name of the language.
    revmap = {}
    for key, (name, charset) in mm_cfg.LC_DESCRIPTIONS.items():
        revmap[_(name)] = key
    langnames = revmap.keys()
    langnames.sort()
    langs = []
    for name in langnames:
        langs.append(revmap[name])
    try:
        langi = langs.index(mm_cfg.DEFAULT_SERVER_LANGUAGE)
    except ValueError:
        # Someone must have deleted the servers's preferred language.  Could
        # be other trouble lurking!
        langi = 0
    # BAW: we should preserve the list of checked languages across form
    # invocations.
    checked = [0] * len(langs)
    checked[langi] = 1
    deflang = _(Utils.GetLanguageDescr(mm_cfg.DEFAULT_SERVER_LANGUAGE))
    table.AddRow([_('Initial list of supported languages.') +  
    	Paragraph(_('''Note that if you do not select at least one initial language, the list will use the server default language of %(deflang)s.''')).Format(),
                   CheckBoxArray('langs',
                                 [_(Utils.GetLanguageDescr(L)) for L in langs],
                                 checked=checked,
                                 values=langs)])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    table.AddRow([_('Send "list created" email to list owner?'),
                   RadioButtonArray('notify', (_('No'), _('Yes')),
                                    checked=notify,
                                    values=(0, 1))])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    table.AddCellInfo(table.GetCurrentRowIndex(), 0, colspan=2)
    table.AddRow([_("List creator's (authentication) password:"),
                   PasswordBox('auth')])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')

    table.AddRow([SubmitButton('doit', _('Create List')),
                  SubmitButton('clear', _('Clear Form'))])
    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="center"')
    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="center"')

    form.AddItem(table)
    doc.AddItem(form)
