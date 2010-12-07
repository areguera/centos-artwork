#!/bin/bash
#
# initFunctions.sh -- Initializes environment variables and functions
# used by centos-art.sh scripts.
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

# Initizalize centos-art.sh gettext internazionalization.
. gettext.sh
export TEXTDOMAIN=centos-art.sh
export TEXTDOMAINDIR=/home/centos/artwork/trunk/Scripts/Bash/Locale

# Initialize centos-art.sh personal information.
export CLINAME='centos-art.sh'
export CLIVERSION='Beta'
export CLIDESCRIP="`gettext "Automate frequent tasks inside CentOS Artwork Repository."`"
export CLICOPYRIGHT="Copyright (C) 2009-2010 Alain Reguera Delgado"

# Initialize centos-art.sh function scripts.
FILES=$(ls /home/centos/artwork/trunk/Scripts/Bash/Functions/{cli,cli_*}.sh)
for FILE in $FILES;do
    if [[ -x $FILE ]];then
        . $FILE
        FUNCTION=$(grep '^function ' $FILE | cut -d' ' -f2)
        export -f $FUNCTION
    else
        echo `gettext "The $FILE needs to have execution rights."`
        exit
    fi
done

# Unset all variables not considered global in order to start cli
# execution with a clean environment.
unset FILE
unset FILES
unset FUNCTION
