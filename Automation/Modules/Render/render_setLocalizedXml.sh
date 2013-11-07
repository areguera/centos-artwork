#!/bin/bash
######################################################################
#
#   render_setLocalizedXml.sh -- This function standardizes the way
#   (.po) translation files are applied to XML files (e.g., .docbook,
#   .svg) in order to produce their related translated instances, used
#   to expand translation markers and produce the final file format in
#   different languages.  Assuming no translation file exists, an
#   untranslated instance is taken from the design model and created
#   (i.e., just a copy) from it.  Using a design model instance
#   (translated or not) is required in order to expand translation
#   markers safely.
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

function render_setLocalizedXml {

    # Define absolute path to source instance.
    local SOURCE="${1}"

    # Define absolute path to target instance.
    local TARGET="${2}"

    # Verify source instance and the no-locale flag. When source
    # instance already exists, don't create a new file for it.
    # Instead, link it using a symbolic link.
    if [[ -f ${SOURCE} ]];then
        tcar_checkFiles -i 'text/xml' ${SOURCE}
        if [[ ${SOURCE} =~ "^${TCAR_SCRIPT_TEMPDIR}" ]];then
            /bin/ln -s ${SOURCE} ${TARGET}
            return
        elif [[ ${RENDER_FLAG_NO_LOCALE} == 'true' ]];then
            tcar_printFile ${SOURCE} > ${TARGET}
            tcar_checkFiles -i 'text/xml' ${TARGET}
            return
        fi
    fi

    # Verify existence of translation files.
    tcar_checkFiles -efi 'text/x-po' ${TRANSLATIONS[*]}

    # Define absolute path to translation instance.
    local TRANSLATION=$(tcar_getTemporalFile "messages.po")

    # Combine available translations file into one translation
    # instance.
    msgcat -u -o ${TRANSLATION} ${TRANSLATIONS[*]}

    # Verify existence of final location. In case it doesn't exist,
    # create it.
    if [[ $(dirname ${RENDER_TARGET}) ]];then
        mkdir -p $(dirname ${RENDER_TARGET})
    fi

    # Move to final location before processing source file in order
    # for relative calls (e.g., image files) inside the source files
    # can be found by xml2po and no warning be printed from it.
    pushd $(dirname ${RENDER_TARGET}) > /dev/null

    # Create the localized instance from design model.
    tcar_printFile ${SOURCE} | xml2po -a -l ${TCAR_SCRIPT_LANG_LC} \
        -p ${TRANSLATION} -o ${TARGET} -

    # Remove .xml2po.mo temporal file.
    if [[ -f ./.xml2po.mo ]];then
        rm ./.xml2po.mo
    fi

    # Return to previous location.
    popd > /dev/null

    # Remove instance created to store template translations.
    if [[ -f ${TRANSLATION} ]];then
        rm ${TRANSLATION}
    fi

}
