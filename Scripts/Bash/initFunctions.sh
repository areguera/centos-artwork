#!/bin/bash
#
# initFunctions.sh -- Initializes functions and sets environment
# variables used by centos-art.sh scripts.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
# $Id: initFunctions.sh 80 2010-09-18 06:57:26Z al $
# ----------------------------------------------------------------------

# Initizalize gettext internazionalization.
. gettext.sh
export TEXTDOMAIN=centos-art.sh
export TEXTDOMAINDIR=/home/centos/artwork/trunk/Scripts/Bash/Locale

# Initialize centos-art.sh script functions.
FILES=$(ls /home/centos/artwork/trunk/Scripts/Bash/Functions/{cli,cli_*}.sh)
MISSINGFILES=''
for FILE in $FILES;do
    if [[ -x $FILE ]];then
        . $FILE
        FUNCTION=$(grep '^function ' $FILE | cut -d' ' -f2)
        export -f $FUNCTION
    else
        MISSINGFILES="$FILE $MISSINGFILES"
    fi
done

if [[ $MISSINGFILES != '' ]];then
    for FILE in $MISSINGFILES;do
        echo `gettext "The $FILE needs to have execution rights."`
    done
    exit
fi

# Unset all except gettext's initialization variables in order to
# start cli execution with a clean environment. Only gettext's
# initialization variables are required to pass.
unset FILE
unset FILES
unset MISSINGFILES
unset FUNCTION
