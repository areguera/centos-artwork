#!/bin/bash
#
# render_doIdentityImageDm.sh -- This function standardize the way of
# retrive action values from pre-rendering configuration files. Use
# this function whenever you need to retrive action values from
# pre-rendering configuration script.
#
# Usage:
#
# VAR=$(render_getConfOption "ACTION" "FIELD")
#
# Where:
#
# VAR is the name of the variable you want to store the option
# value retrived from your specification, using
# render_getConfOption's ACTION and FIELD arguments. If there is
# no variable assignment, the function outputs the action value
# to standard output without trailing newline.
#
# ACTION is the string definition set in the pre-rendering
# configuration script holding the action name and its options
# fields.
#
# FIELD  is field number in the action string you want to
# retrive option from. By default options start from third field
# on. The first field is reserved for the action type (i.e.,
# BASE, POST, LAST), and the second field is reserved for the
# action itself (e.g., renderImage, renderFormats, etc.). Note
# that this convenction can be altered if the action string has
# been modified (e.g., you stript the BASE field from action
# string) and passed the modified action string to another
# function for processing.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

function render_getConfOption {

    local ACTION="$1"
    local FIELD="$2"
    local VALUE=''

    # Check action value. The action's value must be present in order
    # for this function to work. It provides the string needed to
    # retrive options from.
    if [[ "$ACTION" == '' ]];then
        cli_printMessage "`gettext "There is no action to work with."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Check field value. The field's value must match the cut's
    # command specification of its -f option.
    if [[ ! "$FIELD" =~ '^([0-9]+|[0-9]+-|-[0-9]+|[0-9]+-[0-9]+)$' ]];then
        cli_printMessage "`gettext "The field specified is not valid."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Get option from pre-rendering configuration action definition.
    VALUE=$(echo -n "$ACTION" | cut -d: -f${FIELD})

    # Sanitate action value passed from pre-rendering configuration
    # action definition.
    VALUE=$(echo -n "${VALUE}" \
        | sed -r 's!^ *!!g' \
        | sed -r 's!( |,|;) *! !g' \
        | sed -r 's! *$!!g')

    # Output action value without trailing newline.
    echo -n "$VALUE"

}
