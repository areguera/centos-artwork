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

function render_setLocalizedXml {

    local SOURCE=${1}
    local TARGET=${2}

    # Define which command will be used to output the template
    # content. This is required because template files might be found
    # as compressed files inside the repository.
    local COMMAND="/bin/cat"
    if [[ $(file -b -i ${SOURCES}) =~ '^application/x-gzip$' ]];then
        COMMAND="/bin/zcat"
    fi

    if [[ -f ${TRANSLATIONS[0]} ]];then

        # Define name of temporal file used as translation instance. 
        local TRANSLATION_INSTANCE=${TCAR_SCRIPT_TEMPDIR}/messages.po

        # Combine translations into the translation instance.
        msgcat -u -o ${TRANSLATION_INSTANCE} ${TRANSLATIONS[*]}

        # Create the translated instance of design model.
        ${COMMAND} ${SOURCE} | xml2po -a -l ${TCAR_SCRIPT_LANG_LL} \
            -p ${TRANSLATION_INSTANCE} -o ${TARGET} -

        # Remove .xml2po.mo temporal file.
        if [[ -f ./.xml2po.mo ]];then
            rm ./.xml2po.mo
        fi

        # Remove instance created to store both licenses and template
        # translations.
        if [[ -f ${TRANSLATION_INSTANCE} ]];then
            rm ${TRANSLATION_INSTANCE}
        fi

    else
        ${COMMAND} ${SOURCE} > ${TARGET}
    fi

}
