#!/bin/bash
#
# cli_getRepoParallelDirs.sh -- This function returns the parallel
# directories related to the first positional paramenter passed as
# parent directory. 
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

function cli_getRepoParallelDirs {

    local BOND=''
    local TDIR=''
    local -a PDIRS

    # Define bond string using first positional parameter as
    # reference.
    if [[ "$1" != '' ]];then
        BOND="$1"
    elif [[ "$ACTIONVAL" != '' ]];then
        BOND="$ACTIONVAL"
    else
        cli_printMessage "cli_getRepoParallelDirs: `gettext "The bond string is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Define repository top level directory.
    TDIR=$(cli_getRepoTLDir ${BOND})

    # Define parallel directory base structures.
    PDIRS[0]=Manual/$(cli_getCurrentLocale)/Texinfo/Repository/$(cli_getRepoTLDir "${BOND}" '--relative')
    PDIRS[1]=Scripts/Bash/Functions/Render/Config
    PDIRS[2]=Translations

    # Redefine bond string without its top level directory structure.
    BOND=$(echo $BOND | sed -r "s!^${TDIR}/.+!!")

    # Concatenate repository top level directory, parallel directory
    # base structure, and bond information; in order to produce the
    # final parallel directory path.
    for PDIR in ${PDIRS[*]};do
        echo ${TDIR}/${PDIR}/${BOND}
    done

}
