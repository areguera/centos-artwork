#!/bin/bash
#
# centos-art.sh -- This file is the initialization script, the first
# script the centos-art command executes.
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

# Most paths are built from HOME variable on, so we need to make our
# best to make it contain a valid value before any path be built from
# it. Using HOME variable gives us some flexibility to store the
# repository filesystem in a location different from `/home/centos',
# the default home directory centos-art assumes if HOME variable is
# empty or malformed.
[[ ! $HOME =~ '^/home/[[:alnum:]]+' ]] && HOME='/home/centos'

# Initialize personal information.
export CLI_PROGRAM='centos-art'
export CLI_VERSION='1.0 (beta)'
export CLI_BASEDIR="${HOME}/artwork/trunk"

# Initizalize internazionalization through gettext.
. gettext.sh
export TEXTDOMAIN=${CLI_PROGRAM}.sh
export TEXTDOMAINDIR=${HOME}/artwork/trunk/Locales

# Initialize common function scripts.
FILES=$(ls ${CLI_BASEDIR}/Functions/{cli,cli_*}.sh)
for FILE in ${FILES};do
    if [[ -x ${FILE} ]];then
        . ${FILE}
        FUNCTION=$(grep '^function ' ${FILE} | cut -d' ' -f2)
        export -f ${FUNCTION}
    else
        echo `gettext "The ${FILE} needs to have execution rights."` > /dev/stderr
        exit
    fi
done

# Unset all variables not considered global in order to start cli
# execution with a clean environment.
unset FILE
unset FILES
unset FUNCTION

# Initialize command-line interface.
cli "$@"
