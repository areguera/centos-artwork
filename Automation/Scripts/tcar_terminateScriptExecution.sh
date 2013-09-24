#!/bin/bash
######################################################################
#
#   tcar_terminateScriptExecution.sh -- This function standardizes the
#   actions that must be realized just before leaving the script
#   execution (e.g., cleaning temporal files).  This function is the
#   one called when interruption signals like EXIT, SIGHUP, SIGINT and
#   SIGTERM are detected.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function tcar_terminateScriptExecution {

    # Remove temporal directory.
    rm -r ${TCAR_SCRIPT_TEMPDIR}

    # NOTE: Don't specify an exit status here. As convenction we do
    # this when error messages are triggerd. See `--as-error-line'
    # option from `tcar_printMessage' functionality.

}
