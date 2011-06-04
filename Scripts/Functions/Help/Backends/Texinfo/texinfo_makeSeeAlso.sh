#!/bin/bash
#
# texinfo_makeSeeAlso.sh -- This function creates an itemized list
# of links to refer parent documentation entries. This list of links
# is expanded wherever the =TEXINFO_SEEALSO= translation marker be
# placed in the documentation entry.
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

function texinfo_makeSeeAlso {

    local FILE="$1"
    local NODE="$2"
    local NODECOMP=''
    local NODECOMPS_TOTAL=''
    local -a NODECOMPS
    local SEEALSO_LIST=''

    # Stript out the node information in order to retrive its
    # components individually.
    for NODECOMP in $(echo $NODE);do
        NODECOMPS[((++${#NODECOMPS[*]}))]=$NODECOMP
    done

    # Define how many components does the node have.
    local NODECOMPS_TOTAL=$((${#NODECOMPS[*]}))

    # Define the list content. This list should contain all the parent
    # documentation entries under the same chapter, using the current
    # documentation entry as reference. Assuming no parent directory
    # exist for the current documentation entry, print just one item
    # with three dots as content so as to let the user deside what the
    # most appropriate content for this section would be.
    if [[ $NODECOMPS_TOTAL -gt 2 ]];then
        SEEALSO_LIST=$(\
            until [[ ${NODECOMPS_TOTAL} -eq 2 ]];do
                echo "@item @ref{$NODE" \
                    | cut -d ' ' -f-"$NODECOMPS_TOTAL" \
                    | sed -r -e 's!^[:space:]*!\\n!' -e 's!$!}!';
                NODECOMPS_TOTAL=$(($NODECOMPS_TOTAL - 1))
            done)
    else
        SEEALSO_LIST=$(echo '\\n@item @dots{}')
    fi

    # Define the list type and merge its content.
    SEEALSO_LIST="$(echo '@itemize'$SEEALSO_LIST'\n@end itemize')"

    # Expand translation marker in the documentation entry.
    sed -i -e "/=TEXINFO_SEEALSO=/c\\$SEEALSO_LIST" $FILE

}
