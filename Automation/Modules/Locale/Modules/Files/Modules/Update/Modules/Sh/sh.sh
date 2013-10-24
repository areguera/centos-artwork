#!/bin/bash
######################################################################
#
#   sh.sh -- This module retrieves translatable strings from shell
#   scripts files. Normally, this function takes the file provided as
#   argument in the command-line and creates a list of all files that
#   share the same file extension in the same directory structure and
#   retrieve translation messages from it.  Translation messages are
#   stored in a PO file for each supported language under the Locales
#   directory. In case the --recursive option is also provided, the
#   list of files to process is build recursively.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function sh {

    # Verify existence and type of file being processed.
    tcar_checkFiles -efi 'application/x-shellscript' "${RENDER_FROM}"

    local FILES=''
    local DIRECTORY=$(dirname ${RENDER_FROM})

    # Build list of all script files that xgettext will look for
    # translatable strings inside. By default only scripts in the
    # current directory will be looked out.
    if [[ ${LOCALE_FLAG_RECURSIVE} == 'true' ]];then
        FILES=$(tcar_getFilesList "${DIRECTORY}" \
            --type=f --pattern='.+\.sh$')
    else
        FILES=$(tcar_getFilesList "${DIRECTORY}" \
            --mindepth=1 --maxdepth=1 --type=f \
            --pattern='.+\.sh$')
    fi

    # Verify found files existence and type before processing them.
    tcar_checkFiles -efi 'application/x-shellscript' "${FILES}"

    # Retrieve translatable strings from shell script files and create
    # the portable object template (.pot) from them.
    xgettext --output=${POT_FILE} --width=70 \
        --package-name=${PACKAGE_NAME} \
        --package-version=${PACKAGE_VERSION} \
        --msgid-bugs-address="centos-l10n-${TCAR_SCRIPT_LANG_LL}@centos.org.cu" \
        --copyright-holder="$(tcar_printCopyrightInfo --holder)" \
        --sort-by-file ${FILES}

    # When there is not any translatable string to retrieve from file,
    # the POT file is not created. Be aware of this when retrieving
    # translatable strings from several files (e.g., you are
    # processing a directory full of svgz files, but some of them have
    # no translatable string inside).
    if [[ ! -f ${POT_FILE} ]];then
        return
    fi

    # Verify, initialize or update portable objects from portable
    # object templates.
    update_convertPotToPo "${POT_FILE}" "${PO_FILE}"

    # At this point some changes might be realized inside the PO file,
    # so we need to update the related MO file based on recently
    # updated PO files here in order for `centos-art.sh' script to
    # print out the most up to date revision of localized messages.
    # Notice that this is required only if we were localizing shell
    # scripts because xml-based files don't need the MO files.
    update_convertPoToMo

}
