#!/bin/bash
#
# subversion_mkRepoDirectory.sh -- This function standardizes the way
# centos-art.sh script creates directories inside the working copy.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function subversion_mkRepoDirectory {

    local TARGET=$(cli_checkRepoDirSource ${1})

    # Print action reference.
    cli_printMessage "${TARGET}" --as-creating-line

    # Copy source location to its target using version control.
    ${COMMAND} mkdir ${TARGET} --quiet

}
