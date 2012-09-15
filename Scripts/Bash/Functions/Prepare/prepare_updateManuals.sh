#!/bin/bash
#
# prepare_updateManuals.sh -- This option initializes documentation files
# inside the working copy. When you provide this option, the
# centos-art.sh script renders all documentation manuals from their
# related source files so you can read them nicely.
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

function prepare_updateManuals {

    # Render key documentation manuals.
    ${CLI_BASEDIR}/${TCAR_CLI_NAME}.sh render trunk/Documentation/Manuals/Docbook/Tcar-ug --dont-commit-changes
    ${CLI_BASEDIR}/${TCAR_CLI_NAME}.sh help   trunk/Documentation/Manuals/Texinfo/Tcar-fs --update --dont-commit-changes

}
