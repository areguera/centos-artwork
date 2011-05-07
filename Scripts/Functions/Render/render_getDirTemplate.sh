#!/bin/bash
#
# render_getDirTemplate.sh -- This function defines the way renderable
# directories are processed inside the repository.  Inside the
# repository, renderable directories are processed either through
# direct or theme-specific rendition.
#
# Direct rendition takes one XML file from design model
# (`trunk/Identity/Models') directory structure and produces one file
# in `trunk/Identity/Images' directory strucutre. In this
# configuration, the organization used to stored the design model is
# taken as reference to build the path required to store the image
# related to it under `trunk/Identity/Images' directory structure. 
#
# Theme-specific rendition takes one design model from
# `trunk/Identity/Models/Themes' directory structure to produce one or
# more images in `trunk/Identity/Images/Themes/$THEME/$VERSION/$MODEL'
# directory structure. In this configuration we have many different
# artistic motifs that use one unique design model directory structure
# as reference to produce images. 
#
# Since theme design models are unified to be reused by more
# than one artistic motif, it is not possible to render artistic
# motifs in a lineal manner (i.e., as we do with direct rendition)
# because we need to establish the relation between the artistic motif
# renderable directory structure and the design model first and that
# relation happens when renderable directory structures inside
# artistic motifs are processed individually.
#
# In the first rendition category, we use a design model directory
# structure as reference to produce images one by one. In the second
# rendition category, we can't use the same procedure because one
# design model directory structure is used to produce several
# renderable directory structures, not just one.
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

function render_getDirTemplate {

    # Initialize design models location used as reference to process
    # renderable directory structures.
    TEMPLATE=$ACTIONVAL

    # Sanitate design models location.  Be sure design models do
    # always point to trunk directory structure. This is useful to let
    # `centos-art.sh' script do rendition under branches directory
    # structure, reusing design models under trunk directory
    # structure.
    TEMPLATE=$(echo "$TEMPLATE" | sed "s!/branches/!/trunk/!")

    # Define absolute path to input files using absolute path from
    # output files.
    if [[ -d ${TEMPLATE}/Tpl ]];then
        TEMPLATE=${TEMPLATE}/Tpl
    else
        TEMPLATE=$(echo "$TEMPLATE" | sed -r \
            -e "s!/Themes/$(cli_getPathComponent $ACTIONVAL --theme)!/Themes/${FLAG_THEME_MODEL}!" \
            -e "s!/Images!/Models!")
    fi

}
