#!/bin/bash
#
# render_getIdentityTemplateDir.sh -- This function re-defines absolute
# path to artwork's related design templates directory.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

    # Initialize design models location using action value as
    # reference.
    SVG=$ACTIONVAL

    # Sanitate design models location.  Be sure design models do
    # always point to trunk directory structure. This is useful to let
    # `centos-art.sh' script do rendering under branches directory
    # structure, reusing design models under trunk directory
    # structure.
    SVG=$(echo "$SVG" | sed "s!/branches/!/trunk/!")

    # Sanitate design models location.
    if [[ -d $SVG/Tpl ]];then
        # Using Tpl/ directory is an obsolete practice that should be
        # avoided. The concept of Tpl/ directory per artwork directory
        # has been replaced by a common design model directory
        # structure where we centralize design models for all
        # different artistic motifs.  However, there are some cases
        # that we may need to use Tpl/ directory still, so we verify
        # its existence and use it if present.
        SVG=$SVG/Tpl
    else
        # Redefine design model location based on theme model
        # (THEMEMODEL) variable value. The theme model variable is
        # defined in the associated pre-rendering configuration script
        # and can be used to set which design model to use among a
        # list of different design models that we can choose from.
        SVG=$(echo "$SVG" | sed "s!Motifs/$(cli_getThemeName)!Models/$THEMEMODEL!")
    fi

}
