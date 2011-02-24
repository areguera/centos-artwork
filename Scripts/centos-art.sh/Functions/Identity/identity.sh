#!/bin/bash
#
# render.sh -- This function provides rendition features to
# centos-art.sh script. Here we initialize rendition variables and
# call identity_getActions functions.
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

function identity {

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

    # Define rendition actions.
    identity_getActions

}
