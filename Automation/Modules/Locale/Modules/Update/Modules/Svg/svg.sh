#!/bin/bash
######################################################################
#
#   Modules/Locale/Modules/Svg/svg.sh -- This function parses
#   XML-based files (e.g., scalable vector graphics), retrieves
#   translatable strings and creates/update gettext portable objects.
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

function svg {

    local FILE=''
    local POT=$(dirname ${CONFIGURATION})/messages.pot
    local TEMPFILES=''

    # Define regular expression to match extensions of shell scripts
    # we use inside the repository.
    local EXTENSION='(svgz|svg)'

    # Process list of directories, one by one.
    for FILE in ${SOURCES[*]};do

        local TEMPFILE=$(tcar_getTemporalFile $(basename ${FILE}))

        if [[ $(file -b -i ${FILE}) =~ '^application/x-gzip$' ]];then
            /bin/zcat ${FILE} > ${TEMPFILE}
        else
            /bin/cat ${FILE} > ${TEMPFILE}
        fi

        TEMPFILES="${TEMPFILE} ${TEMPFILES}"

    done

    #
    if [[ ! -d $(dirname ${TRANSLATIONS[0]}) ]];then
        mkdir -p $(dirname ${TRANSLATIONS[0]})
    fi

    # Print action message.
    tcar_printMessage "${POT}" --as-creating-line

    # Create the portable object template.
    cat ${TEMPFILES} | xml2po -a -l ${TCAR_SCRIPT_LANG_LC} - \
        | msgcat --output=${POT} --width=70 --no-location -

    # Verify, initialize or merge portable objects from portable
    # object templates.
    locale_updateMessagePObjects "${POT}"

}
