#!/bin/bash
#
# help_updateNodes.sh -- This function updates chapter's nodes
# definition using the chapter's menu as reference.
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
# $Id: help_updateNodes.sh 44 2010-09-17 05:58:18Z al $
# ----------------------------------------------------------------------

function help_updateNodes {

    # Retrive nodes' entries from chapter-menu.texi file.
    local NODES=$(cat $ENTRYCHAPTER/${MANUALS_FILE[8]} \
        | sed -r 's!^\* !!' | sed -r 's!:{1,2}.*$!!g' \
        | egrep -v '^@(end )?menu$' | sed -r 's! !:!g' | sort | uniq)

    # Re-build node structure based on menu information.
    for NODE in $NODES;do

        NODE=$(echo $NODE | sed -r 's!:! !g')
        SECT=$(echo $NODE | sed -r 's! !/!g')
        INCL=$(echo $NODE | sed -r 's! !/!g').texi
        CIND=$(echo $NODE)

        # Create an emtpy directory to store texinfo files.
        if [[ ! -d ${MANUALS_DIR[2]}/$(dirname $INCL) ]];then
             mkdir -p ${MANUALS_DIR[2]}/$(dirname $INCL)
        fi

        # Create texinfo section file using its template.
        if [[ ! -f ${MANUALS_DIR[2]}/$INCL ]];then

            cp ${MANUALS_FILE[10]} ${MANUALS_DIR[2]}/$INCL

            # Translate template instance.
            sed -r -i \
                -e "s!=GOALS=!`gettext "Goals"`!g" \
                -e "s!=USAGE=!`gettext "Usage"`!g" \
                -e "s!=DESCRIPTION=!`gettext "Description"`!g" \
                -e "s!=SEEALSO=!`gettext "See also"`!g" \
                ${MANUALS_DIR[2]}/$INCL

        fi

        # Output node information based on texinfo menu.
        echo "@node $NODE"
        echo "@section $SECT"
        echo "@cindex $CIND"
        echo "@include $INCL"
        echo ""

    # Dump node information into chapter node file.
    done > $ENTRYCHAPTER/${MANUALS_FILE[9]}

}

