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

from Mailman import mm_cfg
from Mailman.i18n import _
from Mailman.Gui.GUIBase import GUIBase



class Archive(GUIBase):
    def GetConfigCategory(self):
        return 'archive', _('Archiving')

    def GetConfigInfo(self, mlist, category, subcat=None):
        if category <> 'archive':
            return None
	return [
            '<p>' + _("List traffic archival policies.") + '</p>',

	    ('archive', mm_cfg.Toggle, (_('No'), _('Yes')), 0, 
	     _('Archive messages?')),

	    ('archive_private', mm_cfg.Radio, (_('Public'), _('Private')), 0,
             _('Is archive file source for public or private archival?')),

 	    ('archive_volume_frequency', mm_cfg.Radio, 
             (_('Yearly'), _('Monthly'), _('Quarterly'),
              _('Weekly'), _('Daily')),
             0,
 	     _('How often should a new archive volume be started?')),
	    ]
