#!/bin/bash
#
# locale_updateMessageXmlDocbookNoEntities.sh -- This function creates
# an instance of one or more Docbook files without expanding entities
# inside it, retrieves all translatable strings from main file
# instance, and creates the related portable object template POT for
# them. This is useful to localize Docbook files that aren't direct
# part of a documentation manual but included at rendition time (e.g.,
# Docbook files holding license information).
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

function locale_updateMessageXmlDocbookNoEntities {

    # In case no path to Docbook main file is not found, go deeper
    # into the documentation models directory structure looking for
    # files that do match the name of the directory who hold it, and
    # use that file as template to initiate localization process. The
    # way to reach these files have to be through --filter options
    # because we want to respect the restrictions imposed by
    # locale_isLocalizable function inside the repository.
    # CAUTION: entity expansion the files found this way will be # ignored.
    local TEMPLATES=$(cli_getFilesList ${ACTIONVAL} --type='f' \
        --pattern=".+/${FLAG_FILTER}.+\.${EXTENSION}$")

    # Verify number of template files found and define what kind of
    # processing they are going to have. In case more than one
    # template file be found and because entity expansion will be
    # ignored in such case, the whole process of creating the PO file
    # for all these templates is also different (simpler) from that we
    # use with entity expansion.

    for TEMPLATE in ${TEMPLATES};do

        # Redefine path related to localization work directory.
        local L10N_WORKDIR=$(cli_getLocalizationDir "$TEMPLATE")

        # Define location of the file used to create both portable
        # object templates (.pot) and portable objects (.po) files.
        local MESSAGES="${L10N_WORKDIR}/messages"

        # Print action message.
        cli_printMessage "${MESSAGES}.pot" --as-updating-line

        # Extract translatable strings from docbook files and merge
        # them down into related messages file.
        xml2po -a -l ${CLI_LANG_LL} -o ${MESSAGES}.pot ${TEMPLATE} 

        # Verify, initialize or merge portable objects from portable
        # object templates.
        locale_updateMessagePObjects "${MESSAGES}"

    done

}
