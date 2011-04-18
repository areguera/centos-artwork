#!/bin/bash
#
# help_updateOutputFileXhtml.sh -- This function exports
# documentation manual to HTML format.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_updateOutputFileXhtml {

    # Output action message.
    cli_printMessage "${MANUAL_BASEFILE}.xhtml.tar.bz2" 'AsUpdatingLine'

    # Redefine manual base file to use just the file base name.
    local MANUAL_BASEFILE=$(basename "$MANUAL_BASEFILE")

    # Add manual base directory path into directory stack to make it
    # the current working directory. This is done to reduce the path
    # information packaged inside `repository.xhtml.tar.bz2' file.
    pushd ${MANUAL_BASEDIR} > /dev/null

    # Prepare directory structure where xhtml files will be stored in.
    [[ ! -d ${MANUAL_BASEFILE}.xhtml ]] && mkdir -p ${MANUAL_BASEFILE}.xhtml

    # Clean up directory structure where xhtml files will be stored.
    # We don't want to have unused files inside it.
    [[ $(ls ${MANUAL_BASEFILE}.xhtml > /dev/null) ]] && rm ${MANUAL_BASEFILE}.xhtml/*.xhtml

    # Add directory where xhtml files will be sotred in into directory
    # stack to make it the current working directory. This is required
    # in order for include paths to be constructed correctly.
    pushd ${MANUAL_BASEFILE}.xhtml > /dev/null

    # Update xhtml files.  Use texi2html to export from texinfo file
    # format to html using CentOS Web default visual style.
    texi2html --init-file=${MANUAL_BASEDIR}/${MANUAL_BASEFILE}-init.pl \
        --output=${MANUAL_BASEDIR}/${MANUAL_BASEFILE}.xhtml \
        ${MANUAL_BASEDIR}/${MANUAL_BASEFILE}.texi

    # Remove directory where xhtml files are stored from directory
    # stack. The xhtml files have been already created.
    popd > /dev/null

    # Apply xhtml transformations. This transformation cannot be built
    # inside the initialization script (repository.init). For example,
    # I can't see a possible way to produce different quotation HTML
    # outputs from the same texinfo quotation definition. Instead,
    # once the HTML code is produced we can take que quotation HTML
    # definition plus the first letters inside it and transform the
    # structure to a completly different thing that can be handle
    # through classed inside CSS definitions.
    sed -r -i -f ${MANUAL_BASEFILE}.sed ${MANUAL_BASEFILE}.xhtml/*.xhtml

    # Compress directory structure where xhtml files are stored in.
    # This compressed version is the one we put under version control.
    # The directory used to build the compressed version is left
    # unversion for the matter of human revision.
    tar -cjf ${MANUAL_BASEFILE}.xhtml.tar.bz2 ${MANUAL_BASEFILE}.xhtml

    # Remove manual base directory from directory stack.
    popd > /dev/null

}
