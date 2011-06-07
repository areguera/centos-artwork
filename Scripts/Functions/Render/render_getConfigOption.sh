#!/bin/bash
#
# render_getConfigOption.sh -- This function standardizes the
# configuration fields are retrived from some action-specific
# definitions.
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

function render_getConfigOption {

    # Initialize action string.
    local ACTION="$1"

    # Initialize field definition.
    local FIELD="$2"

    # Initialize configuration options.
    local OPTION=''

    # Check action string. The action string must be present in order
    # for this function to work. It provides the information needed to
    # retrive configurantion options from.
    if [[ "$ACTION" == '' ]];then
        cli_printMessage "`gettext "There is no action string to work with."`" --as-error-line
    fi

    # Check field definition. The field definition must match any of
    # the formats specified by the `-f' option of `cut' command.
    if [[ ! "$FIELD" =~ '^([0-9]+|[0-9]+-|-[0-9]+|[0-9]+-[0-9]+)$' ]];then
        cli_printMessage "`gettext "The field definition is not valid."`" --as-error-line
    fi

    # Get configuration option from action string.
    OPTION=$(echo -n "$ACTION" | cut -d: -f${FIELD})

    # Sanitate configuration option retrived from action string.
    OPTION=$(echo -n "${OPTION}" \
        | sed -r 's!^ *!!g' \
        | sed -r 's!( |,|;) *! !g' \
        | sed -r 's! *$!!g')

    # Print out the configuration option retrived from action string,
    # only if it is not an empty value. Do not use `echo' or `printf'
    # built-in commands here. Use the `cli_printMessage' functionality
    # instead.  This is required in order to reverse the apostrophe
    # codification accomplished when options were retrived from
    # command-line (cli_parseArgumentsReDef) in the argument of
    # options like `--post-rendition' and `--last-rendition'.
    if [[ $OPTION != '' ]];then
        cli_printMessage "$OPTION" --as-stdout-line
    fi

}
