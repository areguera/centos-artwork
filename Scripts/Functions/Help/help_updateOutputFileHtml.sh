#!/bin/bash
#
# help_updateOutputFileHtml.sh -- This function exports
# documentation manual to HTML format.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_updateOutputFileHtml {

    # Output action message.
    cli_printMessage "${MANUAL_BASEFILE}-html" 'AsUpdatingLine'

    # Check html output directory
    [[ ! -d ${MANUAL_BASEFILE}-html ]] && mkdir -p ${MANUAL_BASEFILE}-html

    # Add html output directory into directory stack to make it the
    # current working directory. Otherwise texi2html may produce
    # incorrect paths to images included.
    pushd ${MANUAL_BASEFILE}-html > /dev/null

    # Update html files.  Use texi2html to export from texinfo file
    # format to html using CentOS Web default visual style.
    texi2html ${MANUAL_BASEFILE}.texi --output=${MANUAL_BASEFILE}-html --split section \
        --nosec-nav \
        --css-include=${HOME}/artwork/trunk/Identity/Models/Css/Texi2html/stylesheet.css \
        -I=${HOME}/artwork

    # Apply html transformations. Html transformations rely on
    # Texi2html default html output. The main goal of these html
    # transformations is to build specific html structures that match
    # specific css definitions. This way we extend the visual style of
    # Texi2html default html output.
    sed -r -i \
        -f ${HOME}/artwork/trunk/Identity/Models/Css/Texi2html/transformations.sed \
        ${MANUAL_BASEFILE}-html/*.html

    # Remove html output directory from directory stack.
    popd > /dev/null

}
