#!/bin/bash
#
# locale_updateMessageMetadata.sh -- This function sanitates .pot and
# .po files to use common translation markers inside top comment.
# Later, replacement of common translation markers is applied to set
# the final information.
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
# $Id4
# ----------------------------------------------------------------------

function locale_updateMessageMetadata {

    local COUNT=0
    local -a SRC
    local -a DST

    # Retrive absolute path of portable object we'll work with.
    local FILE="$1"

    # Define current locale.
    local CURRENTLOCALE=$(cli_getCurrentLocale)

    # Define language name from current locale.
    local LANGNAME=$(cli_getLangName ${CURRENTLOCALE})

    # Define language code from current locale.
    local LANGCODE=$(cli_getLangCodes ${CURRENTLOCALE})

    # Check existence of file before work with it.
    cli_checkFiles "${FILE}" 'f'

    # Define comment patterns. Comment patterns are put inside
    # portable objects when they are built using xgettext or xml2po
    # commands.
    SRC[0]='Project-Id-Version:'
    SRC[1]='Last-Translator:'
    SRC[2]='Language-Team:'

    # Define comment replacements. Comment replacements is the
    # convenction we use inside centos-art.sh to set standard
    # information related to CentOS (e.g., URLs, mail addresses,
    # release numbers, etc.).
    DST[0]="\"Project-Id-Version: $(cli_getRepoName "${FILE}" 'dfd')\\\n\""
    DST[1]="\"Last-Translator: CentOS Documentation SIG <centos-docs@centos.org>\\\n\""
    DST[2]="\"Language-Team: ${LANGNAME} <centos-docs@${LANGCODE}.centos.org>\\\n\""

    # Replace comment patterns with comment replacements.
    while [[ $COUNT -lt ${#SRC[*]} ]];do
        sed -i -r "/${SRC[$COUNT]}/c${DST[$COUNT]}" ${FILE}
        COUNT=$(($COUNT + 1))
    done

    # Apply common replacements to sanitated patterns.
    cli_replaceTMarkers "${FILE}"

    # Unset array variables to avoid undesired concatenations.
    unset SRC
    unset DST

}
