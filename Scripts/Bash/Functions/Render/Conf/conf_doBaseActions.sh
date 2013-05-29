#!/bin/bash
#
# conf_doBaseActions.sh -- This function standardizes base actions
# related to image production through configuration files.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function conf_doBaseActions {

    local COUNTER=0
    local EXPORTID="CENTOSARTWORK"
    local -a MODEL_INSTANCES
    local -a IMAGE_COMMANDS

    # Define absolute path to output location. This is the location
    # inside the working copy all images will be stored in.
    local OUTPUT=${OUTPUT}/${FGCOLOR}/${BGCOLOR}/${HEIGHT}/${FILENAME}

    # Define which command will be used to output the template
    # content. This is required because template files might be found
    # as compressed files inside the repository.
    local VIEWER="/bin/cat"

    while [[ $COUNTER -lt ${#MODELS[*]} ]];do

        # Verify existence and extension of design models.
        cli_checkFiles ${MODELS[$COUNTER]} -f --match='\.(svgz|svg)$'

        # Define file name for design model instances.
        MODEL_INSTANCES[$COUNTER]=${TMPDIR}/$(basename ${MODELS[$COUNTER]})

        # Define file name for image instances.
        IMAGE_INSTANCES[$COUNTER]=${TMPDIR}/$(basename ${MODELS[$COUNTER]} \
            | sed -r 's/\.(svgz|svg)$/.png/')

        # Redefine command used to read design models.
        if [[ $(file -b -i ${MODELS[$COUNTER]}) =~ '^application/x-gzip$' ]];then
            VIEWER="/bin/zcat"
        fi

        # Create uncompressed design model instances in order to make
        # color replacements without affecting original design models. 
        $VIEWER ${MODELS[$COUNTER]} > ${MODEL_INSTANCES[$COUNTER]}

        # Make your best to be sure the design model instance you are
        # processing is a valid scalable vector graphic.
        cli_checkFiles ${MODEL_INSTANCES[$COUNTER]} --mime="text/xml"

        # Make color replacements to each design model instance before
        # render them using Inkscape.
        if [[ ${FGCOLOR} != '000000' ]];then
            sed -i -r "s/((fill|stroke):#)000000/\1${FGCOLOR}/g" ${MODEL_INSTANCES[$COUNTER]}
        fi

        # Create list of Inkscape commands based for each design model
        # set in the configuration file.
        IMAGE_COMMANDS[${COUNTER}]="${MODEL_INSTANCES[$COUNTER]} \
            --export-id=${EXPORTID} \
            --export-png=${IMAGE_INSTANCES[$COUNTER]}  \
            --export-background=$(echo ${BGCOLOR} | cut -d'-' -f1) \
            --export-background-opacity=$(echo ${BGCOLOR} | cut -d'-' -f2) \
            --export-height=${HEIGHT}"

        # Create PNG image based on design models.
        inkscape ${IMAGE_COMMANDS[$COUNTER]} > /dev/null

        COUNTER=$(( $COUNTER + 1 ))

    done

    # Verify existence of output directory.
    if [[ ! -d $(dirname ${OUTPUT}) ]];then
        mkdir -p $(dirname ${OUTPUT})
    fi

    # Apply command to PNG images produced from design models to
    # construct the final PNG image.
    cli_printMessage "${OUTPUT}" --as-creating-line
    ${COMMAND} ${IMAGE_INSTANCES[*]} ${OUTPUT}

    # Create path for different image formats creation using PNG image
    # extension as reference.
    TARGET=$(echo ${OUTPUT} | sed -r "s/\.png$//")

    # Convert images from PNG to those formats specified in the
    # configuration file.
    for FORMAT in ${FORMATS};do
        cli_printMessage "${TARGET}.${FORMAT}" --as-creating-line
        convert ${OUTPUT} ${TARGET}.${FORMAT}
    done

}
