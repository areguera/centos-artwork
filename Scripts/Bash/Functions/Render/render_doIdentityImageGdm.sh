#!/bin/bash
#
# render_doIdentityImageGdm.sh -- This function creates gdm tar.gz
# files for different motifs, screen resolutions and major releases of
# CentOS distribution.
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

function render_doIdentityImageGdm {

    local RESOLUTIONS=''
    local VERSIONS=''
    local TPL=''
    local BGS=''
    local TMP=''
    local SYMBOL=''

    # Get screen resolutions passed from render.conf.sh pre-rendering
    # configuration script.
    RESOLUTIONS=$(echo "$1" | cut -d: -f2-)

    # Sanitate screen resolutions.
    RESOLUTIONS=$(echo "${RESOLUTIONS}" \
        | sed -r 's!^ *!!g' \
        | sed -r 's!( |:|,|;) *! !g' \
        | sed -r 's! *$!!g')

    # Check sanitated screen resolutions.
    if [[ "$RESOLUTIONS" == "" ]];then
        cli_printMessage "`gettext "render_doIdentityImageGdm: There is no resolution information to process."`"
        cli_printMessage $(caller) "AsToKnowMoreLine"
    fi

    # Define release-specific directories we want to produce gdm for.
    VERSIONS=$(find $OPTIONVAL -regextype posix-egrep \
        -maxdepth 1 -type d -regex "^.*/${RELEASE_FORMAT}$" \
        | egrep $REGEX)

    # Define directory where design models (e.g., GdmGreeterTheme.xml,
    # GdmGreeterTheme.desktop) are stored.
    TPL=/home/centos/artwork/trunk/Identity/Themes/Models/${THEMEMODEL}/Distro/BootUp/GDM/

    # Define directory holding backgrounds.
    BGS=/home/centos/artwork/trunk/Identity/Themes/Motifs/$(cli_getThemeName)/Backgrounds/Img

    # Define directory where temporal files are stored.
    TMP=$(cli_getThemeName)

    # Define png image file used as CentOS symbol. We are using the
    # symbol at 48x48 pixels.
    SYMBOL=/home/centos/artwork/trunk/Identity/Brands/Img/CentOS/Symbol/5c-a/48.png
    cli_checkFiles $SYMBOL 'f'

    for VERSION in $VERSIONS;do

        VERSION=$(basename $VERSION)

        # Define directory to store release-specific images.
        IMG=$OPTIONVAL/$VERSION/Img

        # Define directory to store release-specific tar.gz files. 
        TGZ=$OPTIONVAL/$VERSION/Tgz

        # Check existence of release-specific directory.
        cli_checkFiles $TGZ 'd' '' '--quiet'
        if [[ $? -ne 0 ]];then
            mkdir -p $TGZ
        fi

        # Move into working directory.
        pushd $TGZ > /dev/null
        
        for RESOLUTION in $RESOLUTIONS;do

            cli_printMessage "$TGZ/${TMP}-${RESOLUTION}.tar.gz" "AsCreatingLine"

            # Check background existence for specified resolution.
            cli_checkFiles $BGS/$RESOLUTION.png 'f' '' '--quiet'
            if [[ $? -ne 0 ]];then
                cli_printMessage "`eval_gettext "There is not background for \\\$RESOLUTION resolution."`"
                cli_printMessage "$(caller)" "AsToKnowMoreLine"
            fi

            # Create temporal directory.
            if [[ ! -d $TMP ]]; then
                mkdir $TMP
            fi

            # Copy gdm theme files into temporal directory.
            cp $SYMBOL	         		            $TMP/centos-symbol.png
            cp $IMG/release.png                     $TMP/centos-release.png
            cp $IMG/screenshot.png                  $TMP/screenshot.png
            cp $BGS/$RESOLUTION.png                 $TMP/background.png
            cp $TPL/*.png         		            $TMP/
            cp $TPL/GdmGreeterTheme.xml             $TMP/${TMP}.xml
            cp $TPL/GdmGreeterTheme.desktop         $TMP/

            # Translate markers from design model files.
            sed -i "s!=THEME=!${TMP}!g" \
                $TMP/GdmGreeterTheme.desktop \
                $TMP/${TMP}.xml

            # Create tar.gz file.
            tar -czf "${TMP}-${RESOLUTION}.tar.gz" $TMP

            # Remove temporal directory.
            rm -r $TMP

        done

        # Return to where we were initially.
        popd > /dev/null

    done

}
