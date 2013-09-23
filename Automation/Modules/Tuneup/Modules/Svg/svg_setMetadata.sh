#!/bin/bash
######################################################################
#
#   svg_setMetadata.sh -- This function updates metadata values inside
#   scalable vector graphic (SVG) files using default values from The
#   CentOS Project.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
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

function svg_setMetadata {

    # Define template file name.
    local TEMPLATE="${SUBMODULE_DIR_CONFIGS}/metadata.sed"

    # Check template file existence.
    tcar_checkFiles -ef ${TEMPLATE}

    # Build title from file path.
    local TITLE=$(basename "${FILE}")

    # Build url from file path.
    local URL=$(echo ${FILE} \
        | sed 's!/home/centos!https://projects.centos.org/svn!')

    # Build keywords from file path. Do not include filename, it is
    # already on title.
    local KEY=''
    local KEYS=$(dirname "${FILE}" | cut -d/ -f6- | tr '/' '\n')

    # Build keywords using SVG standard format. Note that this
    # information is inserted inside template file. The template file
    # is a replacement set of sed commands so we need to escape the
    # new line of each line using one backslash (\). As we are doing
    # this inside bash, it is required to escape the backslash with
    # another backslash so one of them passes literally to template
    # file.
    KEYS=$(\
        for KEY in ${KEYS};do
            echo "            <rdf:li>${KEY}</rdf:li>\\"
        done)

    # Redefine template instance file name.
    local INSTANCE=$(tcar_getTemporalFile ${TEMPLATE})

    # Create instance.
    cp ${TEMPLATE} ${INSTANCE}

    # Check template instance. We cannot continue if the template
    # instance couldn't be created.
    tcar_checkFiles -e ${INSTANCE}

    # Expand translation markers inside template instance.
    sed -r -i \
        -e "s!=TITLE=!${TITLE}!" \
        -e "s!=URL=!${URL}!" \
        -e "s!=DATE=!$(date "+%Y-%m-%d")!" ${INSTANCE}
    sed -i -r "/=KEYWORDS=/c\\${KEYS}" ${INSTANCE}
    sed -i -r 's/>$/>\\/g' ${INSTANCE}

    tcar_setTranslationMarkers ${INSTANCE}

    # Update scalable vector graphic using template instance.
    sed -i -f ${INSTANCE} ${FILE}

    # Remove template instance.
    if [[ -f ${INSTANCE} ]];then
        rm ${INSTANCE}
    fi

    # Sanitate scalable vector graphic.
    sed -i -r '/^[[:space:]]*$/d' ${FILE}

}
