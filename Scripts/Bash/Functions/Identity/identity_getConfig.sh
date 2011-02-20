#!/bin/bash
#
# identity_getConfig.sh -- This function checks/validates variables
# passed from artwork-specific pre-rendition configuration files.
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

function identity_getConfig {

    local POSTCOUNT=0
    local LASTCOUNT=0

    # Re-define action variables in separated array variables. Once
    # verification is done, we remove the BASE, POST, LAST parts from
    # action definition in order to have the plain name of function to
    # call.
    for ACTION in "${ACTIONS[@]}"; do

        # Define post-rendition actions.
        if [[ $ACTION =~ '^POST:' ]];then
            ACTION=$(identity_getConfigOption "$ACTION" '2-')
            POSTACTIONS[$POSTCOUNT]="$ACTION"
            POSTCOUNT=$(($POSTCOUNT + 1))

        # Define last-rendition actions.
        elif [[ $ACTION =~ '^LAST:' ]];then
            ACTION=$(identity_getConfigOption "$ACTION" '2-')
            LASTACTIONS[$LASTCOUNT]="$ACTION"
            LASTCOUNT=$(($LASTCOUNT + 1))
        fi

    done

    # Check post-rendition actions. Validation of post-rendition
    # actions is action-specific. So, validation of post-rendition
    # actions is not here, but inside action-specific functions. See
    # identity_renderImages and identity_renderIdentityTexts to see
    # validation of renderImage and renderText post-rendition actions,
    # respectively.

    # Sanitate theme model value using repository directory name
    # convenction.
    THEMEMODEL=$(cli_getRepoName "$THEMEMODEL" 'd')

    # Check theme model directory.
    cli_checkFiles "$(cli_getRepoTLDir)/Identity/Themes/Models/${THEMEMODEL}" 'd'

}
