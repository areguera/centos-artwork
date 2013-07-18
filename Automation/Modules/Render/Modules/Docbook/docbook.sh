#!/bin/bash
#
# docbook.sh -- This function performs base-rendition actions for
# DocBook files.
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

function docbook {

    # Define absolute path to XSL files used for transforming DocBook
    # into other formats.
    local DOCBOOK_XSL="${TCAR_WORKDIR}/Identity/Webenv/Themes/Default/Docbook/1.69.1/Xsl"

    # Define absolute path to DocBook models. This path must take
    # until the directory which holds the main documentation docbook
    # file.
    local DOCBOOK_MODELS="$(dirname ${TEMPLATE})"

    # Verify absolute path to DocBook models.
    cli_checkFiles ${DOCBOOK_MODELS} -d

    # Create the non-translated instance of design model. 
    cp ${TEMPLATE} ${INSTANCE}

    # Expand common contents inside instance.
    docbook_setExpansionLicenses ${INSTANCE}

    # When translated instances are rendered, system entities (e.g.,
    # `%entity-name;') don't appear in the translated instance (it
    # seems that xml2po removes them) and this provokes DocBook
    # validation to fail.  So in order to pass the validation
    # successfully and automate the whole creation of system entities,
    # don't let this duty ion users'. Instead, make centos-art.sh
    # script responsible of it.
    docbook_setExpansionSystemEntities ${INSTANCE}

    # Print validating action.
    cli_printMessage "${INSTANCE}" --as-validating-line

    # Validate translated instance before processing it. This step is
    # very important in order to detect document's malformations and
    # warn you about it, so you can correct them. It is also necessary
    # to save them in a new file in order to make translation markers
    # expansion possible before transforming the DocBook instance into
    # other formats.
    xmllint --valid --noent ${INSTANCE} > ${INSTANCE}.tmp
    if [[ $? -ne 0 ]];then
        cli_printMessage "`gettext "Validation failed."`" --as-error-line
    fi

    # Update instance to add translation markers expansion.
    mv ${INSTANCE}.tmp ${INSTANCE}

    # Expand translation markers on the temporal instance with
    # entities already expanded.
    cli_expandTMarkers ${INSTANCE}

    # Verify translation file existence apply translation to docbook
    # design model instance in order to produce the translated design
    # model instance.
    if [[ -f ${TRANSLATION} ]];then
        docbook_setTranslation ${INSTANCE}
    fi

    # Convert DocBook source files to other formats.
    docbook_setConversionXhtmlChunks ${INSTANCE}
    docbook_setConversionXhtml ${INSTANCE}
    docbook_setConversionText

    # NOTE: The current transformation from DocBook to PDF fails when
    # we started to use DocBook <index /> tags inside DocBook files.
    # Probably we need to test what happen when a newer release of XSL
    # is used. Thus, comment production of PDF files until it can be
    # produced correctly.
    #docbook_setConversionXml2Pdf

    # NOTE: From version 5.0 on, DocBook specification is no longer a
    # SGML specification but an XML specification only. Thus,
    # transformations related to DocBook SGML specification won't be
    # supported in `centos-art.sh' script.

    # Perform format post-rendition.
    docbook_setPostRendition

    # Perform format last-rendition.
    docbook_setLastRendition

}
