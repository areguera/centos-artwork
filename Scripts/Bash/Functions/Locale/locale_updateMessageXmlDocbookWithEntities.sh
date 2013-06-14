#!/bin/bash
#
# locale_updateMessageXmlDocbookWithEntities.sh -- This function
# creates an instance of Docbook main file, expands entities inside
# it, retrieves all translatable strings from main file instance, and
# creates the related portable object template POT for them.
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

function locale_updateMessageXmlDocbookWithEntities {

    # Define location of the file used to create both portable object
    # templates (.pot) and portable objects (.po) files.
    local MESSAGES="${L10N_WORKDIR}/messages"

    # Print action message.
    cli_printMessage "${MESSAGES}.pot" --as-updating-line

    # Define file name used as template instance. Here is where we
    # expand translation markers and entities before retrieving
    # translation messages.
    local INSTANCE=$(cli_getTemporalFile "$(basename ${TEMPLATE})")

    # Create the non-translated instance of design model.
    cp ${TEMPLATE} ${INSTANCE}

    # Expand common contents inside instance.
    cli_exportFunctions "Render/Docbook/docbook_expandLicenses"
    docbook_expandLicenses ${INSTANCE}

    # When translated instances are rendered, system entities (e.g.,
    # `%entity-name;') don't appear in the translated instance (it
    # seems that xml2po removes them) and this provokes DocBook
    # validation to fail.  So in order to pass the validation
    # successfully and automate the whole creation of system entities,
    # don't let this duty ion users'. Instead, make centos-art.sh
    # script responsible of it.
    cli_exportFunctions "Render/Docbook/docbook_expandSystemEntities"
    docbook_expandSystemEntities ${INSTANCE}

    # Create portable object template from instance.  Validate
    # translated instance before processing it. This step is very
    # important in order to detect document's malformations and warn
    # you about it, so you can correct them. 
    xmllint --valid --noent ${INSTANCE} | xml2po -a -l ${CLI_LANG_LC} - \
        | msgcat --output=${MESSAGES}.pot \
                 --width=70 --no-location -

    # Verify, initialize or merge portable objects from portable
    # object templates.
    locale_updateMessagePObjects "${MESSAGES}"

}
