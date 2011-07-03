#!/bin/bash
#
# prepare_doManuals.sh -- This option initializes documentation files
# inside the working copy. When you provide this option, the
# centos-art.sh script renders all documentation manuals from their
# related source files so you can read them nicely.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function prepare_doManuals {

    # The CentOS Artwork Repository User's Guide in docbook format.
    ${CLI_BASEDIR}/${CLI_PROGRAM}.sh render \
        trunk/Manuals/TCAR-UG/Docbook/ --filter="tcar-ug" \
        --dont-commit-changes

    # The CentOS Artwork Repository User's Guide in texinfo format.
    ${CLI_BASEDIR}/${CLI_PROGRAM}.sh help --update \
        trunk/Manuals/TCAR-UG/Texinfo/ \
        --dont-commit-changes

}
