#!/bin/bash
#
# tuneup_doSvgMetadata.sh -- This function updates metadata values
# inside scalable vector graphic (SVG) files using The CentOS Project
# default values.
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

function tuneup_doSvgMetadata {

    local NAM=''
    local URL=''
    local KEYS=''
    local INSTANCE=''
    local TEMPLATES=''

    # Define template file name.
    TEMPLATE="${FUNCCONFIG}/svg_metadata.sed"

    # Check template file existence.
    cli_checkFiles $TEMPLATE

    # Build title from file path.
    NAM=$(basename "$FILE")

    # Build url from file path.
    URL=$(echo $FILE | sed 's!/home/centos!https://projects.centos.org/svn!')

    # Build keywords from file path. Do not include filename, it is
    # already on title.
    KEYS=$(dirname "$FILE" | cut -d/ -f6- | tr '/' '\n')

    # Build keywords using SVG standard format. Note that this
    # information is inserted inside template file. The template file
    # is a replacement set of sed commands so we need to escape the
    # new line of each line using one backslash (\). As we are doing
    # this inside bash, it is required to escape the backslash with
    # another backslash so one of them passes literally to template
    # file.
    KEYS=$(\
        for KEY in $KEYS;do
            echo "            <rdf:li>$KEY</rdf:li>\\"
        done)

    # Redefine template instance file name.
    INSTANCE=$(cli_getTemporalFile $TEMPLATE)

    # Create template instance.
    cp $TEMPLATE $INSTANCE

    # Check template instance. We cannot continue if the template
    # instance couldn't be created.
    cli_checkFiles $INSTANCE

    # Expand translation markers inside template instance.
    sed -r -i \
        -e "s!=TITLE=!$NAM!" \
        -e "s!=URL=!$URL!" \
        -e "s!=DATE=!$(date "+%Y-%m-%d")!" $INSTANCE
    sed -i -r "/=KEYWORDS=/c\\${KEYS}" $INSTANCE
    sed -i -r 's/>$/>\\/g' $INSTANCE
    cli_replaceTMarkers $INSTANCE

    # Update scalable vector graphic using template instance.
    sed -i -f $INSTANCE $FILE

    # Remove template instance.
    if [[ -f $INSTANCE ]];then
        rm $INSTANCE
    fi

    # Sanitate scalable vector graphic.
    sed -i -r '/^[[:space:]]*$/d' $FILE

}
