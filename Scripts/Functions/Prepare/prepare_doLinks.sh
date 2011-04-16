#!/bin/bash
#
# prepare_doLinks.sh -- This function creates the base configuration
# of symbolic links your workstation needs to have in order for
# centos-art command to run correctly.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function prepare_doLinks {

    # Verify `--links' option.
    if [[ $FLAG_LINKS == 'false' ]];then
        return
    fi

    # Print line separator.
    cli_printMessage '-' 'AsSeparatorLine'

    # Print action message.
    cli_printMessage "`gettext "Checking symbolic links"`" 'AsResponseLine'

    # Print line separator.
    cli_printMessage '-' 'AsSeparatorLine'

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

    # Define user-specific directory for Gimp.
    local GIMP_USER_DIR=${HOME}/.$(rpm -q gimp | cut -d. -f-2)

    # Define user-specific directory for Inkscape.
    local INKS_USER_DIR=${HOME}/.inkscape

    # Define lists of files which symbolic links will point to.
    local FONTS=$(cli_getFilesList "${HOME}/artwork/trunk/Identity/Fonts" 'denmark\.ttf')
    local PALETTES=$(cli_getFilesList "${HOME}/artwork/trunk/Identity/Palettes" ".+\.gpl")
    local BRUSHES=$(cli_getFilesList "${HOME}/artwork/trunk/Identity/Brushes" ".+\.(gbr|gih)")
    local PATTERNS=$(cli_getFilesList "${HOME}/artwork/trunk/Identity/Patterns" ".+\.png")

    # Define link relation for cli.
    LINKS_SRC[0]=${HOME}/bin/$CLI_PROGRAM
    LINKS_DST[0]=${CLI_BASEDIR}/${CLI_PROGRAM}.sh

    # Define link relation for fonts.
    for FONT in $FONTS;do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.fonts/$(basename $FONT)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$FONT
    done

    # Define link relation for common palettes.
    for PALETTE in $PALETTES;do
        SUFFIX="${GIMP_USER_DIR}/palettes/$(prepare_doLinksSuffixes $PALETTE)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
        SUFFIX="${INKS_USER_DIR}/palettes/$(prepare_doLinksSuffixes $PALETTE)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
    done

    # Define link relation for common brushes.
    for BRUSH in $BRUSHES;do
        SUFFIX="${GIMP_USER_DIR}/brushes/$(prepare_doLinksSuffixes $BRUSH)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $BRUSH)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$BRUSH
    done

    # Define link relation for common patterns.
    for PATTERN in $PATTERNS;do
        SUFFIX="${GIMP_USER_DIR}/patterns/$(prepare_doLinksSuffixes $PATTERN)"
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${SUFFIX}${NAME}${VERS}$(basename $PATTERN)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PATTERN
    done

    # Define which files inside user-specific directories need to be
    # removed in order for centos-art to make a fresh installation of
    # common patterns, common palettes and common brushes using
    # symbolic links from the repository.
    USERFILES=$(cli_getFilesList "${HOME}/.fonts" '.+\.ttf';
        cli_getFilesList "${HOME}/bin" '.+\.sh';
        cli_getFilesList "${GIMP_USER_DIR}/palettes" '.+\.gpl';
        cli_getFilesList "${GIMP_USER_DIR}/brushes" '.+\.(gbr|gih)';
        cli_getFilesList "${GIMP_USER_DIR}/patterns" '.+\.png';
        cli_getFilesList "${INKS_USER_DIR}/palettes" '.+\.gpl')

    # Remove installed files inside user-specific directories.
    if [[ "$USERFILES" != '' ]];then
        cli_printActionPreamble "${USERFILES[*]}" 'doDelete' 'AsResponseLine'
        for FILE in ${USERFILES};do
            cli_printMessage "${FILE}" 'AsDeletingLine'
            rm -r $FILE
        done
    fi

    # Create symbolic links. In case the the symbolic link parent
    # directory isn't created, it will be created in order to make
    # the link creation possible.
    cli_printActionPreamble "${LINKS_SRC[*]}" 'doCreate' 'AsResponseLine'
    while [[ $COUNT -lt ${#LINKS_SRC[*]} ]];do

        if [[ -f ${LINKS_SRC[$COUNT]} ]];then
            cli_printMessage "${LINKS_SRC[$COUNT]}" 'AsUpdatingLine'
        else
            cli_printMessage "${LINKS_SRC[$COUNT]}" 'AsCreatingLine'
        fi

        if [[ ! -d $(dirname ${LINKS_SRC[$COUNT]}) ]];then
            mkdir -p $(dirname ${LINKS_SRC[$COUNT]})
        fi

        ln ${LINKS_DST[$COUNT]} ${LINKS_SRC[$COUNT]} --symbolic --force

        COUNT=$(($COUNT + 1))

    done

}
