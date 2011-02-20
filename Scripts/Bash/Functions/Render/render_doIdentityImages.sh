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

    local FILE=''
    local OUTPUT=''
    local EXPORTID=''
    local TEMPLATE=''
    local TRANSLATION=''
    local EXTERNALFILE=''
    local EXTERNALFILES=''
    local COMMONDIRCOUNT=0

    # Export id used inside design templates. This value defines the
    # design area we want to export.
    EXPORTID='CENTOSARTWORK'

    # Start processing the base rendition list of FILES. Fun part
    # approching :-).
    for FILE in $FILES; do

        # Get common definitions for all identity rendition actions.
        render_getIdentityDefs

        # Check export id inside design templates.
        grep "id=\"$EXPORTID\"" $INSTANCE > /dev/null
        if [[ $? -gt 0 ]];then
            cli_printMessage "`eval_gettext "There is no export id (\\\$EXPORTID) inside \\\$TEMPLATE."`" "AsErrorLine"
            cli_printMessage '-' 'AsSeparatorLine'
            continue
        fi

        # Check existence of external files. In order for design
        # templates to point different artistic motifs, design
        # templates make use of external files that point to specific
        # artistic motif background images. If such external files
        # doesn't exist, print a message and stop script execution.
        # We cannot continue without background information.
        render_checkAbsolutePaths "$INSTANCE"

        # Render template instance and modify the inkscape output to
        # reduce the amount of characters used in description column
        # at final output.
        cli_printMessage "$(inkscape $INSTANCE \
            --export-id=$EXPORTID --export-png=${FILE}.png | sed -r \
            -e "s!Area !`gettext "Area"`: !" \
            -e "s!Background RRGGBBAA:!`gettext "Background"`: RRGGBBAA!" \
            -e "s!Bitmap saved as:!`gettext "Saved as"`:!")" \
            'AsRegularLine'

        # Remove template instance. 
        if [[ -a $INSTANCE ]];then
            rm $INSTANCE
        fi

        # Execute post-rendition actions.
        for ACTION in "${POSTACTIONS[@]}"; do

            case "$ACTION" in

                renderSyslinux* )
                    render_doIdentityImageSyslinux "${FILE}" "$ACTION"
                    ;;

                renderGrub* )
                    render_doIdentityImageGrub "${FILE}" "$ACTION"
                    ;;

                renderFormats:* )
                    render_doIdentityImageFormats "${FILE}" "$ACTION"
                    ;;

                groupByType:* )
                    render_doIdentityGroupByType "${FILE}" "$ACTION"
                    ;;

            esac

        done

        # Output separator line.
        cli_printMessage '-' 'AsSeparatorLine'

        # Apply last-rendition actions. As convenction, last-rendition
        # actions are applied after all images inside the same
        # directory structure have been produced. Notice that, in
        # order to apply last-rendition actions correctly,
        # centos-art.sh needs to "predict" what the last file in the
        # same directory structure would be. There is no magic here,
        # so we need to previously define which are the common
        # directory structures centos-art.sh could produce content
        # for inside an array variable. Later, using the index of that
        # array variable we could check the next item in the array
        # against the file being currently produced. If they match, we
        # haven't reached the end of the same directory structure, but
        # if they don't match, we do have reach the end of the same
        # directory structure and it is time for last-rendition
        # actions to be evaluated before go producing the next
        # directory structure in the list of files to process.
        if [[ $(dirname "$TEMPLATE") != ${COMMONDIRS[$(($COMMONDIRCOUNT + 1))]} ]];then

            # At this point centos-art.sh should be producing the last
            # file from the same unique directory structure, so,
            # before producing images for the next directory structure
            # lets evaluate last-rendition actions for the current
            # directory structure. 
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

                    renderBrands )
                        render_doIdentityImageBrands "${FILE}" "$ACTION"
                        ;;

                esac
            done
        fi

        # Increment common directory counter.
        COMMONDIRCOUNT=$(($COMMONDIRCOUNT + 1))

    done

}
