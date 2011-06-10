#!/bin/bash
#
# svg_convertToText.sh -- This function takes the XHTML file produced
# by docbook_convertToXhtml and produces one plain-text file (i.e.,
# without markup inside).
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function xhtml_convertToText {

    # Verify existence of HTML file. If `.xhtml' file doesn't exist
    # don't create text file. The `.xhtml' file is required in order
    # to create the `.txt' file.
    if [[ ! -f ${FILE}.xhtml ]];then
       return 
    fi

    local COMMAND=''
    local OPTIONS=''

    # Define the command path to text-based web browser and options
    # used to produce plain-text files. Most of these programs have a
    # dump option that print formatted plain-text versions of given
    # HTML file to stdout.
    if [[ -x '/usr/bin/lynx' ]];then
        COMMAND='/usr/bin/lynx'
        OPTIONS='-force_html -nolist -width 70 -dump'
    elif [[ -x '/usr/bin/elinks' ]];then
        COMMAND='/usr/bin/elinks'
        OPTIONS='-force_html -no-numbering -no-references -width 70 -dump'
    elif [[ -x '/usr/bin/w3m' ]];then
        COMMAND='/usr/bin/w3m'
        OPTIONS='-dump'
    fi

    if [[ $COMMAND != '' ]];then

        # Print action message.
        if [[ -f ${FILE}.txt ]];then
            cli_printMessage "${FILE}.txt" --as-updating-line
        else
            cli_printMessage "${FILE}.txt" --as-creating-line
        fi

        # Convert from HTML to plain-text without markup.
        ${COMMAND} ${OPTIONS} ${FILE}.xhtml > ${FILE}.txt

    else
        cli_printMessage "`gettext "No way to convert from XHTML to plain-text found."`" --as-error-line
    fi

}
