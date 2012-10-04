#!/bin/bash
#
# docbook.sh -- This function performs base-rendition actions for
# DocBook files.
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

function docbook {

    # Define absolute path to XSL files used for transforming Docbook
    # into other formats.
    local DOCBOOK_XSL="${TCAR_WORKDIR}/trunk/Identity/Webenv/Themes/Default/Docbook/1.69.1/Xsl"

    # Define absolute path to Docbook models.
    local DOCBOOK_MODELS="${TCAR_WORKDIR}/trunk/Documentation/Models/Docbook"

    # Exapand common contents inside instance.
    docbook_expandLicenses ${INSTANCE}

    # When translated instances are rendered, system entities (e.g.,
    # `%entity-name;') don't appear in the translated instance (it
    # seems that xml2po removes them) and this provokes Docbook
    # validation to fail.  So in order to pass the validation
    # successfully and automate the whole creation of system entities,
    # don't let this duty ion users'. Instead, make centos-art.sh
    # script responsible of it.
    docbook_expandSystemEntities ${INSTANCE}

    # Print validating action.
    cli_printMessage "${INSTANCE}" --as-validating-line

    # Validate translated instance before processing it. This step is
    # very important in order to detect document's malformations and
    # warn you about it, so you can correct them. It is also necessary
    # to save them in a new file in order to make translation markers
    # expansion possible before transforming the Docbook instance into
    # other formats.
    xmllint --valid --noent ${INSTANCE} > ${INSTANCE}.tmp
    if [[ $? -ne 0 ]];then
        cli_printMessage "`gettext "Validation failed."`" --as-error-line
    fi

    # Expand translation markers on temporal instance.
    cli_expandTMarkers ${INSTANCE}.tmp

    # Update instance to add translation markers expansion.
    mv ${INSTANCE}.tmp ${INSTANCE}

    # Convert DocBook source files to other formats.
    docbook_convertToXhtmlChunk
    docbook_convertToXhtml
    docbook_convertToText
    docbook_convertToPdfFromXml

    # NOTE: From version 5.0 on, DocBook specification is no longer a
    # SGML specification but an XML specification only. Thus,
    # transformations related to DocBook SGML specification won't be
    # supported in `centos-art.sh' script.

    # Perform format post-rendition.
    docbook_doPostActions

    # Perform format last-rendition.
    docbook_doLastActions

}
