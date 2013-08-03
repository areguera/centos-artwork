#!/bin/bash
#
# locale_updateMessageXmlDocbook.sh -- This function retrieves
# translation messages from Docbook files and creates related portable
# object template for them.
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

function asciidoc {

    # Define location where translation files will be stored in.
    local L10N_WORKDIR=$(cli_getLocalizationDir ${ACTIONVAL})

    # Define regular expression to match extensions of shell scripts
    # we use inside the repository.
    local EXTENSION='docbook'

    # Define absolute paths to Docbook main file.
    local TEMPLATE=$(cli_getFilesList ${ACTIONVAL} \
        --maxdepth=1 --mindepth=1 --type='f' \
        --pattern=".+/$(cli_getRepoName ${ACTIONVAL} -f)\.${EXTENSION}$")

    # Process Docbook template files based on whether it is empty or
    # not. When it is empty, it is because there is not a Docbook main
    # file in the location provided to centos-art.sh script
    # command-line. In this case, we try to create one POT file to all
    # docbook files inside the location provided but without expanding
    # entities. When Docbook template file is not empty, expand
    # entities and create the POT file from a Docbook main file
    # instance, with all entities expanded. 
    if [[ -z ${TEMPLATE} ]];then
        locale_updateMessageXmlDocbookNoEntities
    else
        locale_updateMessageXmlDocbookWithEntities
    fi

}
