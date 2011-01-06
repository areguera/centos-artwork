#!/bin/bash
#
# render_doIdentityImageDm.sh -- This function porvides last-rendition
# action to create gdm or kdm themes tar.gz files for different
# motifs, screen resolutions, and major releases of CentOS
# distribution. 
#
# Usage:
#
# ACTIONS[0]='BASE:renderImage'
# ACTIONS[1]='LAST:renderDm:TYPE:RESOLUTION'
#
# Where:
#
# TYPE = GNOME or KDE
# RESOLUTION = Any screen resolution available as background
# (e.g., 800x600, 1024x768, 2048x1536, etc.)
#
# For example, to produce GNOME display manager theme in 2048x1536,
# 1360x768, and 3271x1227 screen resolutions, for all major releases
# available, use the following definition inside GDM pre-rendition
# configuration script:
#
# ACTIONS[0]='BASE:renderImage'
# ACTIONS[1]='LAST:renderDm:GNOME:2048x1536 1360x768 3271x1227'
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

function render_doIdentityImageDm {

    local RESOLUTIONS=''
    local VERSIONS=''
    local TPL=''
    local BGS=''
    local TMP=''
    local SYMBOL=''
    local DM=''

    # Get display manager passed from render.conf.sh pre-rendition
    # configuration script.
    DM=$(render_getConfOption "$1" '2')

    # Sanitate display manager possible values and define absolute
    # path to display manager design models (i.e., the place where
    # GdmGreeterTheme.xml and GdmGreeterTheme.desktop files are
    # stored) using display manager information passed from
    # render.conf.sh pre-rendition configuration script.
    if [[ $DM =~ '^GNOME$' ]];then
        TPL=/home/centos/artwork/trunk/Identity/Themes/Models/${THEMEMODEL}/Distro/BootUp/GDM
    elif [[ $DM =~ '^KDE$' ]];then
        TPL=/home/centos/artwork/trunk/Identity/Themes/Models/${THEMEMODEL}/Distro/BootUp/KDM
    else
        cli_printMessage "`eval_gettext "The display manager \\\`\\\$DM' is not supported."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Check absolute path to display manager design models.
    cli_checkFiles "$TPL" 'd'

    # Get screen resolutions passed from render.conf.sh pre-rendition
    # configuration script.
    RESOLUTIONS=$(render_getConfOption "$1" '3')

    # Check sanitated screen resolutions.
    if [[ "$RESOLUTIONS" == '' ]];then
        cli_printMessage "`gettext "There is no resolution information to process."`" 'AsErrorLine'
        cli_printMessage $(caller) "AsToKnowMoreLine"
    fi

    # Build release numbers list we want to produce display manager
    # for. The release numbers are defined inside GDM and KDM
    # directories under
    # trunk/Translations/Identity/Themes/Distro/BootUp/ structure,
    # using the centos-art.sh script.
    VERSIONS=$(find $ACTIONVAL -regextype posix-egrep -maxdepth 1 \
        -type d -regex "^.*/${RELEASE_FORMAT}$")

    # Check release numbers list.
    if [[ "$VERSIONS" == '' ]];then
        cli_printMessage "`gettext "There is no release number to work with"`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Define directory storing different screen resolution backgrounds
    # images used to build display manager in different resolutions.
    BGS=$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getThemeName)/Backgrounds/Img/Png

    # Define directory where temporal files are stored. Remember that
    # cli_getThemeName may return branch enumeration if we are
    # rendition under branches/ directory structure. In order to build
    # the theme directory we only use the thame name, not the numerial
    # information, so be sure to remove it here.
    TMP=$(cli_getThemeName | cut -d/ -f1)

    # Define png image file used as CentOS symbol. As convenction,
    # inside all CentOS art works (e.g., anaconda, firstboot, etc.),
    # we are using CentOS symbol at 48x48 pixels. This value seems to
    # be the middle dimension that fits all situations.
    SYMBOL=/home/centos/artwork/trunk/Identity/Brands/Img/CentOS/Symbol/5c-a/48.png
    cli_checkFiles "$SYMBOL" 'f'

    for VERSION in $VERSIONS;do

        VERSION=$(basename $VERSION)

        # Define directory to store release-specific images.
        IMG=$ACTIONVAL/$VERSION/Img

        # Check existence of release-specific image directory.
        cli_checkFiles "$IMG" 'd'

        # Define directory to store release-specific tar.gz files. 
        TGZ=$ACTIONVAL/$VERSION/Tgz

        # Check existence of release-specific tar.gz directory.
        cli_checkFiles "$TGZ" 'd'

        # Move into working directory.
        pushd $TGZ > /dev/null
        
        for RESOLUTION in $RESOLUTIONS;do

            # Check background existence for specified resolution. If
            # the background resolution doesn't exist, skip it and
            # continue with the next resolution in the list.
            if [[ -f "$BGS/${RESOLUTION}-final.png" ]];then
                cli_printMessage "$TGZ/${TMP}-${RESOLUTION}-final.tar.gz" "AsCreatingLine"
            else
                continue
            fi

            # Create temporal directory.
            if [[ ! -d $TMP ]]; then
                mkdir $TMP
            fi

            # Copy display manager theme files into temporal
            # directory.
            cp $SYMBOL	         		            $TMP/centos-symbol.png
            cp $IMG/release.png                     $TMP/centos-release.png
            cp $IMG/screenshot.png                  $TMP/screenshot.png
            cp $BGS/${RESOLUTION}-final.png         $TMP/background.png
            if [[ $DM == 'GNOME' ]];then
                cp $TPL/*.png                       $TMP/
            fi
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

        # Output division rule.
        cli_printMessage '-' 'AsSeparatorLine'

    done

}
