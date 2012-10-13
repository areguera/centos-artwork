#!/bin/bash
#
# texinfo_updateOutputFileXhtml.sh -- This function exports
# documentation manual to HTML format.
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

function texinfo_updateOutputFileXhtml {

    # Output action message.
    cli_printMessage "${MANUAL_OUTPUT_BASEFILE}.xhtml.tar.bz2" --as-creating-line

    # Verify initialization files used by texi2html.
    cli_checkFiles -e ${MANUAL_TEMPLATE}/manual-init.pl
    cli_checkFiles -e ${MANUAL_TEMPLATE_L10N}/manual-init.pl

    # Verify transformation files used to modify texi2html output.
    cli_checkFiles -e ${MANUAL_TEMPLATE}/manual.sed
    cli_checkFiles -e ${MANUAL_TEMPLATE_L10N}/manual.sed

    # Clean up directory structure where xhtml files will be stored.
    # We don't want to have unused files inside it.
    if [[ -d ${MANUAL_OUTPUT_BASEFILE}-xhtml ]];then
        rm -r ${MANUAL_OUTPUT_BASEFILE}-xhtml
    fi

    # Prepare directory structure where xhtml files will be stored in.
    mkdir -p ${MANUAL_OUTPUT_BASEFILE}-xhtml

    # Add manual base directory path into directory stack to make it
    # the current working directory. This is done to reduce the path
    # information packaged inside `repository.xhtml.tar.bz2' file.
    pushd ${MANUAL_OUTPUT_BASEFILE}-xhtml > /dev/null

    # Update xhtml files. Use texi2html to export from texinfo file
    # format to xhtml using The CentOS Web default visual style.
    texi2html --lang=${CLI_LANG_LL} \
        --init-file=${MANUAL_TEMPLATE}/manual-init.pl \
        --init-file=${MANUAL_TEMPLATE_L10N}/manual-init.pl \
        -I ${TCAR_WORKDIR} \
        --output=${MANUAL_OUTPUT_BASEFILE}-xhtml \
        ${MANUAL_BASEFILE}.${MANUAL_EXTENSION}

    # Create `css' and `images' directories. In order to save disk
    # space, these directories are linked (symbolically) to their
    # respective locations inside the working copy. 
    ln -s ${TCAR_WORKDIR}/trunk/Identity/Webenv/Themes/Default/Docbook/1.69.1/Css Css
    ln -s ${TCAR_WORKDIR}/trunk/Identity/Images/Webenv Images

    # Remove directory where xhtml files are stored from directory
    # stack. The xhtml files have been already created.
    popd > /dev/null

    # Apply xhtml transformations. This transformation cannot be built
    # inside the initialization script (repository-init.pl). For example,
    # Would it be a possible way to produce different quotation HTML
    # outputs from the same texinfo quotation definition?  Instead,
    # once the HTML code is produced we can take que quotation HTML
    # definition plus the first letters inside it and transform the
    # structure to a completly different thing that can be handle
    # through classed inside CSS definitions.
    sed -r -i \
        -f ${MANUAL_TEMPLATE}/manual.sed \
        -f ${MANUAL_TEMPLATE_L10N}/manual.sed \
        ${MANUAL_OUTPUT_BASEFILE}-xhtml/*.xhtml

    # Compress directory structure where xhtml files are stored in.
    # This compressed version is the one we put under version control.
    # The directory used to build the compressed version is left
    # unversion for the matter of human revision.
    tar -cjf ${MANUAL_OUTPUT_BASEFILE}.xhtml.tar.bz2 ${MANUAL_OUTPUT_BASEFILE}-xhtml > /dev/null 2>&1 

}
