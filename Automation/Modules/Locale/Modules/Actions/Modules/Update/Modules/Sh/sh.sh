#!/bin/bash
#
#   Modules/Locale/Modules/Update/Modules/Sh/sh.sh -- This function
#   parses shell scripts source files under action value and retrieves
#   translatable strings in order to creates/updates both the portable
#   object template (.pot) and the portable object (.po) related.
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

function sh {

    # Print action message.
    tcar_printMessage "${POT_FILE}" --as-updating-line

    # Retrieve translatable strings from shell script files and create
    # the portable object template (.pot) from them.
    xgettext --output=${POT_FILE} --width=70 \
        --package-name=${TCAR_SCRIPT_NAME} \
        --package-version=${TCAR_SCRIPT_VERSION} \
        --msgid-bugs-address="centos-l10n-${TCAR_SCRIPT_LANG_LL}@centos.org.cu" \
        --copyright-holder="$(tcar_printCopyrightInfo --holder)" \
        --sort-by-file ${SOURCES[*]}

    # Verify, initialize or update portable objects from portable
    # object templates.
    locale_convertPotToPo "${POT_FILE}" "${PO_FILE}"

    # At this point some changes might be realized inside the PO file,
    # so we need to update the related MO file based on recently
    # updated PO files here in order for `centos-art.sh' script to
    # print out the most up to date revision of localized messages.
    # Notice that this is required only if we were localizing shell
    # scripts.
    locale_convertPoToMo

}
