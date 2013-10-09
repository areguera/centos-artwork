#!/bin/bash
######################################################################
#
#   file.sh -- This module standardize localization of files inside
#   the repository.
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

function file {

    # Define absolute path to argument passed in the command-line.
    local FILE=$(tcar_checkRepoDirSource "${1}")

    # Verify argument passed in the command-line does exist and is a
    # regular file.
    tcar_checkFiles -ef ${FILE}

    # Define file name.
    local FILE_NAME="$(basename ${FILE})"

    # Define file extension.
    local FILE_EXTENSION=$(echo ${FILE} | sed -r 's/.+\.([[:alnum:]]+)$/\1/')

    # Define absolute path to directory holding the files to process.
    local DIRECTORY=$(dirname ${FILE})

    # Define list of files to process.
    local RENDER_FROM=$(locale_getFilesList)

    # Define absolute path to directory holding language-specific
    # content.
    local LOCALE_FROM=${DIRECTORY}/Locales
    if [[ ! -d ${LOCALE_FROM} ]];then
        mkdir ${LOCALE_FROM}
    fi

    # Define absolute path to portable and machine objects.
    local POT_FILE=${LOCALE_FROM}/${FILE_NAME}.pot
    local PO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/${FILE_NAME}.po
    local MO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/LC_MESSAGES/${FILE_NAME}.mo

    # Define the rendition type you want to perform.
    local RENDER_TYPE=${FILE_EXTENSION}

    # Define the translation file you want to use.
    local -a TRANSLATIONS
    TRANSLATIONS[0]=${PO_FILE}

    # Define translation file. This is from which translatable strings
    # will be retrieved.
    local -a SOURCES
    for SOURCE in ${RENDER_FROM};do
        SOURCES[((++${#SOURCES[*]}))]=${SOURCE}
    done

    # Define package name written in POT and PO files. This is the
    # name of the initialization file you provided as argument to the
    # command line to provide localization for.
    local PACKAGE_NAME=$(basename ${FILE_NAME})

    # Define package version written in POT and PO files. The script
    # version is used here.  Modules doesn't have a version by now.
    # They share the same version of the centos-art.sh script.
    local PACKAGE_VERSION=${TCAR_SCRIPT_VERSION}

    # Process configuration variables through locale's actions module.
    tcar_setModuleEnvironment -m "actions" -t "sibling"

    # Print report about how many files were processed.
    if [[ ${LOCALE_FLAG_REPORT} == 'true' ]];then
        local TOTAL_FILES_PROCESSED=${#SOURCES[*]}
        tcar_printMessage "`eval_ngettext "Translatable strings were extracted from \\\$TOTAL_FILES_PROCESSED file." \
                                          "Translatable strings were extracted from \\\$TOTAL_FILES_PROCESSED files." \
                                          ${TOTAL_FILES_PROCESSED}`" --as-banner-line
    fi

}
