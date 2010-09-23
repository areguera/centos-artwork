#!/bin/bash
#
# render_checkConfig.sh -- This function checks/validates variables
# passed from artwork-specific pre-rendering configuration files.
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

function render_checkConfig {

    # Check base rendering action.
    if [[ ${ACTIONS[0]} == '' ]] \
        || [[ ! ${ACTIONS[0]} =~ '^(renderImage|renderText)$' ]];then

        cli_printMessage "`gettext "The ACTIONS[0] variable only supports the \\\"renderImage\\\" or \\\"renderText\\\" value."`"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"

    fi

    # Check post-rendering actions. Validation of post-rendering
    # actions is action-specific. So, validation of post-rendering
    # actions is not here, but inside action-specific functions. See
    # render_doIdentityImages and render_doIdentityTexts to see
    # validation of renderImage and renderText post-rendering actions,
    # respectively.

    # Re-define matching list to reduce the amount of empty spaces.
    MATCHINGLIST=$(echo "$MATCHINGLIST" | tr -s '  ' | sed 's!^ !!')

    # Re-define theme model value using repository directory name
    # convenction.
    THEMEMODEL=$(cli_getRepoName 'd' "$THEMEMODEL")

    # Check theme model name.
    if [[ $THEMEMODEL == '' ]] \
        || [[ ! -d "/home/centos/artwork/trunk/Identity/Themes/Models/$THEMEMODEL" ]];then

        cli_printMessage "`eval_gettext "The \\\"\\\$THEMEMODEL\\\" theme model doesn't exist."`"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"

    fi

}
