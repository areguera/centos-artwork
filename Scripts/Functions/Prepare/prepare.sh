#!/bin/bash
#
# prepare.sh -- This function prepares your workstation for using the
# centos-art command-line.
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

function prepare {

    # Define packages flag. The package flag (--packages) controls
    # whether package verification is performed or not. By default no
    # package verification is done.
    local FLAG_PACKAGES='false'

    # Define links flag. The link flag (--links) controls whether
    # links verifications are performed or not. By default no link
    # verification is done.
    local FLAG_LINKS='false'

    # Define environment flag. The environment flag (--environment)
    # controles whether verification of environment variables are
    # performed or not. By default no verification of environment
    # variables is done.
    local FLAG_ENVIRONMENT='false'

    # Interpret arguments and options passed through command-line.
    prepare_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action name. It does matter what option be passed to
    # centos-art, there are many different actions to perform based on
    # the option passed (e.g., `--packages', `--links',
    # `--environment', etc.).  In that sake, we defined action name
    # inside prepare_getOptions, at the moment of interpreting
    # options.

    # Define action value. There is no action value in this function,
    # but action name values only. There is no need for non-option
    # arguments here since we are doing fixed verifications only in
    # predifined paths.

    # Verify flags and execute actions accordingly. Start with
    # packages, links and then environment.
    prepare_doPackages
    prepare_doLinks
    prepare_doEnvironment

}
