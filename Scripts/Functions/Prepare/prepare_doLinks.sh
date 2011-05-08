#!/bin/bash
#
# prepare_doLinks.sh -- This function creates the base configuration
# of symbolic links your workstation needs to have installed in order
# for you to use the `centos-art' command and some auxiliar components
# (e.g., palettes, brushes, patterns, fonts, etc.) that may result
# useful for you when designing graphical compositions.
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

function prepare_doLinks {

    # Verify `--links' option.
    if [[ $FLAG_LINKS == 'false' ]];then
        return
    fi

    local -a LINKS_SRC
    local -a LINKS_DST
    local SUFFIX=''
    local USERFILES=''
    local PALETTE=''
    local BRUSH=''
    local PATTERN=''
    local FONT=''
    local FILE=''
    local COUNT=0

    # Define user-specific directories.
    local GIMP_USERDIR=${HOME}/.$(rpm -q gimp | cut -d. -f-2)
    local INKS_USERDIR=${HOME}/.inkscape

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
        SUFFIX="${GIMP_USERDIR}/palettes/$(prepare_doLinksSuffixes $PALETTE)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
        SUFFIX="${INKS_USERDIR}/palettes/$(prepare_doLinksSuffixes $PALETTE)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
    done

    # Define link relation for common brushes.
    for BRUSH in $(cli_getFilesList ${HOME}/artwork/trunk/Identity/Brushes --pattern=".+\.(gbr|gih)");do
        SUFFIX="${GIMP_USERDIR}/brushes/$(prepare_doLinksSuffixes $BRUSH)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $BRUSH)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$BRUSH
    done

    # Define link relation for common patterns.
    for PATTERN in $(cli_getFilesList ${HOME}/artwork/trunk/Identity/Patterns --pattern=".+\.png");do
        SUFFIX="${GIMP_USERDIR}/patterns/$(prepare_doLinksSuffixes $PATTERN)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $PATTERN)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PATTERN
    done

    # Define link relation for Vim text editor.
    if [[ $EDITOR == '/usr/bin/vim' ]];then
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.vimrc
        LINKS_DST[((++${#LINKS_DST[*]}))]=${FUNCCONFIG}/vimrc
        USERFILES="${USERFILES} ${HOME}/.vimrc"
    fi

    # Define which files inside user-specific directories need to be
    # removed in order for centos-art to make a fresh installation of
    # common patterns, common palettes and common brushes using
    # symbolic links from the repository.
    USERFILES=$(echo "$USERFILES";
        cli_getFilesList ${HOME}/bin --pattern='.+\.sh';
        cli_getFilesList ${HOME}/.fonts --pattern='.+\.ttf';
        cli_getFilesList ${GIMP_USERDIR}/brushes --pattern='.+\.(gbr|gih)';
        cli_getFilesList ${GIMP_USERDIR}/patterns --pattern='.+\.(pat|png|jpg|bmp)';
        cli_getFilesList ${GIMP_USERDIR}/palettes --pattern='.+\.gpl';
        cli_getFilesList ${INKS_USERDIR}/palettes --pattern='.+\.gpl';)

    # Remove files installed inside user-specific directories.
    if [[ "$USERFILES" != '' ]];then
        cli_printActionPreamble $USERFILES --to-delete
        rm -r $USERFILES
    fi

    # Print preamble message for symbolic link creation.
    cli_printActionPreamble ${LINKS_SRC[*]} --to-create

    while [[ $COUNT -lt ${#LINKS_SRC[*]} ]];do

        # Print action message.
        if [[ -a ${LINKS_SRC[$COUNT]} ]];then
            cli_printMessage "${LINKS_SRC[$COUNT]}" --as-updating-line
        else
            cli_printMessage "${LINKS_SRC[$COUNT]}" --as-creating-line
        fi

        # Create symbolic link parent directory if it doesn't exist.
        if [[ ! -d $(dirname ${LINKS_SRC[$COUNT]}) ]];then
            mkdir -p $(dirname ${LINKS_SRC[$COUNT]})
        fi

        # Create symbolic link.
        ln ${LINKS_DST[$COUNT]} ${LINKS_SRC[$COUNT]} --symbolic --force

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

}
