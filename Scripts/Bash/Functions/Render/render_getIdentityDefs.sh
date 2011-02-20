#!/bin/bash
#
# render_getIdentityDefs.sh -- This function provides shared variables
# re-definitions for all rendition actions inside centos-art.sh
# script.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function render_getIdentityDefs {

    # Define final location of translation file.
    TRANSLATION=$(dirname $FILE \
        | sed -r 's!/trunk/(Identity/)!/trunk/Locales/\1!')/$(cli_getCurrentLocale).po

    # Print final location of translation file.
    if [[ ! -f "$TRANSLATION" ]];then
        cli_printMessage "`gettext "None"`" "AsTranslationLine"
    else
        cli_printMessage "$TRANSLATION" 'AsTranslationLine'
    fi

    # Define final location of template file.
    TEMPLATE=${FILE}

    # Print final location of template file.
    if [[ ! -f "$TEMPLATE" ]];then
        cli_printMessage "`gettext "None"`" "AsDesignLine"
    else
        cli_printMessage "$TEMPLATE" 'AsDesignLine'
    fi
 
    # Define final location of output directory.
    render_getIdentityDirOutput

    # Get relative path to file. The path string (stored in FILE) has
    # two parts: 1. the variable path and 2. the common path.  The
    # variable path is before the common point in the path string. The
    # common path is after the common point in the path string. The
    # common point is the name of the parent directory (stored in
    # PARENTDIR).
    #
    # trunk/Locales/Identity/.../Firstboot/3/splash-small.svg
    # -------------------------^| the     |^------------^
    # variable path             | common  |    common path
    # -------------------------v| point   |    v------------v
    # trunk/Identity/Themes/M.../Firstboot/Img/3/splash-small.png
    #
    # What we do here is remove the varibale path, the common point,
    # and the file extension parts in the string holding the path
    # retrived from design models directory structure. Then we use the
    # common path as relative path to store the the final image file.
    #
    # The file extension is removed from the common path because it is
    # set when we create the final image file. This configuration let
    # us use different extensions for the same file name.
    #
    # When we render using renderImage function, the structure of
    # files under the output directory will be the same used after the
    # common point in the related design model directory structure.
    FILE=$(echo ${FILE} \
        | sed -r "s!.*${PARENTDIR}/!!" \
        | sed -r "s/\.(svgz|svg)$//")

    # Define absolute path to final file (without extension).
    FILE=${OUTPUT}/$(basename "${FILE}")

    # Define instance name from design model.
    INSTANCE=$(cli_getTemporalFile ${TEMPLATE})

    if [[ -f ${TRANSLATION} ]];then
        # Create translated instance from design model.
        /usr/bin/xml2po -p ${TRANSLATION} -o ${INSTANCE} ${TEMPLATE}
    else
        # Create non-translated instance form design model.
        /bin/cat ${TEMPLATE} > ${INSTANCE}    
    fi

    # Apply replacement of translation markers to design model
    # translated instance.
    cli_replaceTMarkers ${INSTANCE}

}
