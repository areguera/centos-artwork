#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Svg/Scripts/render_setLocalization.sh --
#   This function standardizes the way (.po) translation files are
#   applied to XML files (e.g., .docbook, .svg) in order to produce
#   their related translated instances, used to expand translation
#   markers and produce the final file format in different languages.
#   Assuming no translation file exists, an untranslated instance is
#   taken from the design model and created (i.e., just a copy) from
#   it.  Using a design model instance (translated or not) is required
#   in order to expand translation markers safely.
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

    local SOURCE=${1}
    local TARGET=${2}

    # Define which command will be used to output the template
    # content. This is required because template files might be found
    # as compressed files inside the repository.
    local COMMAND="/bin/cat"
    if [[ $(/usr/bin/file -b -i ${SOURCE}) =~ '^application/x-gzip$' ]];then
        COMMAND="/bin/zcat"
    fi

    local TRANSLATION=$(tcar_getTemporalFile "messages.po")

    if [[ ${#TRANSLATIONS[*]} -gt 0 ]];then

        # Verify existence of translation files.
        tcar_checkFiles -efi 'text/x-po' ${TRANSLATIONS[*]}

        # Combine available translations file into one translation
        # instance.
        msgcat -u -o ${TRANSLATION} ${TRANSLATIONS[*]}

        # Move to final location before processing source file in
        # order for relative calls (e.g., image files) inside the
        # source files can be found by xml2po and no warning be
        # printed from it.
        pushd $(dirname ${RENDER_TARGET}) > /dev/null

        # Create the translated instance of design model.
        ${COMMAND} ${SOURCE} | xml2po -a -l ${TCAR_SCRIPT_LANG_LC} \
            -p ${TRANSLATION} -o ${TARGET} -

        # Remove .xml2po.mo temporal file.
        if [[ -f ./.xml2po.mo ]];then
            rm ./.xml2po.mo
        fi

        # Return to previous location.
        popd > /dev/null

        # Remove instance created to store both licenses and template
        # translations.
        if [[ -f ${TRANSLATION} ]];then
            rm ${TRANSLATION}
        fi

        # xml2po bug? For some reason, xml2po is not adding the lang
        # attribute to refentry tag, when producing manpages document
        # types.  This make intrinsic docbook construction for
        # manpages like Name and Synopsis to be not localized.  This
        # doesn't happens with article and book document types.
        if [[ ${RENDER_FLOW} == 'manpage' ]];then
            sed -i -r "s/<refentry>/<refentry lang=\"${TCAR_SCRIPT_LANG_LC}\">/" ${TARGET}
        fi

    else

        ${COMMAND} ${SOURCE} > ${TARGET}

    fi

}
