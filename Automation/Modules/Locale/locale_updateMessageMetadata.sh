#!/bin/bash
######################################################################
#
#   locale_updateMessageMetadata.sh -- This function sanitates .pot
#   and .po files to use common translation markers inside top
#   comment.  Later, replacement of common translation markers is
#   applied to set the final information.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>
#
# Copyright (C) 2009-2013 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
######################################################################

function locale_updateMessageMetadata {

    local COUNT=0
    local -a SRC
    local -a DST

    # Retrieve absolute path of portable object we'll work with.
    local PO="${1}"

    # Check existence of file before work with it.
    tcar_checkFiles "${PO}" -f

    # Define pattern lines. The pattern lines are put inside portable
    # objects through xgettext and xml2po commands. In the case of
    # Last-Translators, be sure to remplace it only when it is empty
    # or refer the Documentation SIG only. This way translators' names
    # will survive metadata updates. We don't want they have to type
    # their name each time they edit a file.
    SRC[0]="\"Project-Id-Version:"
    SRC[1]="\"Report-Msgid-Bugs-To:"
    SRC[2]="\"Last-Translator: (.+)?"
    SRC[3]="\"Language-Team:"
    SRC[4]="\"PO-Revision-Date:"

    # Define replacement lines for pattern line.
    DST[0]="\"Project-Id-Version: ${TCAR_SCRIPT_NAME} ${TCAR_SCRIPT_VERSION}\\\n\""
    DST[1]="\"Report-Msgid-Bugs-To: Documentation SIG <centos-docs@centos.org.cu>\\\n\""
    DST[2]="\"Last-Translator: Documentation SIG <centos-docs@centos.org.cu>\\\n\""
    DST[3]="\"Language-Team: $(locale_getLanguageName)\\\n\""
    DST[4]="\"PO-Revision-Date: $(date "+%F %H:%M%z")\\\n\""

    # Change pattern lines with their replacement lines.
    while [[ $COUNT -lt ${#SRC[*]} ]];do
        sed -i -r "/${SRC[$COUNT]}/c${DST[$COUNT]}" ${PO}
        COUNT=$(($COUNT + 1))
    done

    # When the .pot file is created using xml2po the
    # `Report-Msgid-Bugs-To:' metadata field isn't created like it
    # does when xgettext is used. So, in order to have such metadata
    # field in all .pot files, verify its existence and add it if it
    # doesn't exist.
    egrep "^\"${SRC[1]}" ${PO} > /dev/null
    if [[ $? -ne 0 ]];then
        sed -i -r "/^\"${SRC[0]}/a${DST[1]}" ${PO}
    fi

    # Replace package information using gettext domain information.
    sed -i -r "s/PACKAGE/${TCAR_SCRIPT_NAME} ${TCAR_SCRIPT_VERSION}/g" ${PO}

    # Remove absolute path to the working copy so it doesn't appear on
    # comments related to locations. Remember that people can download
    # their working copies in different locations and we don't want to
    # version those changes each time a translation message be
    # updated. To be consistent about this, show path information from
    # first level on. Don't show the variable part of the path.
    sed -i -r "s,${TCAR_BASEDIR}/,,g" ${PO}

    # Unset array variables to avoid undesired concatenations.
    unset SRC
    unset DST

}
