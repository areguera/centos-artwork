#!/bin/bash
#
# locale_updateMessageXmlDocbook.sh -- This function retrives
# translation messages from Docbook files and creates related portable
# object template for them.
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

function locale_updateMessageXmlDocbook {

    # Print action message.
    cli_printMessage "${MESSAGES}.pot" --as-updating-line

    # Define regular expression to match extensions of shell scripts
    # we use inside the repository.
    local EXTENSION='docbook'

    # Define absolute paths to Docbook main file.
    local TEMPLATE=$(cli_getFilesList ${ACTIONVAL} \
        --maxdepth=1 --mindepth=1 --type='f' \
        --pattern="$(cli_getRepoName ${ACTIONVAL} -f)\.${EXTENSION}$")

    # Verify existence of docbook's main template file. We cannot go
    # on without it.
    cli_checkFiles -e ${TEMPLATE}

    # Define file name used as template instance. Here is where we
    # expand translation markers and entities before retrieving
    # translation messages.
    local INSTANCE=$(cli_getTemporalFile "$(basename ${TEMPLATE})")

    # Create instance from docbook's main file.
    cp ${TEMPLATE} ${INSTANCE}

    # Expand translation markers inside instance.
    cli_expandTMarkers ${INSTANCE}

    # Expand system entities definition.
    cli_exportFunctions "Render/Docbook/docbook_doTranslation"
    docbook_doTranslation ${INSTANCE}

    # Expand system entities definition.
    cli_exportFunctions "Render/Docbook/docbook_expandSystemEntities"
    docbook_expandSystemEntities ${INSTANCE}

    # Expand license block.
    cli_exportFunctions "Render/Docbook/docbook_expandLicenses"
    docbook_expandLicenses ${INSTANCE}

    # Create link to `Images' directory for validation to pass.
    # Otherwise, a validation error is reported because no path was
    # found to images.
    ln -s ${TCAR_WORKDIR}/Identity/Images/Webenv $(dirname ${INSTANCE})/Images

    # Move into temporal directory so paths can be found relatively.
    pushd $(dirname ${INSTANCE}) > /dev/null

    # Create portable object template from instance.
    xmllint --valid --noent ${INSTANCE} | xml2po -a - \
        | msgcat --output=${MESSAGES}.pot --width=70 --no-location -

    # Move out to initial location.
    popd > /dev/null

    # Remove instance.
    rm ${INSTANCE}

}
