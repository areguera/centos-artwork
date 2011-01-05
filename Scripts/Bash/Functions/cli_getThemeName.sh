#!/bin/bash
#
# cli_getThemeName.sh -- This function interprets the current
# absolute path ---defined in action value variable--- to extract the
# theme name from it. If theme name is found on absolute path, this
# function returns an empty string. 
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

function cli_getThemeName {

    # Initialize regular expression pattern.
    local PATTERN=''

    if [[ $ACTIONVAL =~ '^/home/centos/artwork/trunk/.*$' ]];then

        # Define theme name for trunk development line.  There is no
        # enumeration schema for themes stored under trunk development
        # line. Inside trunk development line, theme names are stored
        # in directories immediatly under Themes/Motifs/ directory and
        # and can be named using letters and numbers.
        PATTERN='^.+/Identity/Themes/Motifs/([A-Za-z0-9]+)/.+$'

    elif [[ $ACTIONVAL =~ '^/home/centos/artwork/branches/.*$' ]];then

        # Define theme name for branches development line.  Branch
        # enumeration starts at number one and increments one unit
        # each time a new branch is created from the same trunk
        # development line.  If a branch is created from another brach
        # then a new directory is created inside the source branch,
        # using the same enumeration schema.  So, we may end up with
        # paths like branches/.../Themes/Motifs/Flame/1,
        # branches/.../Themes/Motifs/Flame/1/1,
        # branches/.../Themes/Motifs/Flame/1/2,
        # branches/.../Themes/Motifs/Flame/2,
        # branches/.../Themes/Motifs/Flame/2/1, and so on.  In all
        # previous examples the theme name holds the branch
        # enumeration schema too.
        PATTERN="^.+/Identity/Themes/Motifs/(([A-Za-z0-9]+)(/${RELEASE_FORMAT})+)/.+$"

    elif [[ $ACTIONVAL =~ '^/home/centos/artwork/tags/.*$' ]];then

        # Define theme name for tags frozen lines.  Branch enumeration
        # starts at number zero and increments one unit each time a
        # new tab is created from the same branch development line.
        # Tags are never created from trunk, if you need to create a
        # tag from trunk, you need to create a branch first and later
        # a tag. In contrast with branches enumeration schema, tags
        # enumeration schema uses dots. So, we may end up with paths
        # like tags/.../Themes/Motifs/Flame/1.0,
        # tags/.../Themes/Motifs/Flame/1.1.0,
        # tags/.../Themes/Motifs/Flame/1.2.0,
        # tags/.../Themes/Motifs/Flame/2.0,
        # tags/.../Themes/Motifs/Flame/2.1.0, and so on. In all
        # previous examples the theme name holds the branch
        # enumeration schame too.
        PATTERN="^.+/Identity/Themes/Motifs/(([A-Za-z0-9]+)(\.${RELEASE_FORMAT})+)/.+$"

    else
        cli_printMessage "`gettext "The working copy parent directory structure is incorrect."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Print theme name to standard output.
    if [[ $PATTERN != '' ]];then
        echo $ACTIONVAL | sed -r "s!${PATTERN}!\1!"
    fi

}
