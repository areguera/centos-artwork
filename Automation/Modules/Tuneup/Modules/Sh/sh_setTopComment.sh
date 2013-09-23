#!/bin/bash
######################################################################
#
#   sh_setTopComment.sh -- This function standardizes presentation for
#   top comment section of shell scripts (*.sh) using a predefined
#   template.
#
# Copyright (C) 2009-2013 The CentOS Project
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
######################################################################

function sh_setTopComment {

    local COMMENT_TEMPLATE="${SUBMODULE_DIR_CONFIGS}/topcomment.sed"

    tcar_checkFiles -ef ${COMMENT_TEMPLATE}

    local COMMENT_INSTANCE=$(tcar_getTemporalFile ${COMMENT_TEMPLATE})

    cp ${COMMENT_TEMPLATE} ${COMMENT_INSTANCE}

    tcar_setTranslationMarkers ${COMMENT_INSTANCE}

    sed -r -i -f ${COMMENT_INSTANCE} ${FILE}

    if [[ -f ${COMMENT_INSTANCE} ]];then
        rm ${COMMENT_INSTANCE} 
    fi

}
