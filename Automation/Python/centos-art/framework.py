# framework - The CentOS Artwork Repository framework structure.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
#------------------------------------------------------------
# $Id: framework.py 6045 2010-07-13 08:11:03Z al $
#-----------------------------------------------------------
"""
The CentOS Artwork Repository framework structure.

"""

import string
import os
import re

from repository import Repo

class Framework: 
    """ 
    This structure provides attributes and methods needed by CentOS
    artwork repository framework structures.
    """

    def __init__(self):
        self.fw = {}
        
    def find(self,id):
        """
        Return a dictionary object containing information about
        frameworks.  This function explores the repository structure
        looking for framework directories. Framework directories are
        defined as regular directories containing at least the
        subdirectory `tpl/' in its first level.
        """
        repo = Repo()
        rootdir = str(repo.abspath + repo.workline[0])
        template = re.compile('^.*/tpl/?$')
        for root, dirs, files in os.walk(rootdir):
            if id in root and template.match(root):
                print root
                #pathid = self.getPathId(root)
                #self.fw[pathid] = self.add(pathid)

    def getPathId(self, path):
        """
        Return the framework's path id by cleaning up its string path.
        """
        # Remove absolute path and workline from string path.
        # Remove theme directory from string path.
        # Remove template directory from string path.
        pass

    def add(self, pathid):
        """
        Return the framework's templates, translations and manuals paths.
        """
        templates = str('trunk/' + pathid + '/tpl')
        translations = str('trunk/Translations/' + pathid)
        manuals = str('trunk/Manuals/' + pathid)
        return (templates, translations, manuals)

    def list(self, id):
        """
        Print available frameworks and its paths.
        """
        self.find(id)
        for k, v in self.fw.iteritems():
            pathid = k
            templates, translations, manuals = v
            print '%12s: %s' % ('Id', pathid)
            print '%12s: %s' % ('Templates', templates)
            print '%12s: %s' % ('Translations', translations)
            print '%12s: %s' % ('Manuals', manuals)
            print '-'*66
