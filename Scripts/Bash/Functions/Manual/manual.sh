#!/bin/bash
#
# manual.sh -- This function provides documentation features to
# centos-art.sh script. Here we initialize documentation variables and
# call manual_getActions functions.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
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
    
function manual {

    # Define default value to target flag. The target flag (--to)
    # controls final destination used by copy related actions.
    local FLAG_TO=''

    # Define documentation base directory structure.
    MANUALS_DIR[0]='/home/centos/artwork/trunk/Manuals'
    MANUALS_DIR[1]=${MANUALS_DIR[0]}/$(cli_getCurrentLocale)
    MANUALS_DIR[2]=${MANUALS_DIR[1]}/Texinfo/Repository
    MANUALS_DIR[3]=${MANUALS_DIR[1]}/Info/Repository
    MANUALS_DIR[4]=${MANUALS_DIR[1]}/Html/Repository
    MANUALS_DIR[5]=${MANUALS_DIR[1]}/Plaintext/Repository
    MANUALS_DIR[7]=${MANUALS_DIR[1]}/Pdf/Repository
    
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
    
    # Define command-line interface.
    manual_getActions

}
