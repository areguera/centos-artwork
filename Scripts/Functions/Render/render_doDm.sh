#!/bin/bash
#
# render_doDm.sh -- This function collects Display Manager (DM)
# required files and creates a tar.gz package that groups them all
# together. Use this function as last-rendition action for Gdm and Kdm
# base-rendition actions.
#
# Usage:
#
# ACTIONS[1]='LAST:renderDm:TYPE:RESOLUTION'
#
# Where:
#
# TYPE can be either `Gdm' or `Kdm'. These values correspond to the
# directory names used to store related design models.
#
# RESOLUTION represents the screen resolution tar.gz files are
# produced for (e.g., 800x600, 1024x768, 2048x1536, etc.). 
#
# In order to produce tar.gz files correctly, both screen resolution
# definition inside pre-rendition configuration script and background
# name inside theme directory structure need to match one another.  If
# one screen resolution is defined correctly, but there is no
# background information for it, the related tar.gz file is not
# produced and the next file in the list of files to process is
# evaluated.
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

function render_doDm {

    local -a SRC
    local -a DST
    local DM=''
    local TGZ=''
    local COUNT=0
    local RESOLUTION=''
    local RESOLUTIONS=''

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Get display manager passed from render.conf.sh pre-rendition
    # configuration script.
    DM=$(render_getConfigOption "${ACTION}" '2')
 
    # Sanitate display manager passed from render.conf.sh
    # pre-rendition configuration script. Whatever value be retrived
    # as display manager configuration option is converted to
    # uppercase in order to match either Gdm or Kdm design model
    # directory structures.
    DM=$(cli_getRepoName "$DM" 'd')

    # Get screen resolutions passed from render.conf.sh pre-rendition
    # configuration script.
    RESOLUTIONS=$(render_getConfigOption "${ACTION}" '3')

    # Check screen resolutions passed from render.conf.sh
    # pre-rendition configuration script.
    if [[ "$RESOLUTIONS" == '' ]];then
        cli_printMessage "`gettext "There is no resolution information to process."`" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" "AsToKnowMoreLine"
    fi

    # Define source files using absolute paths.
    SRC[0]=$(cli_getRepoTLDir)/Identity/Images/Brands/centos-symbol-resized-48.png
    SRC[1]=${OUTPUT}/release.png
    SRC[2]=${OUTPUT}/screenshot.png
    SRC[3]=$(dirname $TEMPLATE)/GdmGreeterTheme.xml
    SRC[4]=$(dirname $TEMPLATE)/GdmGreeterTheme.desktop
    SRC[5]=$(cli_getRepoTLDir)/Identity/Images/Themes/$(cli_getPathComponent '--theme')/Backgrounds/Img/Png
    SRC[6]=$(dirname $TEMPLATE)/icon-language.png
    SRC[7]=$(dirname $TEMPLATE)/icon-reboot.png
    SRC[8]=$(dirname $TEMPLATE)/icon-session.png
    SRC[9]=$(dirname $TEMPLATE)/icon-shutdown.png

    # Define name used as temporal holder to build tar.gz file. 
    TGZ=$(cli_getPathComponent '--theme-name')

    # Define target files using relative paths.
    DST[0]=${TGZ}/centos-symbol.png
    DST[1]=${TGZ}/centos-release.png
    DST[2]=${TGZ}/screenshot.png
    DST[3]=${TGZ}/${TGZ}.xml
    DST[4]=${TGZ}/GdmGreeterTheme.desktop
    DST[5]=${TGZ}/background.png
    DST[6]=${TGZ}/icon-language.png
    DST[7]=${TGZ}/icon-reboot.png
    DST[8]=${TGZ}/icon-session.png
    DST[9]=${TGZ}/icon-shutdown.png

    # Move into the working directory.
    pushd ${OUTPUT} > /dev/null

    # Create directory used as temporal holder to build tar.gz file.
    if [[ ! -d ${TGZ} ]];then
        mkdir ${TGZ}
    fi

    for RESOLUTION in $RESOLUTIONS;do

        while [[ $COUNT -lt ${#SRC[*]} ]];do

            if [[ $COUNT -eq 5 ]];then

                # Redefine background information using resolution as
                # reference. Avoid concatenation.
                SRC[$COUNT]=$(echo "${SRC[$COUNT]}" | cut -d/ -f-13)/${RESOLUTION}-final.png

                # If background information defined inside
                # pre-rendition configuration script doesn't match
                # background information inside theme-specific
                # backgrounds directory structure, try the next
                # background definition.
                if [[ ! -f ${SRC[$COUNT]} ]];then
                    continue 2
                fi
        
            elif [[ $COUNT =~ '^[6-9]$' ]];then

                # If display manager is Kdm, then increment counter and
                # resume the next iteration. Icons aren't used on Kdm,
                # so there's no need to have them inside it.
                if [[ $DM =~ '^Kdm$' ]];then
                    COUNT=$(($COUNT + 1))
                    continue
                fi

            fi

            # Check existence of source files.
            cli_checkFiles ${SRC[$COUNT]}

            # Copy files from source to target location.
            cp ${SRC[$COUNT]} ${DST[$COUNT]}

            # Replace common translation markers from design model
            # files with appropriate information.
            if [[ $COUNT =~ '^(3|4)$'  ]];then
                cli_replaceTMarkers "${DST[$COUNT]}"
            fi

            # Increment counter.
            COUNT=$(($COUNT + 1))

        done

        # Reset counter.
        COUNT=0

        # Print action message.
        cli_printMessage "${OUTPUT}/${RESOLUTION}.tar.gz" "AsCreatingLine"

        # Create tar.gz file.
        tar -czf "${RESOLUTION}.tar.gz" $TGZ

    done

    # Remove directory used as temporal holder to build targ.gz
    # file.
    rm -r $TGZ

    # Remove release-specific images.
    cli_printMessage "${SRC[1]}" "AsDeletingLine"
    rm ${SRC[1]}
    cli_printMessage "${SRC[2]}" "AsDeletingLine"
    rm ${SRC[2]}

    # Return to where we were initially.
    popd > /dev/null

}
