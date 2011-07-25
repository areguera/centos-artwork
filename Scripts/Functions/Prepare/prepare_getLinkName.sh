#!/bin/bash
#
# prepare_getLinkName.sh -- This function standardizes link name
# construction. For the construction sake, two arguments are required,
# one to now the file's base directory, and another holding the file's
# absolute path. With this information, the base directory is removed
# from file's absolute path and the remaining path is transformed into
# a file name where each slash is converted into minus sign. 
# 
# For example, if the following information is provided:
#
# ARG1: /home/centos/artwork/trunk/Identity/Brushes
# ARG2: /home/centos/artwork/trunk/Identity/Brushes/Corporate/symbol.gbr
#
# the result will be: `corporate-symbol.gbr'.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function prepare_getLinkName {

    local LINK_BASEDIR=''
    local LINK_ABSPATH=''
    local LINK_CHARSEP=''

    # Define absolute path to link's base directory.
    LINK_BASEDIR="$1"

    # Define absolute path to link's file.
    LINK_ABSPATH="$2"

    # Define character used as word separator on file name.
    LINK_CHARSEP='-'

    # Output link name.
    echo "$LINK_ABSPATH" | sed -r "s!^${LINK_BASEDIR}/!!" \
        | tr '[:upper:]' '[:lower:]' | sed -r "s!/!${LINK_CHARSEP}!g"

}
