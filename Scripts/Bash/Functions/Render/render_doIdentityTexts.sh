#!/bin/bash
#
# render_doIdentityTexts.sh -- This function provides text rendering
# feature to centos-art.sh script.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# $Id: render_doIdentityTexts.sh 83 2010-09-18 08:48:10Z al $
# ----------------------------------------------------------------------

function render_doIdentityTexts {

    # Start processing the base rendering list of FILES. Fun part
    # approching :-).
    for FILE in $FILES; do

        # Call identity shared variable definitions.
        render_getIdentityDefs

        # Render text file.
        cli_printMessage "`gettext "Saved as"`: $FILE"
        cat $INSTANCE > $FILE

        # Remove template instance.
        if [[ -a $INSTANCE ]];then
            rm $INSTANCE
        fi

        # Execute post-rendering actions.
        for ACTION in "${POSTACTIONS[@]}"; do

            case "$ACTION" in

                formatText:* )
                    render_doIdentityTextFormats "$FILE" "$ACTION"
                    ;;

             esac

        done

        echo '----------------------------------------------------------------------'

    done \
        | awk -f /home/centos/artwork/trunk/Scripts/Bash/Functions/Render/Styles/output_forRendering.awk

    # Execute last-rendering actions.
    #for ACTION in "${LASTACTIONS[@]}"; do
    #
    #    case "$ACTION" in
    #
    #    esac
    #
    #done

}
