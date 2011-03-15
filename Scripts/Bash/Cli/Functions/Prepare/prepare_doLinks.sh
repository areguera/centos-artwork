#!/bin/bash
#
# prepare_doLinks.sh -- This function installs the symbolic links your
# workstation needs to have in order for centos-art command to run
# correctly.
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
    local -a USERFILES
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

    # Define both source and target location for centos-art command.
    LINKS_SRC[0]=${HOME}/bin/$CLI_PROGRAM
    LINKS_DST[0]=${CLI_BASEDIR}/init.sh

    # Define both source and target location for fonts.
    local FONTS=$(cli_getFilesList "${HOME}/artwork/trunk/Identity/Fonts" 'denmark\.ttf')
    for FONT in $FONTS;do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${HOME}/.fonts/$(basename $FONT)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$FONT
    done

    # Define both source and target location for Gimp and Inkscape
    # palettes.
    local PALETTES=$(cli_getFilesList "$HOME/artwork/trunk/Identity/Themes/Motifs/*/*/Palettes
        ${HOME}/artwork/trunk/Identity/Palettes" ".+\.gpl")
    for PALETTE in $PALETTES;do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_USER_DIR}/palettes/$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${INKS_USER_DIR}/palettes/$(basename $PALETTE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PALETTE
    done

    # Define both source and target location for Gimp brushes.
    local BRUSHES=$(cli_getFilesList \
        "${HOME}/artwork/trunk/Identity/Themes/Motifs/*/*/Brushes" \
        ".+\.(gbr|ghi)")
    for BRUSH in $BRUSHES;do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_USER_DIR}/brushes/$(basename $BRUSH)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$BRUSH
    done

    # Define both source and target location for Gimp patterns.
    local PATTERNS=$(cli_getFilesList \
        "${HOME}/artwork/trunk/Identity/Themes/Motifs/*/*/Patterns" \
        ".+\.png")
    for PATTERN in $PATTERNS;do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_USER_DIR}/patterns/$(basename $PATTERN)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$PATTERN
    done

    # Define information installed inside user-specific directories
    # that need to be cleaned up in order to make a fresh installation
    # of patterns, palettes and brushes from repository by mean of
    # symbolic links.
    USERFILES[((++${#USERFILES[*]}))]=$(cli_getFilesList "${HOME}/.fonts" '.+\.ttf')
    USERFILES[((++${#USERFILES[*]}))]=$(cli_getFilesList "${HOME}/bin" '.+\.sh')
    USERFILES[((++${#USERFILES[*]}))]=$(cli_getFilesList "${GIMP_USER_DIR}/palettes" '.+\.gpl')
    USERFILES[((++${#USERFILES[*]}))]=$(cli_getFilesList "${GIMP_USER_DIR}/brushes" '.+\.(gbr|ghi)')
    USERFILES[((++${#USERFILES[*]}))]=$(cli_getFilesList "${GIMP_USER_DIR}/patterns" '.+\.png')
    USERFILES[((++${#USERFILES[*]}))]=$(cli_getFilesList "${INKS_USER_DIR}/palettes" '.+\.gpl')

    # Print action preamble.
    cli_printActionPreamble "${USERFILES[*]}" 'doDelete' 'AsResponseLine'

    # Remove installed inside user-specific directories.
    for FILE in ${USERFILES[@]};do
        cli_printMessage "${FILE}" 'AsDeletingLine'
        rm -r $FILE
    done

    # Print action preamble.
    cli_printActionPreamble "${LINKS_SRC[*]}" 'doCreate' 'AsResponseLine'

    # Create symbolic links. In case the the symbolic link parent
    # directory isn't created, it will be created in order to make
    # link creation possible.
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
