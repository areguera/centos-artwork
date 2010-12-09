#!/bin/bash
#
# render_getIdentityTemplateDir.sh -- This function re-defines absolute
# path to artwork's related design templates directory. 
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function render_getIdentityTemplateDir {

    SVG=$ACTIONVAL

    # Be sure design models are always pointing to trunk. This is
    # useful to let centos-art.sh script do render under branches
    # directory structure.
    SVG=$(echo "$SVG" | sed "s!/branches/!/trunk/!")

    # By default design templates are stored directly under theme
    # model directory structure. The Tpl/ directory is no longer used,
    # except some specific cases that, for organization sake, it is
    # convenient to use them.
    if [[ -d $SVG/Tpl ]];then
        SVG=$SVG/Tpl
    fi

    # If you are rendering theme motifs, design templates are not
    # stored inside Tpl directory. Instead, we use one common theme
    # model structure for all artistic motifs. Inside the common theme
    # model structure, there are several design models that user can
    # alternate among, using the THEMEMODEL variable available on
    # pre-rendering configuration scripts.
    SVG=$(echo "$SVG" | sed "s!Motifs/$(cli_getThemeName)!Models/$THEMEMODEL!")

}
