# Copyright (C) 2001,2002 by the Free Software Foundation, Inc.
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

"""Remove/delete mailing lists through the web.
"""

import os
import cgi
import sys
import errno
import shutil

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
    doc = Document()
    doc.set_language(mm_cfg.DEFAULT_SERVER_LANGUAGE)

    cgidata = cgi.FieldStorage()
    parts = Utils.GetPathPieces()

    if not parts:
        # Bad URL specification
        title = _('Bad URL specification')
        doc.SetTitle(title)
        doc.addMessage('The specified URL is not valid.', title, 'class="message error"')
	doc.AddItem(MailmanLogo())
        print doc.Format()
        syslog('error', 'Bad URL specification: %s', parts)
        return
        
    listname = parts[0].lower()
    try:
        mlist = MailList.MailList(listname, lock=0)
    except Errors.MMListError, e:
        # Avoid cross-site scripting attacks
        safelistname = Utils.websafe(listname)
        title = _('Nos such list')
        doc.SetTitle(title)
        doc.addMessage(
		_('The <tt>%(safelistname)s</tt> mailing list does not exist.'), 
		title, 
		css='class="message error"')
	doc.AddItem(MailmanLogo())
        print doc.Format()
        syslog('error', 'No such list "%s": %s\n', listname, e)
        return

    # Now that we have a valid mailing list, set the language
    i18n.set_language(mlist.preferred_language)
    doc.set_language(mlist.preferred_language)

    # Be sure the list owners are not sneaking around!
    if not mm_cfg.OWNERS_CAN_DELETE_THEIR_OWN_LISTS:
        title = _("You're being a sneaky list owner!")
        doc.SetTitle(title)
        doc.addMessage(title, css='class="message error strong"')
	doc.AddItem(mlist.GetMailmanFooter())
        print doc.Format()
        syslog('mischief', 'Attempt to sneakily delete a list: %s', listname)
        return

    if cgidata.has_key('doit'):
        process_request(doc, cgidata, mlist)
        print doc.Format()
        return

    request_deletion(doc, mlist)

    # Always add the footer and print the document
    doc.AddItem(mlist.GetMailmanFooter())
    print doc.Format()



def process_request(doc, cgidata, mlist):
    password = cgidata.getvalue('password', '').strip()
    try:
        delarchives = int(cgidata.getvalue('delarchives', '0'))
    except ValueError:
        delarchives = 0

    # Removing a list is limited to the list-creator (a.k.a. list-destroyer),
    # the list-admin, or the site-admin.  Don't use WebAuthenticate here
    # because we want to be sure the actual typed password is valid, not some
    # password sitting in a cookie.
    if mlist.Authenticate((mm_cfg.AuthCreator,
                           mm_cfg.AuthListAdmin,
                           mm_cfg.AuthSiteAdmin),
                          password) == mm_cfg.UnAuthorized:
        request_deletion(
            doc, mlist,
            _('You are not authorized to delete this mailing list'))
	# Add the footer to properly close the tags.	
        doc.AddItem(mlist.GetMailmanFooter())
        return

    # Do the MTA-specific list deletion tasks
    if mm_cfg.MTA:
        modname = 'Mailman.MTA.' + mm_cfg.MTA
        __import__(modname)
        sys.modules[modname].remove(mlist, cgi=1)
    
    REMOVABLES = ['lists/%s']

    if delarchives:
        REMOVABLES.extend(['archives/private/%s',
                           'archives/private/%s.mbox',
                           'archives/public/%s',
                           'archives/public/%s.mbox',
                           ])

    problems = 0
    listname = mlist.internal_name()
    for dirtmpl in REMOVABLES:
        dir = os.path.join(mm_cfg.VAR_PREFIX, dirtmpl % listname)
        if os.path.islink(dir):
            try:
                os.unlink(dir)
            except OSError, e:
                if e.errno not in (errno.EACCES, errno.EPERM): raise
                problems += 1
                syslog('error',
                       'link %s not deleted due to permission problems',
                       dir)
        elif os.path.isdir(dir):
            try:
                shutil.rmtree(dir)
            except OSError, e:
                if e.errno not in (errno.EACCES, errno.EPERM): raise
                problems += 1
                syslog('error',
                       'directory %s not deleted due to permission problems',
                       dir)

    title = _('Mailing list deletion results')
    doc.SetTitle(title)
    container = Container()
    #container.AddItem(Header(1, title))
    if not problems:
        container.addMessage(_('''You have successfully deleted the mailing list <tt>%(listname)s</tt>.'''), 
		css='class="message success strong"')
    else:
        sitelist = Utils.get_site_email(mlist.host_name)
        container.AddItem(Paragraph(_('''There were some problems deleting the mailing list <tt>%(listname)s</tt>. Contact your site administrator at %(sitelist)s for details.''')))
    doc.AddItem(container)
    doc.AddItem(Paragraph(
    		_('Return to the ') +
                Link(Utils.ScriptURL('listinfo'),
                     _('general list overview')).Format() +
    		'<br />' + _('Return to the ') +
                Link(Utils.ScriptURL('admin'),
                     _('administrative list overview')).Format()))
    doc.AddItem(MailmanLogo())



def request_deletion(doc, mlist, errmsg=None):
    realname = mlist.real_name
    title = _('Permanently remove mailing list %(realname)s')
    doc.SetTitle(title)

    container = Container()

    # Add any error message as first element in the page
    if errmsg:
        container.addMessage(errmsg, css='class="message error strong"')

    # Add header as second element in the page
    container.AddItem(Header(1, title))

    container.AddItem(Paragraph(_("""This page allows you as the list owner, to permanent remove this mailing list from the system. <strong>This action is not undoable</strong> so you should undertake it only if you are absolutely sure this mailing list has served its purpose and is no longer necessary.""")))

    container.AddItem(Paragraph(_('''Note that no warning will be sent to your list members and after this action, any subsequent messages sent to the mailing list, or any of its administrative addreses will bounce.''')))

    container.AddItem(Paragraph(_('''You also have the option of removing the archives for this mailing list at this time. It is almost always recommended that you do <strong>not</strong> remove the archives, since they serve as the historical record of your mailing list.''')))

    container.AddItem(Paragraph(_('''For your safety, you will be asked to reconfirm the list password.''')))

    form = Form(mlist.GetScriptURL('rmlist'))
    ftable = Table()
    
    ftable.AddRow([_('List password:'), PasswordBox('password')])
    ftable.AddCellInfo(ftable.GetCurrentRowIndex(), 0, css='class="description"')
    ftable.AddCellInfo(ftable.GetCurrentRowIndex(), 1, css='class="value"')

    ftable.AddRow([_('Also delete archives?'),
                   RadioButtonArray('delarchives', (_('No'), _('Yes')),
                                    checked=0, values=(0, 1))])
    ftable.AddCellInfo(ftable.GetCurrentRowIndex(), 0, css='class="description"')
    ftable.AddCellInfo(ftable.GetCurrentRowIndex(), 1, css='class="value"')

    ftable.AddRow([Link(
        mlist.GetScriptURL('admin'),
        _('<strong>Cancel</strong> and return to list administration')).Format()])
    ftable.AddCellInfo(ftable.GetCurrentRowIndex(), 0, colspan=2, css='class="center"')

    ftable.AddRow([SubmitButton('doit', _('Delete this list'))])
    ftable.AddCellInfo(ftable.GetCurrentRowIndex(), 0, colspan=2, css='class="mm_submit"')

    form.AddItem(ftable)
    container.AddItem(form)
    doc.AddItem(container)
