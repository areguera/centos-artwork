#!/bin/bash
#
# render_doTranslation.sh -- This function standardizes the way
# translation files are applied to design models in order to produce
# the translated instance that is used to expand translation markers
# and produce the base-rendition output.
#
# Assuming no translation file exists, an untranslated instace is
# taken from the design model and created (i.e., just a copy) from it.
# Using a design model instance (translated or not) is required in
# order to expand translation markers safetly.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function render_doTranslation {

    # Define which command will be used to output the template
    # content. This is required because template files might be found
    # as compressed files inside the repository.
    local COMMAND="/bin/cat"
    if [[ $(file -b -i $TEMPLATE) =~ '^application/x-gzip$' ]];then
        COMMAND="/bin/zcat"
    fi

    # Move into template's directory in order to satisfy relative
    # entities.  Take care that some XML documents (e.g., DocBook
    # documents) can use entities relatively from their base
    # locations. In order to process such documents, it is necessary
    # to put the template directory up in the directory stack and
    # create the instance from there. Thus, it is possible to expand
    # relative entities correctly when validating the document.
    pushd $(dirname $TEMPLATE) > /dev/null

    # Verify translation file existence and create template
    # instance accordingly.
    if [[ -f ${TRANSLATION} ]];then

        # Print final location of translation file.
        cli_printMessage "${TRANSLATION}" --as-translation-line

        # Create translation instance to combine both template
        # translation and licenses translations.
        local TRANSLATION_INSTANCE=$(cli_getTemporalFile ${TRANSLATION})
    
        if [[ ${TEMPLATE} =~ "${TCAR_WORKDIR}/trunk/Documentation/.+$" ]];then

            # Combine license translations with template translation
            # in order to reuse licenses translations in template
            # files without including them in template portable
            # objects. In the case of Docbook templates, translations
            # related to licenses are required because license content
            # is expanded at execution time inside the docbook
            # instance used by XSL processor during transformation.
            cli_exportFunctions "Locale/locale_combineLicenseMessages"
            locale_combineLicenseMessages ${TRANSLATION_INSTANCE} ${TRANSLATION}

        else

            # In the case of SVG and other files, license translations
            # is not required so we don't combine it into the template
            # translation.
            cp ${TRANSLATION} ${TRANSLATION_INSTANCE}

        fi

        # Create the translated instance of design model.
        ${COMMAND} ${TEMPLATE} | xml2po -a -l ${CLI_LANG_LL} \
            -p ${TRANSLATION_INSTANCE} -o ${INSTANCE} -

        # Remove .xml2po.mo temporal file.
        if [[ -f ${PWD}/.xml2po.mo ]];then
            rm ${PWD}/.xml2po.mo
        fi

        # Remove instance created to store both licenses and template
        # translations.
        if [[ -f ${TRANSLATION_INSTANCE} ]];then
            rm ${TRANSLATION_INSTANCE}
        fi

    else

        # Create the non-translated instance of design model. 
        ${COMMAND} ${TEMPLATE} > ${INSTANCE}

    fi

    # Return to where we were.
    popd > /dev/null

    # Verify instance existence.
    cli_checkFiles -e $INSTANCE

}
