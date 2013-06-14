#!/bin/bash
#
# docbook_doTranslation.sh -- This function standardizes the way
# translation files are applied to DocBook design models in order to
# produce the translated instance that is used to expand translation
# markers and produce different output formats.
#
# Assuming no translation file exists, an untranslated instance is
# taken from the design model and created (i.e., just a copy) from it.
# Using a design model instance (translated or not) is required in
# order to expand translation markers safely.
#
# Copyright (C) 2009-2013 The CentOS Project
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function docbook_doTranslation {

    # Print final location of translation file.
    cli_printMessage "${TRANSLATION}" --as-translation-line

    # Create translation instance to combine both template translation
    # and licenses translations.
    local TRANSLATION_INSTANCE=${TMPDIR}/messages.po
    
    # Define path to DocBook locales using models as reference.
    local DOCBOOK_LOCALES=$(cli_getLocalizationDir "$DOCBOOK_MODELS")

    # Define list of all locale files you want to combine. This
    # include the localization files related to all different kind of
    # licenses you want to use in the main documentation file and the
    # localization file of the main documentation file, as well.
    local DOCBOOK_PO_FILES="${TCAR_WORKDIR}/Locales/Documentation/Models/Docbook/Default/Licenses/Gfdl/${CLI_LANG_LC}/messages.po \
        ${TCAR_WORKDIR}/Locales/Documentation/Models/Docbook/Default/Licenses/Gpl/${CLI_LANG_LC}/messages.po \
        ${TRANSLATION}"

    # Be sure the files we want to combine do exist.
    cli_checkFiles -e ${DOCBOOK_PO_FILES}

    # Combine license translations with template translation in order
    # to reuse licenses translations in template files without
    # including them in template portable objects. In the case of
    # DocBook templates, translations related to licenses are required
    # because license content is expanded at execution time inside the
    # DocBook instance used by XSL processor during transformation.
    msgcat --output=${TRANSLATION_INSTANCE} \
        --width=70 --no-location --use-first ${DOCBOOK_PO_FILES}

    # At this point the translation instance with both licenses and
    # manual translations have been saved. Now it is required to
    # expand entities so it could be possible to create a translated
    # instance with all the content inside.

    # Print action message.
    cli_printMessage "${INSTANCE}" --as-translating-line

    # Create the translated instance of design model instance with all
    # entities and translation markers expanded.
    xml2po -a -l ${CLI_LANG_LL} \
        -p ${TRANSLATION_INSTANCE} \
        -o ${INSTANCE}-${CLI_LANG_LL}.tmp ${INSTANCE}

    # Rename final instance so it can be treated as just instance. 
    mv ${INSTANCE}-${CLI_LANG_LL}.tmp ${INSTANCE}

    # Remove .xml2po.mo temporal file.
    if [[ -f ${PWD}/.xml2po.mo ]];then
        rm ${PWD}/.xml2po.mo
    fi

    # Verify instance existence.
    cli_checkFiles -e $INSTANCE

}
