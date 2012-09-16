#!/bin/bash
#
# prepare_updateLocales.sh -- This function creates/updates the
# machine object (.mo) file gettext uses to output translated messages
# when centos-art.sh script is running. Certainly, what this function
# really does is a call to the locale functionality of centos-art.sh
# script to realize and update action against itself.
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
# $Id: prepare_updateLocales.sh 963 2012-09-05 02:51:50Z al $
# ----------------------------------------------------------------------

function prepare_updateLocales {

    ${CLI_BASEDIR}/${CLI_NAME}.sh locale trunk/Scripts/Bash --update --dont-commit-changes

}
