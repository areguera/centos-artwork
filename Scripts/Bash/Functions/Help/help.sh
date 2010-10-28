#!/bin/bash
#
# help.sh -- This function provides documentation features to
# centos-art.sh script. Here we initialize documentation variables and
# call help_getActions functions.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------
    
function help {
    
    # Define documentation base directory structure.
    MANUALS_DIR[0]='/home/centos/artwork/trunk/Manuals'
    MANUALS_DIR[1]=${MANUALS_DIR[0]}/$(cli_getCurrentLocale)
    MANUALS_DIR[2]=${MANUALS_DIR[1]}/Texinfo/Repository
    MANUALS_DIR[3]=${MANUALS_DIR[1]}/Info/Repository
    MANUALS_DIR[4]=${MANUALS_DIR[1]}/Html/Repository
    MANUALS_DIR[5]=${MANUALS_DIR[1]}/Plaintext/Repository
    
    # Define template directory for texinfo files.
    MANUALS_DIR[6]=${MANUALS_DIR[0]}/en/Texinfo/Tpl
    
    # Define location for texinfo files.
    MANUALS_FILE[1]=${MANUALS_DIR[2]}/repository.texi
    MANUALS_FILE[2]=${MANUALS_DIR[2]}/repository-chapter-menu.texi
    MANUALS_FILE[3]=${MANUALS_DIR[2]}/repository-chapter-nodes.texi
    
    # Define location for texinfo output files.
    MANUALS_FILE[4]=${MANUALS_DIR[3]}/repository.info
    MANUALS_FILE[5]=${MANUALS_DIR[5]}/repository.txt
    
    # Define chapter's file names.
    MANUALS_FILE[6]=chapter.texi
    MANUALS_FILE[7]=chapter-intro.texi
    MANUALS_FILE[8]=chapter-menu.texi
    MANUALS_FILE[9]=chapter-nodes.texi
    
    # Define texinfo template to initialize new sections.
    MANUALS_FILE[10]=${MANUALS_DIR[6]}/repository-chapter-section.texi
    MANUALS_FILE[11]=${MANUALS_DIR[2]}/repository-chapter-index.texi
    
    # Define documentation entry.
    ENTRY=$(help_getEntry)
    
    # Define directory used to store chapter's documentation entries.
    # At this point, we need to take a desition about
    # documentation-design, in order to answer the question: How do we
    # assign chapters, sections and subsections automatically, based
    # on the repository structure? 
    #
    # One solution would be: to use three chapters only to represent
    # the repository's first level structure (i.e., trunk,
    # branches, and tags) and handle everything else as sections. Sub
    # and subsub section will not have their own files, they will be
    # written inside section files instead.
    ENTRYCHAPTER=$(echo $ENTRY | cut -d / -f-10)
    
    # Define chapter name for this documentation entry.
    CHAPTERNAME=$(basename $ENTRYCHAPTER)
    
    # Initialize documentation functions and path patterns.
    help_getActions

}
