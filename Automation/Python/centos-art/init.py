#!/usr/bin/python
#
# centos-art-cli.py - The CentOS Artwork Repository ToolBox (art)
#                     command line interface.
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
# $Id: centos-art.py 6245 2010-08-12 14:44:19Z al $
#-----------------------------------------------------------
"""
The CentOS Artwork Repository Toolbox (art) command line interface.

This script provides a command line interface (cli) to operate local
working copies of CentOS Artwork Repository. Most of the actions this
script can perform relay on CentOS Artwork Repository files and
directories standard structure. The CentOS Artwork Repository standard
structure is described inside the `Repo' class as docstrings. The
`Repo' class is available in the repository.py file.

In order to make this script available along CentOS Artwork Repository
you need create a link to the file art-cli.py inside /home/centos/bin/
directory. For example:

    $ mkdir /home/centos/bin/
    $ cd /home/centos/bin/
    $ ln -s /home/centos/artwork/trunk/Scripts/Python/centos-art-cli.py centos-art

Note that we used the `centos' lower-case word as username. This is a
convention[1] that let us create a common absolute path for people to
store the CentOS Artwork Repository working copy. 

    [1:] Absolute paths are used Inkscape to import raster images
    inside SVG files--well, to link them really.  If everyone
    downloading a working copy of CentOS Artwork Repository uses its
    one absolute path there is no way to garantee that all images
    imported inside SVG design templates will be displayed correctly
    in all downloaded working copies. That is because, there is no way
    to garantee that everyone's working copy is placed in the same
    absolute path the raster image was imported the first time. So the
    absolute path name convenction is needed.

The centos-art-cli.py script let you to:

    * Render images and texts using common design models and
      translations.

    * Navigate the repository structure.

    * Get information about repository structures.

    * Test themes.

"""

#from repository import Repo
from framework import Framework

def main():
    fw = Framework()
    fw.list('Brands')

if __name__ == '__main__': main()
