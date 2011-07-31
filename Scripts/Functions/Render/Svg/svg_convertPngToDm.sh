#!/bin/bash
#
# svg_convertPngToDm.sh -- This function standardize production of
# display managers (e.g., Gdm and Kdm). This function copies all files
# needed into a temporal directory, realize expansion of translation
# markers and packs all the files into a tar.gz package that is used
# for installation. This function must be used as last-rendition
# action for Gdm and Kdm directory specific base-rendition actions.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

function svg_convertPngToDm {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Initialize source and destination local variables.
    local SRC=''
    local DST=''

    # Initialize display manager type.
    local DM=$(${CLI_FUNCNAME}_getConfigOption "${ACTION}" '2')

    # Initialize screen resolutions used by display manager theme.
    # These are the different screen resolutions a display manager
    # theme is built for. The amount of screen resolution a display
    # manager theme can be built for is limited to the amount of
    # background files provided by the artistic motif used to build
    # the display manager theme.
    local RESOLUTION=''
    local RESOLUTIONS=$(${CLI_FUNCNAME}_getConfigOption "${ACTION}" '3')

    # Verify screen resolutions. We cannot produce display manager
    # theme if no screen resolution has been specified.
    if [[ "$RESOLUTIONS" == '' ]];then
        cli_printMessage "`gettext "There is no resolution information to process."`" --as-error-line
    fi

    # Initialize theme information we are going to build the display
    # manager theme for.
    local THEME=$(cli_getPathComponent $ACTIONVAL --motif)
    local THEME_NAME=$(cli_getPathComponent $ACTIONVAL --motif-name)

    # Initialize temporal directory where we collect all files needed
    # in order to create the tar.gz file. This intermediate step is
    # also needed in order to expand translation markers from XML and
    # Desktop definitions.
    local TMPDIR=$(cli_getTemporalFile 'dm')

    # Initialize source location for brands. This is the place where
    # brand information, needed to build the display manager theme, is
    # retrived from.
    local BRANDS=$(cli_getRepoTLDir)/Identity/Images/Brands

    # Initialize source location for artistic motif's backgrounds.
    # This is the place where background information needed to ubild
    # the display manager theme is retrived from. 
    local BGS=$(cli_getRepoTLDir)/Identity/Images/Themes/${THEME}/Backgrounds/Img/Png

    # Initialize file variables. File variables are used build and
    # process the file relation between source and target locations. 
    local FILE=''
    local FILES=''

    # Define major release from template.
    local MAJOR_RELEASE=$(cli_getPathComponent "$TEMPLATE" "--release-major")

    # Define file relation between source and target locations, based
    # on whether we are producing GDM or KDM. Use the colon character
    # (`:') as separator; on the left side we put the file's source
    # location and in the right side the file's target location.
    # Presently, both GDM and KDM are very similar on files with the
    # exception that GDM does use icons near actions buttons (e.g.,
    # shutdown, reboot, session, language) and KDM doesn't.
    case ${DM} in

        Gdm )
            FILES="\
            ${BRANDS}/Symbols/48/centos.png:centos-symbol.png
            ${BRANDS}/Types/White/111/centos-${MAJOR_RELEASE}-msg.png:centos-release.png
            ${OUTPUT}/screenshot.png:screenshot.png
            $(dirname $TEMPLATE)/GdmGreeterTheme.xml:${THEME_NAME}.xml
            $(dirname $TEMPLATE)/GdmGreeterTheme.desktop:GdmGreeterTheme.desktop
            $(dirname $TEMPLATE)/icon-language.png:icon-language.png
            $(dirname $TEMPLATE)/icon-reboot.png:icon-reboot.png
            $(dirname $TEMPLATE)/icon-session.png:icon-session.png
            $(dirname $TEMPLATE)/icon-shutdown.png:icon-shutdown.png
            "
            ;;
            
        Kdm )
            FILES="\
            ${BRANDS}/Symbols/48/centos.png:centos-symbol.png
            ${BRANDS}/Types/White/111/centos-${MAJOR_RELEASE}-msg.png:centos-release.png
            ${OUTPUT}/screenshot.png:screenshot.png
            $(dirname $TEMPLATE)/GdmGreeterTheme.xml:${THEME_NAME}.xml
            $(dirname $TEMPLATE)/GdmGreeterTheme.desktop:GdmGreeterTheme.desktop
            "
            ;;

        * )
            cli_printMessage "`eval_gettext "The \\\"\\\$DM\\\" display manager is not supported yet."`" --as-error-line
            ;;
    esac

    for FILE in $FILES;do

        # Define source location.
        SRC=$(echo $FILE | cut -d: -f1)

        # Define target location.
        DST=${TMPDIR}/${THEME_NAME}/$(echo $FILE | cut -d: -f2)

        # Verify source files.
        cli_checkFiles $SRC

        # Verify parent directory for target file.
        if [[ ! -d $(dirname $DST) ]];then
            mkdir -p $(dirname $DST)
        fi

        # Copy files from source to target location.
        cp ${SRC} ${DST}

        # Expand translation markers.
        if [[ ${DST} =~ "\.(xml|desktop)$"  ]];then
            cli_expandTMarkers "${DST}"
        fi

    done

    # Move into temporal directory.
    pushd $TMPDIR > /dev/null

    for RESOLUTION in $RESOLUTIONS;do

        # Verify background information. If it doesn't exist go on
        # with the next one in the list.
        if [[ ! -f $BGS/${RESOLUTION}-final.png ]];then
            continue
        fi

        # Print action message.
        if [[ -f ${RESOLUTION}.tar.gz ]];then
            cli_printMessage "${OUTPUT}/${RESOLUTION}.tar.gz" --as-updating-line
        else
            cli_printMessage "${OUTPUT}/${RESOLUTION}.tar.gz" --as-creating-line
        fi

        # Copy background information.
        cp $BGS/${RESOLUTION}-final.png ${THEME_NAME}/background.png

        # Create tar.gz file.
        tar -czf ${RESOLUTION}.tar.gz ${THEME_NAME}

        # Move from temporal directory to its final location.
        mv ${RESOLUTION}.tar.gz ${OUTPUT}

    done

    # Return to where we were initially.
    popd > /dev/null

    # Remove temporal directory.
    rm -r ${TMPDIR}

}
