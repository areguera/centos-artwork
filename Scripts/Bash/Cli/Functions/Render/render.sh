#!/bin/bash
#
# render.sh -- This function initializes rendition variables and
# actions to centos-art.sh script.
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

function render {

    # Define default value to target flag. The target flag (--to)
    # controls final destination used by copy related actions.
    local FLAG_TO=''

    # Define release number flag. The relesase number flag (--release)
    # specifies the release number identity images are rendered for.
    # By default no release number is used.
    local FLAG_RELEASE=''

    # Define architecture flag. The architecture flag (--architecture)
    # specifies the architecture type identity images are rendered
    # for.  By default no architecture type is used.
    local FLAG_ARCHITECTURE=''

    # Define theme model flag. The theme model flag (--theme-model)
    # specifies the theme model used when no one is specified.
    local FLAG_THEME_MODEL='Default'

    # Define convert-to flag. The convert-to flag (--convert-to)
    # specifies the post-rendition image convertion action to perform
    # upon PNG images.  By default there is no image convertion.
    local FLAG_CONVERT_TO=''

    # Define grouped-by flag. The grouped-by flag (--grouped-by)
    # specifies the post-rendition image grouping action to perform
    # upon images produced. By default there is no grouping action.
    local FLAG_GROUPED_BY=''

    # Define rendition actions.
    render_getArguments

}
