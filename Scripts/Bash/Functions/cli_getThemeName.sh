#!/bin/bash
#
# cli_getThemeName.sh -- This function manipulates the current
# absolute path to extract the theme name from it. If there is no
# theme in the path, this function returns an empty string.
#
# Theme names are stored in directories immediatly under
# Themes/Motifs/ directory and and can be named using letters and
# numbers. When rendering themes under branches/ directory structure,
# theme names are also built using the branch numeration the theme is
# being rendered for.
#
# Branch enumeration start at number one and increment one unit each
# time a new branch is created from the same trunk development line.
# If a branch is created from another brach then a new directory is
# created inside the source branch, using the same enumeration schema.
# So, we may end up with paths like
# branches/.../Themes/Motifs/Flame/1,
# branches/.../Themes/Motifs/Flame/1/1,
# branches/.../Themes/Motifs/Flame/1/2,
# branches/.../Themes/Motifs/Flame/2,
# branches/.../Themes/Motifs/Flame/2/1, and so on.  In all previous
# examples the theme name holds the branch enumeration schema too.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function cli_getThemeName {

    local THEMENAME=''

    # Define theme name from action value.
    if [[ $ACTIONVAL =~ '^.+/Themes/Motifs/([A-Za-z0-9-]+)/.+$' ]];then
        THEMENAME=$(echo $ACTIONVAL | sed -r \
            -e "s!^.+/Themes/Motifs/([A-Za-z0-9-]+(/${RELEASE_FORMAT})*)/.+!\1!") 
    fi

    # Print theme name to standard output.
    echo $THEMENAME

}
