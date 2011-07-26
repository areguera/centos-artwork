#!/bin/bash
#
# prepare_updateLinks.sh -- This option creates/updates the symbolic links
# information required in your workstation to connect it with the
# files inside the working copy of The CentOS Artwork Repository. When
# you provide this option, the centos-art.sh put itself into your
# system's execution path and make common brushes, patterns, palettes
# and fonts available inside applications like GIMP, so you can make
# use of them without loosing version control over them. 
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function prepare_updateLinks {

    local -a LINKS_SRC
    local -a LINKS_DST
    local USERFILES=''
    local PALETTE=''
    local BRUSH=''
    local PATTERN=''
    local FONT=''
    local FILE=''
    local COUNT=0

    # Define user's directories. This is the place where configuration
    # links are created in.
    local GIMP_DIR=${HOME}/.$(rpm -q gimp | cut -d. -f-2)
    local GIMP_DIR_BRUSHES=${GIMP_DIR}/brushes
    local GIMP_DIR_PALETTES=${GIMP_DIR}/palettes
    local GIMP_DIR_PATTERNS=${GIMP_DIR}/patterns
    local INKS_DIR=${HOME}/.inkscape
    local INKS_DIR_PALETTES=${INKS_DIR}/palettes
    local FONT_DIR=${HOME}/.fonts
    local APPS_DIR=${HOME}/bin

    # Define working copy directories. This is the place where
    # configuration links point to.
    local WCDIR=$(cli_getRepoTLDir)/Identity
    local WCDIR_BRUSHES=${WCDIR}/Brushes
    local WCDIR_PALETTES=${WCDIR}/Palettes
    local WCDIR_PATTERNS=${WCDIR}/Patterns
    local WCDIR_FONTS=${WCDIR}/Fonts
    local WCDIR_EDITOR=${PREPARE_CONFIG_DIR}

    # Define link relation for cli.
    LINKS_SRC[((++${#LINKS_SRC[*]}))]=${APPS_DIR}/${CLI_PROGRAM}
    LINKS_DST[((++${#LINKS_DST[*]}))]=${CLI_BASEDIR}/${CLI_PROGRAM}.sh
    USERFILES="${APPS_DIR}/${CLI_PROGRAM}"

    # Define link relation for fonts.
    for FONT in $(cli_getFilesList "${WCDIR_FONTS}" --pattern='.+\.ttf');do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${FONT_DIR}/$(basename $FONT)
        LINKS_DST[((++${#LINKS_DST[*]}))]=${FONT}
    done

    # Define link relation for common palettes.
    for PALETTE in $(cli_getFilesList "${WCDIR_PALETTES}" --pattern=".+\.gpl");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_DIR_PALETTES}/$(prepare_getLinkName ${WCDIR_PALETTES} ${PALETTE})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${PALETTE}
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${INKS_DIR_PALETTES}/$(prepare_getLinkName ${WCDIR_PALETTES} ${PALETTE})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${PALETTE}
    done

    # Define link relation for common brushes.
    for BRUSH in $(cli_getFilesList "${WCDIR_BRUSHES}" --pattern=".+\.(gbr|gih)");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_DIR_BRUSHES}/$(prepare_getLinkName ${WCDIR_BRUSHES} ${BRUSH})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${BRUSH}
    done

    # Define link relation for common patterns.
    for PATTERN in $(cli_getFilesList "${WCDIR_PATTERNS}" --pattern=".+\.png");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_DIR_PATTERNS}/$(prepare_getLinkName ${WCDIR_BRUSHES} ${BRUSH})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${PATTERN}
    done

    # Define link relation for Vim text editor's configuration.
    if [[ $EDITOR == '/usr/bin/vim' ]];then
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.vimrc
        LINKS_DST[((++${#LINKS_DST[*]}))]=${WCDIR_EDITOR}/vimrc
        USERFILES="${USERFILES} ${HOME}/.vimrc"
    fi

    # Define which files inside the user's configuration directories
    # need to be removed in order for centos-art.sh script to make a
    # fresh installation of common patterns, common palettes and
    # common brushes using symbolic links from the working copy to the
    # user's configuration directories inside the workstation.
    USERFILES=$(echo "$USERFILES";
        cli_getFilesList ${APPS_DIR} --pattern='.+\.sh';
        cli_getFilesList ${FONT_DIR} --pattern='.+\.ttf';
        cli_getFilesList ${GIMP_DIR_BRUSHES} --pattern='.+\.(gbr|gih)';
        cli_getFilesList ${GIMP_DIR_PATTERNS} --pattern='.+\.(pat|png|jpg|bmp)';
        cli_getFilesList ${GIMP_DIR_PALETTES} --pattern='.+\.gpl';
        cli_getFilesList ${INKS_DIR_PALETTES} --pattern='.+\.gpl';)

    # Remove user-specific configuration files from user's home
    # directory. Otherwise, we might end up having links insid user's
    # home directory that don't exist inside the working copy.
    if [[ "$USERFILES" != '' ]];then
        rm -r $USERFILES
    fi

    while [[ $COUNT -lt ${#LINKS_SRC[*]} ]];do

        # Print action message.
        cli_printMessage "${LINKS_SRC[$COUNT]}" --as-creating-line

        # Create symbolic link's parent directory if it doesn't exist.
        if [[ ! -d $(dirname ${LINKS_SRC[$COUNT]}) ]];then
            mkdir -p $(dirname ${LINKS_SRC[$COUNT]})
        fi

        # Create symbolic link.
        ln ${LINKS_DST[$COUNT]} ${LINKS_SRC[$COUNT]} --symbolic --force

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

}
