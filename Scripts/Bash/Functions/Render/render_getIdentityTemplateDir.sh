#!/bin/bash
#
# render_getIdentityTemplateDir.sh -- This function re-defines absolute
# path to artwork's related design templates directory. 
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
# $Id: render_getIdentityTemplateDir.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function render_getIdentityTemplateDir {

    # By default design templates are stored in the artworks identity
    # entry, under Tpl/ directory.
    SVG=$OPTIONVAL/Tpl

    # If you are rendering theme motifs, design templates are not
    # stored inside Tpl directory. Instead, we use one common theme
    # model structure for all artistic motifs. Theme models are
    # organized by name, so we need to ask the user which theme model
    # to use before rendering artistic motifs.
    if [[ ! -d $SVG ]] \
        && [[ $SVG =~ "trunk/Identity/Themes/Motifs/$(cli_getThemeName)/" ]]; then 
        SVG=$(echo "$OPTIONVAL" | sed "s!Motifs/$(cli_getThemeName)!Models/$THEMEMODEL!")
    fi

}
