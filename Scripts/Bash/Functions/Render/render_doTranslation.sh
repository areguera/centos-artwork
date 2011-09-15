#!/bin/bash
#
# render_doTranslation.sh -- This function standardizes the way
# translation files are applied to design models in order to produce
# the translated instance that is used to expand translation markers
# and produce the base-rendition output.
#
# Assuming no translation file exists, the an untranslated instace
# from the design model is created (i.e., just a copy of it). Using a
# design model instance (translated or not) is required in order to
# expand translation markers safetly.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

    # Verify translation file existence and create template
    # instance accordingly.
    if [[ -f ${TRANSLATION} ]];then

        # Print final location of translation file.
        cli_printMessage "${TRANSLATION}" --as-translation-line

        # Create the translated instance of design model based on
        # whether the template file has DOCTYPE definition or not.
        if [[ ${TEMPLATE_HAS_DOCTYPE} -eq 0 ]];then
            xmllint --valid --noent ${TEMPLATE} \
                | xml2po -a -l $(cli_getCurrentLocale) -p ${TRANSLATION} -o ${INSTANCE} -
        else
            xml2po -a -l $(cli_getCurrentLocale) -p ${TRANSLATION} -o ${INSTANCE} ${TEMPLATE}
        fi

        # Remove .xml2po.mo temporal file.
        if [[ -f ${PWD}/.xml2po.mo ]];then
            rm ${PWD}/.xml2po.mo
        fi

    else

        # Create the non-translated instance of design model.
        if [[ ${TEMPLATE_HAS_DOCTYPE} -eq 0 ]];then
            xmllint --valid --noent ${TEMPLATE} > ${INSTANCE}    
        else
            cp ${TEMPLATE} ${INSTANCE}
        fi

    fi

    # Verify instance existence.
    cli_checkFiles $INSTANCE

}
