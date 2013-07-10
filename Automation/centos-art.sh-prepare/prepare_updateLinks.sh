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
# Copyright (C) 2009-2013 The CentOS Project
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

    # Define user's directories. Here is where configuration links are
    # created in the local workstation.
    local GIMP_DIR=${HOME}/.$(rpm -q gimp | cut -d. -f-2)
    local GIMP_DIR_BRUSHES=${GIMP_DIR}/brushes
    local GIMP_DIR_PALETTES=${GIMP_DIR}/palettes
    local GIMP_DIR_PATTERNS=${GIMP_DIR}/patterns
    local INKS_DIR=${HOME}/.inkscape
    local INKS_DIR_PALETTES=${INKS_DIR}/palettes
    local FONT_DIR=${HOME}/.fonts
    local APPS_DIR=${HOME}/bin

    # Define the working copy directory structure. Here is where user
    # specific configuration links in the workstation will point to.
    local WCDIR=${TCAR_WORKDIR}/Identity
    local WCDIR_BRUSHES=${WCDIR}/Brushes
    local WCDIR_PALETTES=${WCDIR}/Palettes
    local WCDIR_PATTERNS=${WCDIR}/Patterns
    local WCDIR_FONTS=${WCDIR}/Fonts
    local WCDIR_EDITOR=${PREPARE_CONFIG_DIR}

    # Verify required working copy directory structure. If these
    # directories don't exist, there isn't a target location where
    # configuration links can point to. To prevent such an issue
    # output an error message and stop the script execution after it.
    for DIR in $(echo "Brushes Palettes Patterns Fonts");do
        cli_checkFiles ${WCDIR}/${DIR}
    done

    # Define link relation for cli.
    LINKS_SRC[((++${#LINKS_SRC[*]}))]=${APPS_DIR}/${CLI_NAME}
    LINKS_DST[((++${#LINKS_DST[*]}))]=${CLI_BASEDIR}/${CLI_NAME}.sh
    USERFILES="${APPS_DIR}/${CLI_NAME}"

    # Define link relation for fonts.
    for FONT in $(cli_getFilesList "${WCDIR_FONTS}" --pattern='^.+\.ttf$');do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${FONT_DIR}/$(basename $FONT)
        LINKS_DST[((++${#LINKS_DST[*]}))]=${FONT}
    done

    # Define link relation for common palettes.
    for PALETTE in $(cli_getFilesList "${WCDIR_PALETTES}" --pattern="^.+\.gpl$");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_DIR_PALETTES}/$(prepare_getLinkName ${WCDIR_PALETTES} ${PALETTE})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${PALETTE}
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${INKS_DIR_PALETTES}/$(prepare_getLinkName ${WCDIR_PALETTES} ${PALETTE})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${PALETTE}
    done

    # Define link relation for common brushes.
    for BRUSH in $(cli_getFilesList "${WCDIR_BRUSHES}" --pattern="^.+\.(gbr|gih)$");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_DIR_BRUSHES}/$(prepare_getLinkName ${WCDIR_BRUSHES} ${BRUSH})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${BRUSH}
    done

    # Define link relation for common patterns.
    for PATTERN in $(cli_getFilesList "${WCDIR_PATTERNS}" --pattern="^.+\.png$");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_DIR_PATTERNS}/$(prepare_getLinkName ${WCDIR_BRUSHES} ${BRUSH})
        LINKS_DST[((++${#LINKS_DST[*]}))]=${PATTERN}
    done

    # Define link relation for Vim text editor's configuration.
    if [[ $EDITOR == '/usr/bin/vim' ]];then
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.vimrc
        LINKS_DST[((++${#LINKS_DST[*]}))]=${WCDIR_EDITOR}/vim.conf
        USERFILES="${USERFILES} ${HOME}/.vimrc"
    fi

    # Define link relation for the `reset.css' file. The `reset.css'
    # file is resets the web browser default style and use ours
    # instead. The reset.css file is common for all web environments
    # so there is no need to have duplicated files inside the working
    # copy.  Instead, create a symbolic link to it from different
    # places using absolute paths and the default style guide as
    # reference.
    LINKS_SRC[((++${#LINKS_SRC[*]}))]=${TCAR_WORKDIR}/Identity/Webenv/Themes/Default/Docbook/1.69.1/Css/reset.css
    LINKS_DST[((++${#LINKS_DST[*]}))]=${TCAR_WORKDIR}/Identity/Webenv/Themes/Default/Style-guide/0.0.1/Css/reset.css

    # Define link relation for `images' directory used inside the
    # default web environment style guide. The `images' directory
    # contains common images used by all web environments. By default
    # no image is under version control so we point out the output
    # directory where this images produced, once rendered.
    LINKS_SRC[((++${#LINKS_SRC[*]}))]=${TCAR_WORKDIR}/Identity/Webenv/Themes/Default/Style-guide/0.0.1/Images
    LINKS_DST[((++${#LINKS_DST[*]}))]=${TCAR_WORKDIR}/Identity/Images/Webenv

    # Define link relation for `Manuals' images. These images exists
    # to help people describe ideas inside documentation.
    LINKS_SRC[((++${#LINKS_SRC[*]}))]=${TCAR_WORKDIR}/Identity/Images/Webenv/Manuals
    LINKS_DST[((++${#LINKS_DST[*]}))]=${TCAR_WORKDIR}/Identity/Images/Manuals

    # Define link for `centos-logo.png', the branding information that
    # should be used in all web applications on the left-top corner.
    LINKS_SRC[((++${#LINKS_SRC[*]}))]=${TCAR_WORKDIR}/Identity/Images/Webenv/logo-centos.png
    LINKS_DST[((++${#LINKS_DST[*]}))]=${TCAR_WORKDIR}/Identity/Images/Brands/Logos/White/78/centos.png

    # Define which files inside the user's configuration directories
    # need to be removed in order for centos-art.sh script to make a
    # fresh installation of common patterns, common palettes and
    # common brushes using symbolic links from the working copy to the
    # user's configuration directories inside the workstation.
    USERFILES=$(echo "$USERFILES";
        cli_getFilesList ${APPS_DIR} --pattern='^.+\.sh$';
        cli_getFilesList ${FONT_DIR} --pattern='^.+\.ttf$';
        cli_getFilesList ${GIMP_DIR_BRUSHES} --pattern='^.+\.(gbr|gih)$';
        cli_getFilesList ${GIMP_DIR_PATTERNS} --pattern='^.+\.(pat|png|jpg|bmp)$';
        cli_getFilesList ${GIMP_DIR_PALETTES} --pattern='^.+\.gpl$';
        cli_getFilesList ${INKS_DIR_PALETTES} --pattern='^.+\.gpl$';)

    # Remove user-specific configuration files from user's home
    # directory before creating symbolic links from the working copy.
    # Otherwise, we might end up having links inside the user's home
    # directory that don't exist inside the working copy.
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

        # Remove symbolic link before creating it to prevent recursive
        # creation once the first symbolic link be created and it be a
        # directory.
        if [[ -a ${LINKS_SRC[$COUNT]} ]];then
            rm ${LINKS_SRC[$COUNT]}
        fi

        # Create symbolic link.
        ln ${LINKS_DST[$COUNT]} ${LINKS_SRC[$COUNT]} --symbolic --force

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

}
