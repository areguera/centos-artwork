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

"""MailList mixin class managing the password pseudo-options.
"""

from Mailman.i18n import _
from Mailman.Gui.GUIBase import GUIBase



class Passwords(GUIBase):
    def GetConfigCategory(self):
        return 'passwords', _('Passwords')

    def handleForm(self, mlist, category, subcat, cgidata, doc):
        # Nothing more needs to be done
        pass
