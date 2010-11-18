#!/bin/bash
#
# help_updateOutputFileHtml.sh -- This function updates manuals' html
# related output files.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

    # Output action message
    cli_printMessage "`gettext "Updating manual's html output"`" 'AsResponseLine'

    # Check html output directory
    [[ ! -d ${MANUALS_DIR[4]} ]] && mkdir -p ${MANUALS_DIR[4]}

    # Add html output directory into directory stack to make it the
    # current working directory. Otherwise texi2html may produce
    # incorrect paths to images included.
    pushd ${MANUALS_DIR[4]} > /dev/null

    # Update html files.  Use texi2html to export from texinfo file
    # format to html using CentOS Web default visual style.
    texi2html ${MANUALS_FILE[1]} --output=${MANUALS_DIR[4]} --split section \
        --nosec-nav \
        --css-include=/home/centos/artwork/trunk/Identity/Models/Css/Texi2html/stylesheet.css \
        -I=/home/centos/artwork

    # Apply html transformations. Html transformations rely on
    # Texi2html default html output. The main goal of these html
    # transformations is to build specific html structures that match
    # specific css definitions. This way we extend the visual style of
    # Texi2html default html output.
    sed -r -i \
        -f /home/centos/artwork/trunk/Identity/Models/Css/Texi2html/transformations.sed \
        ${MANUALS_DIR[4]}/*.html

    # Remove html output directory from directory stack.
    popd > /dev/null

}
