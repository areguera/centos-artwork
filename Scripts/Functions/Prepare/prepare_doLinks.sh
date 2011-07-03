#!/bin/bash
#
# prepare_doLinks.sh -- This option creates/updates the symbolic links
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

function prepare_doLinks {

    local -a LINKS_SRC
    local -a LINKS_DST
    local SUFFIX='centos'
    local USERFILES=''
    local PALETTE=''
    local BRUSH=''
    local PATTERN=''
    local FONT=''
    local FILE=''
    local COUNT=0

    # Define user's directories where most configuration linkes will
    # be created in.
    local GIMP_HOME=${HOME}/.$(rpm -q gimp | cut -d. -f-2)
    local INKS_HOME=${HOME}/.inkscape

    # Define link relation for cli.
    LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/bin/$CLI_PROGRAM
    LINKS_DST[((++${#LINKS_DST[*]}))]=${CLI_BASEDIR}/${CLI_PROGRAM}.sh
    USERFILES="${HOME}/bin/$CLI_PROGRAM"

    # Define link relation for fonts.
    for FONT in $(cli_getFilesList ${HOME}/artwork/trunk/Identity/Fonts --pattern='denmark\.ttf');do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.fonts/$(basename $FONT)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$FONT
    done

    # Define link relation for common palettes.
    for PALETTE in $(cli_getFilesList ${HOME}/artwork/trunk/Identity/Palettes --pattern=".+\.gpl");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_HOME}/palettes/${SUFFIX}-$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${INKS_HOME}/palettes/${SUFFIX}-$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
    done

    # Define link relation for common brushes.
    for BRUSH in $(cli_getFilesList ${HOME}/artwork/trunk/Identity/Brushes --pattern=".+\.(gbr|gih)");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_HOME}/brushes/${SUFFIX}-$(basename $BRUSH)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$BRUSH
    done

    # Define link relation for common patterns.
    for PATTERN in $(cli_getFilesList ${HOME}/artwork/trunk/Identity/Patterns --pattern=".+\.png");do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_HOME}/patterns/${SUFFIX}-$(basename $PATTERN)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PATTERN
    done

    # Define link relation for Vim text editor's configuration.
    if [[ $EDITOR == '/usr/bin/vim' ]];then
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.vimrc
        LINKS_DST[((++${#LINKS_DST[*]}))]=${PREPARE_CONFIG_DIR}/vimrc
        USERFILES="${USERFILES} ${HOME}/.vimrc"
    fi

    # Define which files inside the user's configuration directories
    # need to be removed in order for centos-art.sh script to make a
    # fresh installation of common patterns, common palettes and
    # common brushes using symbolic links from the working copy to the
    # user's configuration directories inside the workstation.
    USERFILES=$(echo "$USERFILES";
        cli_getFilesList ${HOME}/bin --pattern='.+\.sh';
        cli_getFilesList ${HOME}/.fonts --pattern='.+\.ttf';
        cli_getFilesList ${GIMP_HOME}/brushes --pattern='.+\.(gbr|gih)';
        cli_getFilesList ${GIMP_HOME}/patterns --pattern='.+\.(pat|png|jpg|bmp)';
        cli_getFilesList ${GIMP_HOME}/palettes --pattern='.+\.gpl';
        cli_getFilesList ${INKS_HOME}/palettes --pattern='.+\.gpl';)

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
