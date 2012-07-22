#!/bin/bash
#
# cli_terminateScriptExecution.sh -- This function standardizes the
# actions that must be realized just before leaving the script
# execution (e.g., cleaning temporal files).  This function is the one
# called when interruption signals like EXIT, SIGHUP, SIGINT and
# SIGTERM are detected.
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

function cli_terminateScriptExecution {

    # Remove temporal directory.
    rm -r ${CLI_TEMPDIR}

    # Terminate script correctly.
    exit 0

}
