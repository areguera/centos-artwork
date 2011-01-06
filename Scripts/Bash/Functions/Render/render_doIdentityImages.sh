#!/bin/bash
#
# render_doIdentityImages.sh -- This function renders image-based
# identity contents.
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

function render_doIdentityImages {

    local EXPORTID=''
    local EXTERNALFILES=''
    local EXTERNALFILE=''

    # Export id used inside design templates. This value defines the
    # design area we want to export.
    EXPORTID='CENTOSARTWORK'

    # Start processing the base rendition list of FILES. Fun part
    # approching :-).
    for FILE in $FILES; do

        # Call shared variable re-definitions.
        render_getIdentityDefs

        # Check export id inside design templates.
        grep "id=\"$EXPORTID\"" $INSTANCE > /dev/null
        if [[ $? -gt 0 ]];then
            cli_printMessage "`eval_gettext "The export id (\\\$EXPORTID) was not found inside \\\$TEMPLATE."`" "AsErrorLine"
            cli_printMessage '-' 'AsSeparatorLine'
            continue
        fi

        # Define final image width. If FILE name is a number, asume it
        # as the width value of the image being rendered. Otherwise
        # use design template default width value.
        WIDTH=$(basename $FILE)
        if [[ $WIDTH =~ '^[0-9]+$' ]];then
            WIDTH="--export-width=$WIDTH" 
        else
            WIDTH=''
        fi
        
        # Check external files existence. External files are used when
        # reusing background images inside design templates. In these
        # cases external files point to images which contain the
        # appropriate background image used by design template to
        # propagate theme's artistic motif.
        EXTERNALFILES=$(egrep '(xlink:href|sodipodi:absref)="/home/centos/artwork/' $INSTANCE \
            | sed -r 's!^[[:space:]]+!!' \
            | sed -r 's!^(xlink:href|sodipodi:absref)="!!' \
            | sed -r 's!".*$!!' | sort | uniq)
        for EXTERNALFILE in $EXTERNALFILES;do
            cli_checkFiles $EXTERNALFILE
        done

        # Render template instance and modify the inkscape output to
        # reduce the amount of characters used in description column
        # at final output.
        inkscape $INSTANCE \
            --export-id=$EXPORTID $WIDTH \
            --export-png=$FILE.png \
                | sed -r -e "s!Area !`gettext "Area"`: !" \
                -e "s!Background RRGGBBAA:!`gettext "Background"`: RRGGBBAA!" \
                -e "s!Bitmap saved as:.+/(trunk|branches|tags)/!`gettext "Saved as"`: \1/!"

        # Remove template instance. 
        if [[ -a $INSTANCE ]];then
            rm $INSTANCE
        fi

        # Execute post-rendition actions.
        for ACTION in "${POSTACTIONS[@]}"; do

            case "$ACTION" in

                renderSyslinux* )
                    render_doIdentityImageSyslinux $FILE "$ACTION"
                    ;;

                renderGrub* )
                    render_doIdentityImageGrub $FILE "$ACTION"
                    ;;

                renderFormats:* )
                    render_doIdentityImageFormats $FILE "$ACTION"
                    ;;

                renderBrands:* )
                    render_doIdentityImageBrands "$FILE" "$ACTION"
                    ;;

                groupByType:* )
                    render_doIdentityGroupByType "$FILE" "$ACTION"
                    ;;

            esac

        done

        # Output separator line.
        cli_printMessage '-' 'AsSeparatorLine'

    done \
        | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk

    # Define and execute posible last-rendition actions for image
    # rendeirng base action.
    for ACTION in "${LASTACTIONS[@]}"; do

        case "$ACTION" in

            renderKSplash )
                render_doIdentityImageKsplash
                ;;

            renderDm:* )
                render_doIdentityImageDm "$ACTION"
                ;;

            groupByType:* )
                render_doIdentityGroupByType "$ACTION"
                ;;

        esac

    done

}
