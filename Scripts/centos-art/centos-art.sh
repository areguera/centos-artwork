#!/bin/bash
#
# centos-art.sh -- The CentOS Artwork Repository automation tool.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

# Initialize personal data.
declare -xr CLI_PROGRAM='centos-art'
declare -xr CLI_PROGRAM_ID=$$
declare -xr CLI_VERSION='1.0 (beta)'

# Initialize paths.
declare -xr CLI_WRKCOPY="${HOME}/artwork"
declare -xr CLI_BASEDIR="${CLI_WRKCOPY}/trunk/Scripts"
declare -xr CLI_TEMPDIR='/tmp'

# Initialize internazionalization through GNU gettext.
. gettext.sh
declare -xr TEXTDOMAIN=${CLI_PROGRAM}.sh
declare -xr TEXTDOMAINDIR=${CLI_WRKCOPY}/trunk/L10n/Scripts

# Verify the working copy directory. Be sure it is
# `/home/centos/artwork'.  Otherwise, end the script execution.  We
# cannot continue if the working copy is stored in a place other than
# `/home/centos/artwork'. This restriction is what let us to reuse
# contents using absolute paths inside a distributed environment like
# that one provided by The CentOS Artwork Repository.
if [[ ! -d ${CLI_WRKCOPY} ]];then
    echo "`eval_gettext "The working copy must be under \\\"\\\$CLI_WRKCOPY\\\"."`" > /dev/stderr
    exit
fi

# Initialize common functions.
FILES=$(ls ${CLI_BASEDIR}/Functions/{cli,cli_*}.sh)
for FILE in ${FILES};do
    if [[ -x ${FILE} ]];then
        . ${FILE}
        FUNCTION=$(grep '^function ' ${FILE} | cut -d' ' -f2)
        export -f ${FUNCTION}
    else
        echo `eval_gettext "The \\\"\\\$FILE\\\" needs to have execution rights."` > /dev/stderr
        exit
    fi
done

# Unset all variables not considered global in order to start common
# functions with a clean environment.
unset FILE
unset FILES
unset FUNCTION

# Trap signals in order to terminate the script execution correctly
# (e.g., removing all temporal files before leaving).  Trapping the
# exit signal seems to be enough by now, since it is always present as
# part of the script execution flow. Each time the centos-art.sh
# script is executed it will inevitably end with an EXIT signal at
# some point of its execution, even if it is interrupted in the middle
# of its execution (e.g., through `Ctrl+C').
trap cli_terminateScriptExecution 0

# Initialize command-line interface.
cli "$@"
