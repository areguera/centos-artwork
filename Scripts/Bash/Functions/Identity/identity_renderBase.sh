#!/bin/bash
#
# identity_renderBase.sh -- This function initiates base rendition
# using pre-rendition configuration files.
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

function identity_renderBase {

    local FILE=''
    local FILES=''
    local OUTPUT=''
    local EXPORTID=''
    local TEMPLATE=''
    local COMMONDIR=''
    local PARENTDIR=''
    local TRANSLATION=''
    local EXTERNALFILE=''
    local EXTERNALFILES=''
    local COMMONDIRCOUNT=0
    local -a COMMONDIRS

    # Redefine parent directory for current workplace.
    PARENTDIR=$(basename "$ACTIONVAL")

    # Define base location of template files.
    identity_getDirTemplate
    
    # Define list of files to process. 
    FILES=$(cli_getFilesList "${TEMPLATE}" "${FLAG_FILTER}.*\.(svgz|svg)")

    # Set action preamble.
    # Do not print action preamble here, it prevents massive rendition.

    # Define common absolute paths in order to know when centos-art.sh
    # is leaving a directory structure and entering into another. This
    # information is required in order for centos-art.sh to know when
    # to apply last-rendition actions.
    for COMMONDIR in $(dirname "$FILES" | sort | uniq);do
        COMMONDIRS[$COMMONDIRCOUNT]=$(dirname "$COMMONDIR")
        COMMONDIRCOUNT=$(($COMMONDIRCOUNT + 1))
    done

    # Define export id used inside design templates. This value
    # defines the design area we want to export.
    EXPORTID='CENTOSARTWORK'

    # Start processing the base rendition list of FILES. Fun part
    # approching :-).
    for FILE in $FILES; do

        # Define final location of translation file.
        TRANSLATION=$(dirname $FILE \
           | sed -r 's!/trunk/(Identity/)!/trunk/Locales/\1!')/$(cli_getCurrentLocale).po

        # Print final location of translation file.
        if [[ ! -f "$TRANSLATION" ]];then
            cli_printMessage "`gettext "None"`" "AsTranslationLine"
        else
            cli_printMessage "$TRANSLATION" 'AsTranslationLine'
        fi

        # Define final location of template file.
        TEMPLATE=${FILE}

        # Print final location of template file.
        if [[ ! -f "$TEMPLATE" ]];then
            cli_printMessage "`gettext "None"`" "AsDesignLine"
        else
            cli_printMessage "$TEMPLATE" 'AsDesignLine'
        fi
 
        # Define final location of output directory.
        identity_getDirOutput

        # Get relative path to file. The path string (stored in FILE)
        # has two parts: 1. the variable path and 2. the common path.
        # The variable path is before the common point in the path
        # string. The common path is after the common point in the
        # path string. The common point is the name of the parent
        # directory (stored in PARENTDIR).
        #
        # trunk/Locales/Identity/.../Firstboot/3/splash-small.svg
        # -------------------------^| the     |^------------^
        # variable path             | common  |    common path
        # -------------------------v| point   |    v------------v
        # trunk/Identity/Themes/M.../Firstboot/Img/3/splash-small.png
        #
        # What we do here is remove the varibale path, the common
        # point, and the file extension parts in the string holding
        # the path retrived from design models directory structure.
        # Then we use the common path as relative path to store the
        # the final image file.
        #
        # The file extension is removed from the common path because
        # it is set when we create the final image file. This
        # configuration let us use different extensions for the same
        # file name.
        #
        # When we render using renderImage function, the structure of
        # files under the output directory will be the same used after
        # the common point in the related design model directory
        # structure.
        FILE=$(echo ${FILE} \
            | sed -r "s!.*${PARENTDIR}/!!" \
            | sed -r "s/\.(svgz|svg)$//")

        # Define absolute path to final file (without extension).
        FILE=${OUTPUT}/$(basename "${FILE}")

        # Define instance name from design model.
        INSTANCE=$(cli_getTemporalFile ${TEMPLATE})

        if [[ -f ${TRANSLATION} ]];then

            # Create translated instance from design model.
            /usr/bin/xml2po -p ${TRANSLATION} ${TEMPLATE} > ${INSTANCE}

            # Remove .xml2po.mo temporal file.
            if [[ -f ${PWD}/.xml2po.mo ]];then
                rm ${PWD}/.xml2po.mo
            fi

        else

            # Create non-translated instance form design model.
            /bin/cat ${TEMPLATE} > ${INSTANCE}    

        fi

        # Apply replacement of translation markers to design model
        # translated instance.
        cli_replaceTMarkers ${INSTANCE}

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
        identity_checkAbsolutePaths "$INSTANCE"

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
                    identity_renderSyslinux "${FILE}" "$ACTION"
                    ;;

                renderGrub* )
                    identity_renderGrub "${FILE}" "$ACTION"
                    ;;

                renderFormats:* )
                    identity_renderFormats "${FILE}" "$ACTION"
                    ;;

                groupByType:* )
                    identity_renderGroupByType "${FILE}" "$ACTION"
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
                        identity_renderKsplash
                        ;;

                    renderDm:* )
                        identity_renderDm "$ACTION"
                        ;;

                    groupByType:* )
                        identity_renderGroupByType "$ACTION"
                        ;;

                    renderBrands )
                        identity_renderBrands "${FILE}" "$ACTION"
                        ;;

                esac
            done
        fi

        # Increment common directory counter.
        COMMONDIRCOUNT=$(($COMMONDIRCOUNT + 1))

    done
}
