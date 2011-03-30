#!/bin/bash
#
# path.sh -- This function provides file manipulations to aliviate
# path maintainance inside the repository.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------
    
function path {

    # Define deafult value to target flag. The target flag (--to)
    # controls final destination used by copy related actions.
    local FLAG_TO=''

    # Define default value to syncronization flag. The syncronization
    # flag (--sync) controls whether centos-art.sh script calls itself
    # to create/delete parallel directories at the moment of
    # create/delte action itself.
    local FLAG_SYNC='false'

    # Define command-line interface.
    path_getActions

}
