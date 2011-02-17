#!/bin/bash
#
# shell_updateTopComment.sh -- This function replaces top comment
# section inside shell scripts (*.sh) with one of many pre-defined
# templates available. Use this function to maintain shell scripts top
# comments inside repository.
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

function shell_updateCopyright {

    local FILE=''
    local COUNT=0
    local FILES=''
    local INSTANCE=''
    local TEMPLATES=''
    local -a TITLE
    local -a VALUE
    local -a PATTERN
    local -a PATTERN_MSG
    local -a DEFAULT
    local -a MARKER

    # Define absolute path to template file.
    TEMPLATE="/home/centos/artwork/trunk/Scripts/Bash/Functions/Shell/Config/tpl_forCopyright.sed"

    # Check template file existence.
    cli_checkFiles $TEMPLATE 'f'

    # Define file name to template instance.
    INSTANCE=$(cli_getTemporalFile $TEMPLATE)

    # Define copyright information.
    TITLE[0]="`gettext "Copyright holder"`"
    TITLE[1]="`gettext "Copyright year"`"

    # Define translation marker. These values are used inside
    # template file.
    MARKER[0]='=COPYRIGHT_HOLDER='
    MARKER[1]='=COPYRIGHT_YEAR='

    # Define pattern. These values are used as regular
    # expression patterns for user's input further verification.
    PATTERN[0]='^([[:alnum:] _-.]+)?$'
    PATTERN[1]='^([[:digit:]]{4})?$'

    # Define pattern message. These values are used as output
    # message when user's input doesn't match the related pattern.
    PATTERN_MSG[0]="`gettext "Try using alphanumeric characters."`"
    PATTERN_MSG[1]="`gettext "Try using numeric characters."`"

    # Define default values.
    DEFAULT[0]="The CentOS Project. `gettext "All rights reserved."`"
    DEFAULT[1]=$(date +%Y)

    # Initialize values using user's input.
    cli_printMessage "`gettext "Enter the information you want to apply:"`"
    while [[ $COUNT -ne ${#TITLE[*]} ]];do

        # Request value.
        cli_printMessage "${TITLE[$COUNT]}" 'AsRequestLine'
        read VALUE[$COUNT]

        # Sanitate values to exclude characters that could
        # introduce possible markup malformations to final SVG files.
        until [[ ${VALUE[$COUNT]} =~ ${PATTERN[$COUNT]} ]];do
            cli_printMessage "${PATTERN_MSG[$COUNT]}"
            cli_printMessage "${TITLE[$COUNT]}" 'AsRequestLine'
            read VALUE[$COUNT]
        done

        # Set default value to empty values. 
        if [[ ${VALUE[$COUNT]} == '' ]];then
            VALUE[$COUNT]=${DEFAULT[$COUNT]}
        fi

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    # Create template instance.
    cp $TEMPLATE $INSTANCE

    # Check template instance. We cannot continue if template instance
    # couldn't be created.
    cli_checkFiles $INSTANCE 'f'

    # Reset counter.
    COUNT=0

    while [[ $COUNT -ne ${#TITLE[*]} ]];do

        # Apply translation marker replacement.
        sed -r -i "s!${MARKER[$COUNT]}!${VALUE[$COUNT]}!g" $INSTANCE

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    # Redefine filter flag to specify the extension of shell scripts
    # we want to update copyright information on. Use action value as
    # reference to find out different shell files.
    FLAG_FILTER=".*${FLAG_FILTER}.*\.sh"

    # Define list of shell scripts to be processed.
    cli_getFilesList

    # Print out action preamble. Since the `--filter' option can be
    # supplied, it is useful to know which files we are getting
    # translatable strings from.
    cli_printActionPreamble "${FILES}" "doLocale" 'AsResponseLine'

    # Process list of files.
    for FILE in $FILES;do

        # Output action message.
        cli_printMessage $FILE 'AsUpdatingLine'
 
        # Apply template instance to file.
        sed -r -i -f $INSTANCE $FILE

    done

    # Remove template instance.
    if [[ -f ${INSTANCE} ]];then
        rm ${INSTANCE} 
    fi

}
