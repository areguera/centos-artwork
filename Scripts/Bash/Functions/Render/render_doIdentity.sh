#!/bin/bash
#
# render_doIdentity.sh -- This function provides identity
# rendering features for centos-art.sh script.
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
# $Id: render_doIdentity.sh 96 2010-09-19 06:39:32Z al $
# ----------------------------------------------------------------------

function render_doIdentity {

    # Define variables as local to avoid conflicts outside.
    local TRANSLATIONPATH=''
    local SVG=''
    local IMG=''
    local PARENTDIR=''
    local LOCATION=''
    local EXTENSION=''
    local FILTER=''
    local FILES=''

    # Re-define absolute path to artwork's related translation entry.
    render_getIdentityTranslationDir

    # Re-define absolute path to artwork's related design template
    # directory. By default design templates are stored in the Tpl/
    # directory which is stored in the workplace's root. 
    render_getIdentityTemplateDir

    # Re-define absolute path to artwork's related final output
    # directory. 
    render_getIdentityOutputDir

    # Re-define parent directory for current workplace.
    PARENTDIR=$(basename $OPTIONVAL)

    # Re-define directory path used as reference to build the list of
    # files that will be rendered.
    render_getIdentityFileslist

    # Define which type of rendering features does centos-art.sh
    # script is able to performs.
    case ${ACTIONS[0]} in

        'renderText' )
            # Provides text rendering feature.
            render_doIdentityTexts
            ;;

        'renderImage' )
            # Provides image rendering feature.
            render_doIdentityImages
            ;;

    esac

}
