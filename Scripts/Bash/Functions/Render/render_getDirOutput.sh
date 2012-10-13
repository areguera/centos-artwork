#!/bin/bash
#
# render_getDirOutput.sh -- This function defines the final
# absolute path the centos-art.sh script uses to store identity
# contents produced at rendition time.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function render_getDirOutput {

    # Define base output directory using design model path as
    # reference.
    OUTPUT=$(dirname $FILE | sed -r \
        -e "s!Identity/Models!Identity/Images!" \
        -e "s!Themes/${FLAG_THEME_MODEL}!Themes/$(cli_getPathComponent $ACTIONVAL --motif)!" \
        -e "s!Documentation/Models!Documentation/Manuals!" \
        -e "s!/Tpl!!")

    # By default rendered identity content is stored immediatly under
    # identity entry structure,  but if `Img/' directory exists use it
    # instead.
    if [[ -d "${OUTPUT}/Img" ]];then
        OUTPUT=${OUTPUT}/Img
    fi

    # Redefine base output directory to introduce specific information
    # like release number and architecture. This information is
    # require by directories (e.g., the `Media' directory inside
    # themes and the `trunk/Documentation/Manuals/Docbook/Distro'
    # directory ) whose need this information to be passed explicitly
    # at the command-line through the `--releasever' and `--basearch'
    # options.  Other directories take such information from the path
    # they are stored in (e.g., the `Distro/5/Anaconda' directory
    # inside themes.). So, we need to differentiate the way
    # information like release numbers and architectures are retrieved
    # in order to build the output path correctly at rendition time.
    if [[ $OUTPUT =~ "^${MOTIF_DIR}/Media$" ]];then
        OUTPUT=${OUTPUT}/${FLAG_RELEASEVER}/${FLAG_BASEARCH}
    elif [[ $OUTPUT =~ 'trunk/Documentation/Manuals/Docbook/Distro$' ]];then
        OUTPUT=${OUTPUT}/${FLAG_RELEASEVER}
    else
        OUTPUT=${OUTPUT}
    fi

    # Define whether to use or not locale-specific directory to store
    # content, using current locale information as reference. As
    # convection, when we produce content, only specific locations
    # use locale-specific directories to organize language-specific
    # content (e.g., Manuals, Anaconda, Installation media, etc.). All
    # other locations do not use locale-specific directories to
    # organize content. This convection is important in order for
    # the `prepare' functionality of centos-art.sh script to produce
    # content in the correct location. Otherwise, we might end up
    # duplicating content (e.g., icons, brands, etc.) which doesn't
    # have any translation, nor any need to be translated.
    if [[ ! ${CLI_LANG_LC} =~ '^en' ]];then
        cli_runFnEnvironment locale --is-localizable ${TEMPLATE}
        if [[ $? -eq 0 ]];then
            OUTPUT=${OUTPUT}/${CLI_LANG_LC}
        fi
    fi

    # Create final output directory, if it doesn't exist yet.
    if [[ ! -d ${OUTPUT} ]];then
        mkdir -p ${OUTPUT}
    fi

}
