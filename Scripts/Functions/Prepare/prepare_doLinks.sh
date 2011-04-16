#!/bin/bash
#
# prepare_doLinks.sh -- This function installs the symbolic links your
# workstation needs to have in order for centos-art command to run
# correctly.
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
    local USERFILES=''
    local PALETTE=''
    local BRUSH=''
    local PATTERN=''
    local FONT=''
    local FILE=''
    local COUNT=0

    # Define link suffix.
    local SUFFIX='centos-'

    # Define user-specific directory for Gimp.
    local GIMP_USER_DIR=${HOME}/.$(rpm -q gimp | cut -d. -f-2)

    # Define user-specific directory for Inkscape.
    local INKS_USER_DIR=${HOME}/.inkscape

    # Define both source and target location for centos-art command.
    LINKS_SRC[0]=${HOME}/bin/$CLI_PROGRAM
    LINKS_DST[0]=${CLI_BASEDIR}/${CLI_PROGRAM}.sh

    # Define both source and target location for fonts.
    local FONTS=$(cli_getFilesList "${HOME}/artwork/trunk/Identity/Fonts" 'denmark\.ttf')
    for FONT in $FONTS;do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.fonts/$(basename $FONT)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$FONT
    done

    # Define both source and target location for Gimp and Inkscape
    # palettes.
    local PALETTES=$(cli_getFilesList \
        "${HOME}/artwork/trunk/Identity/Themes/Motifs/*/*/Palettes
         ${HOME}/artwork/trunk/Identity/Palettes" ".+\.gpl")
    for PALETTE in $PALETTES;do
        if [[ "$PALETTE" =~ "$(cli_getPathComponent '--theme-pattern')" ]];then
            NAME="$(cli_getRepoName "$(cli_getPathComponent "$PALETTE" '--theme-name')" 'f')-"
            VERS="$(cli_getPathComponent "$PALETTE" '--theme-release')-"
        else
            NAME=''
            VERS=''
        fi
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_USER_DIR}/palettes/${SUFFIX}${NAME}${VERS}$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${INKS_USER_DIR}/palettes/${SUFFIX}${NAME}${VERS}$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
    done

    # Define both source and target location for Gimp brushes.
    local BRUSHES=$(cli_getFilesList \
        "${HOME}/artwork/trunk/Identity/Themes/Motifs/*/*/Brushes
         ${HOME}/artwork/trunk/Identity/Brushes" ".+\.(gbr|gih)")
    for BRUSH in $BRUSHES;do
        if [[ "$BRUSH" =~ "$(cli_getPathComponent '--theme-pattern')" ]];then
            NAME="$(cli_getRepoName "$(cli_getPathComponent "$BRUSH" '--theme-name')" 'f')-"
            VERS="$(cli_getPathComponent "$BRUSH" '--theme-release')-"
        else
            NAME=''
            VERS=''
        fi
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_USER_DIR}/brushes/${SUFFIX}${NAME}${VERS}$(basename $BRUSH)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$BRUSH
    done

    # --- prepare_doLinksPatterns ---

    # Define both source and target location for Gimp patterns.
    local PATTERNS=$(cli_getFilesList \
        "${HOME}/artwork/trunk/Identity/Themes/Motifs/*/*/Patterns
         ${HOME}/artwork/trunk/Identity/Patterns" ".+\.png")
    for PATTERN in $PATTERNS;do
        if [[ "$PATTERN" =~ "$(cli_getPathComponent '--theme-pattern')" ]];then
            NAME="$(cli_getRepoName "$(cli_getPathComponent "$PATTERN" '--theme-name')" 'f')-"
            VERS="$(cli_getPathComponent "$PATTERN" '--theme-release')-"
        else
            NAME=''
            VERS=''
        fi
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_USER_DIR}/patterns/${SUFFIX}${NAME}${VERS}$(basename $PATTERN)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PATTERN
    done

    # Define files inside user-specific directories that need to be
    # removed in order to make a fresh installation of patterns,
    # palettes and brushes using symbolic links from the repository.
    USERFILES=$(cli_getFilesList "${HOME}/.fonts" '.+\.ttf';
        cli_getFilesList "${HOME}/bin" '.+\.sh';
        cli_getFilesList "${GIMP_USER_DIR}/palettes" '.+\.gpl';
        cli_getFilesList "${GIMP_USER_DIR}/brushes" '.+\.(gbr|gih)';
        cli_getFilesList "${GIMP_USER_DIR}/patterns" '.+\.png';
        cli_getFilesList "${INKS_USER_DIR}/palettes" '.+\.gpl')

    # Remove installed files inside user-specific directories.
    if [[ "$USERFILES" != '' ]];then
        cli_printActionPreamble "${USERFILES[*]}" 'doDelete' 'AsResponseLine'
        for FILE in ${USERFILES[@]};do
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
