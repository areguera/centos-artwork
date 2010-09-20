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
# $Id: repository.py 6036 2010-07-09 21:20:27Z al $
#-----------------------------------------------------------
"""
The CentOS Artwork Repository.

The CentOS Artwork Repository is a subversion-based file structure
organized to produce the CentOS project's corporate visual identity.
The CentOS Project corporate visual identity is the ``persona'' of the
organization known as The CentOS Project.  

The CentOS Project corporate visual identity plays a significant role
in the way the CentOS Project, as organization, presents itself to
both internal and external stakeholders. In general terms, the CentOS
Project corporate visual identity expresses the values and ambitions
of the CentOS Project organization, its business, and its
characteristics.  The CentOS Project corporate visual identity
provides visibility, recognizability, reputation, structure and
identification to the CentOS Project organization by means of
corporate design, corporate communication, and corporate behaviour.

The CentOS Project settles down its corporate visual identity on a
``monolithic corporate visual identity structure''. In this structure
The CentOS Project uses one unique name and one unique visual style in
all its manifestations. 

Inside CentOS Artwork Repository, visual manifestations are organized
in the categories: distributions, websites, and promotion.

Inside CentOS Artwork Repository, corporate visual identity is
oraganized in the work lines: graphic-design, translations, and
programming (scripts). Each work line is a group of people that, based
on standard patterns, can work indepently and coordinated one another.

In the structure just mentioned, graphic designers provide the design
models and visual styles (motifs) needed to cover each each visual
manifestation; translators create the language-specific contents; and
programmers gear everything together in order to produce specific
design models on various visual styles, languages, and major releases,
automatically.
"""

class Repo:
    """ 
    This class provides attributes and methods needed to implement the
    base repository structure.
    """

    def __init__(self):
        # Define repository's working copy absolute path. 
        self.abspath = '/home/centos/artwork/'
        # Define repository's working line.
        self.workline = ('trunk/', 'branches/', 'tags/')
