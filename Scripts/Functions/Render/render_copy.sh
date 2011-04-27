#!/bin/bash
#
# render_copy.sh -- This function duplicates rendition stuff.
# Rendition stuff is formed by design models, design images and
# pre-rendition configuration scripts (which includes translations
# files). This way, when we say to duplicate rendition stuff we are
# saying to duplicate these four directory structures (i.e., design
# models, design images, pre-rendition configuration scripts, and
# related translations files).
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

function render_copy {

    # Verify target directory.
    cli_checkRepoDirTarget

    # Determine what directory structure we are duplicating.

}
