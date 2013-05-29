#!/bin/bash
#
# docbook_expandLicenses.sh -- This function modifies the final
# DocBook instance to add license information. We are doing this way
# because using XInclude doesn't work and we want to reuse license
# information in all documents. So, if we cannot link the files, we
# modify the final instance and append the license information to it.
# Later, to reuse translation messages, the locale functionality takes
# care of merging po files related to licenses into documentation po
# file so changes made to licenses translations will also be available
# to documentation manuals in different languages.
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

function docbook_expandLicenses {

    local INSTANCE=$1

    # Define absolute path to DocBook models.
    local DOCBOOK_MODELS="${TCAR_WORKDIR}/Documentation/Models/Docbook"

    # Define list of files holding licenses you want to include. Note
    # even this files are not inside the documentation structure
    # itself, they are connected with it. The files holding license
    # information does contain id information used inside the
    # documentation structure at cross references.
    local LICENSES="${DOCBOOK_MODELS}/Default/Licenses/gpl.docbook \
        ${DOCBOOK_MODELS}/Default/Licenses/gfdl.docbook"

    # Define top level structure in the instance. This is the tag
    # defined in the second field of DOCTYPE definition.
    local DOCTYPE=$(egrep '^<!DOCTYPE ' $INSTANCE | egrep '^<!DOCTYPE' \
        | gawk '{ print $2 }')

    # Define temporal file to store license block.
    local BLOCK=$(cli_getTemporalFile "licenses.docbook")

    # Build license block into memory.
    BLOCK="<!-- Licenses -->\n"
    BLOCK="${BLOCK}\n<part id=\"licenses\">\n"
    BLOCK="${BLOCK}\n<title>`gettext "Licenses"`</title>\n"
    BLOCK="${BLOCK}\n$(cat ${LICENSES} | sed -r '/<\?xml/,/]>/d')\n"
    BLOCK="${BLOCK}\n</part>\n"
    BLOCK="${BLOCK}\n<!-- Back matter -->\n"

    # Expand the licenses section. Remove everything in-between
    # Licenses and Back matter comment. Recreate the comments to
    # support further actualizations and concatenate license
    # information without their document type definitions preamble.
    # This is required in order to prevent validation errors and reuse
    # (through locale functionality) the translation messages already
    # available for these license files. Finally, close any open tag.
    sed -r -i -e "/<!-- Licenses -->/,/<!-- Back matter -->/c$(echo ${BLOCK})" $INSTANCE

}
