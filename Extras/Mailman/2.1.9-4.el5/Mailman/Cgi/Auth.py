# Copyright (C) 1998,1999,2000,2001,2002 by the Free Software Foundation, Inc.
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

"""Common routines for logging in and logging out of the list administrator
and list moderator interface.
"""

from Mailman import mm_cfg
from Mailman import Utils
from Mailman import Errors
from Mailman.htmlformat import Link
from Mailman.htmlformat import HTMLFormatObject

from Mailman.i18n import _



class NotLoggedInError(Exception):
    """Exception raised when no matching admin cookie was found."""
    def __init__(self, message):
        Exception.__init__(self, message)
        self.message = message



def loginpage(mlist, scriptname, msg='', frontpage=None):
    url = mlist.GetScriptURL(scriptname)
    if frontpage:
        actionurl = url
    else:
        actionurl = Utils.GetRequestURI(url)
    # if msg:
    #   The format of msg comes from where it was originated. This way
    #   the msg can come with more than one design (ej. success or
    #   error). This is just a consideration because it seems that
    #   here the msg's value always be error design (failed logins in
    #   this case).
    #	msg = ...
    if scriptname == 'admindb':
        who = _('Moderator')
    else:
        who = _('Administrator')
    # Language stuff
    charset = Utils.GetCharSet(mlist.preferred_language)
    print 'Content-type: text/html; charset=' + charset + '\n\n'
    print Utils.maketext(
        'admlogin.html',
        {'listname': mlist.real_name,
         'path'    : actionurl,
         'message' : msg,
         'who'     : who,
         # Links on header section (errormsg)
         'listadmin_link': Link(Utils.ScriptURL('admin'), _('Administration')).Format(),
         'listinfo_link': Link(Utils.ScriptURL('listinfo'), _('General Information')).Format(),
         'errormsg_header': _('Mailing Lists'),
         }, mlist=mlist)
    print mlist.GetMailmanFooter()
    # We need to close some tags at this point
    print '</body>' + '\n' + '</html>'
