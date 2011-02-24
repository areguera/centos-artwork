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

    # Check existence of file before work with it.
    cli_checkFiles "${FILE}" 'f'

    # Define pattern lines. The pattern lines are put inside portable
    # objects through xgettext and xml2po commands .
    SRC[0]='Project-Id-Version:'
    SRC[1]='Report-Msgid-Bugs-To:'
    SRC[2]='Last-Translator:'
    SRC[3]='Language-Team:'

    # Define replacement lines for pattern line.
    DST[0]="\"Project-Id-Version: ${CLINAME} (${CURRENTLOCALE})\\\n\""
    DST[1]="\"Report-Msgid-Bugs-To: =MAIL_DOCS=\\\n\""
    DST[2]="\"Last-Translator: CentOS Documentation SIG\\\n\""
    DST[3]="\"Language-Team: ${LANGNAME}\\\n\""

    # Change pattern lines with their replacement lines.
    while [[ $COUNT -lt ${#SRC[*]} ]];do
        sed -i -r "/${SRC[$COUNT]}/c${DST[$COUNT]}" ${FILE}
        COUNT=$(($COUNT + 1))
    done

    # Replace package information using gettext domain information.
    sed -i -r "s/PACKAGE/${TEXTDOMAIN}/g" ${FILE}

    # Unset array variables to avoid undesired concatenations.
    unset SRC
    unset DST

}
