#!/bin/bash
#
# render_doIdentityBase.sh -- This function initiates rendition features
# taking BASEACTIONS as reference.
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

function render_doIdentityBase {

    # Define variables as local to avoid conflicts outside.
    local TRANSLATIONPATH=''
    local SVG=''
    local IMG=''
    local PARENTDIR=''
    local LOCATION=''
    local EXTENSION=''
    local FILTER=''
    local FILES=''

    # Redefine absolute path to artwork's related translation entry.
    render_getIdentityTranslationDir

    # Redefine absolute path to artwork's related design template
    # directory. By default design templates are stored in the Tpl/
    # directory which is stored in the workplace's root. 
    render_getIdentityTemplateDir

    # Redefine absolute path to artwork's related final output
    # directory. 
    render_getIdentityOutputDir

    # Redefine parent directory for current workplace.
    PARENTDIR=$(basename $ACTIONVAL)

    # Redefine directory path used as reference to build the list of
    # files that will be rendered.
    render_getFilesList

    # Define which type of features does centos-art.sh script is able
    # to perform.
    for ACTION in "${BASEACTIONS[@]}"; do

        case $ACTION in

            renderText )
                # Provides text rendition feature.
                render_doIdentityTexts
                ;;

            renderImage )
                # Provides image rendition feature.
                render_doIdentityImages
                ;;

        esac

    done

}
