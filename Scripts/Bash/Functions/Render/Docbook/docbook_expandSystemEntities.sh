#!/bin/bash
#
# docbook_expandSystemEntities.sh -- This function expands system
# entities required by DocBook projects stored under
# `Documentation/Manuals' directory.
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

function docbook_expandSystemEntities {

    # Define absolute path to instance where all operations will take
    # place in.
    local INSTANCE=$1

    # Define absolute path to both common and specific system
    # entities.
    local ENTITIES_PATHS="$(cli_getFilesList ${DOCBOOK_MODELS}/Default/Book $(dirname ${TEMPLATE}) \
        --pattern='^.*/[[:alpha:]-]+\.ent$' --maxdepth=1 --mindepth=1 --type='f')"

    # Build definition of both common and specific system entities.
    local ENTITIES="$(\
        for ENTITY_PATH in $ENTITIES_PATHS;do
            local ENTITY_NAME=$(basename ${ENTITY_PATH})
            echo '\n\t<!ENTITY % '${ENTITY_NAME}' SYSTEM "'${ENTITY_PATH}'">\n'
            echo '\t%'${ENTITY_NAME}';'
        done)"

    # Define both xml and docbook public definition.
    local PREAMBLE="<?xml version=\"1.0\" ?>"
    PREAMBLE="${PREAMBLE}\n<!DOCTYPE book PUBLIC \"-//OASIS//DTD DocBook XML V4.4//EN\" "
    PREAMBLE="${PREAMBLE}\n\t\"http://www.oasis-open.org/docbook/xml/4.4/docbookx.dtd\" ["
    PREAMBLE="${PREAMBLE}\n${ENTITIES}"
    PREAMBLE="${PREAMBLE}\n\t]>"

    # Remove both xml and docbook preamble from instance and insert
    # it again with definitions of required common and specific system
    # entities.
    sed -r -i "1,2c$(echo $PREAMBLE)" ${INSTANCE}

}
