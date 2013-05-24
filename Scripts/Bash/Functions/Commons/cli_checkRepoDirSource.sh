#!/bin/bash
#
# cli_checkRepoDirSource.sh -- This function standardizes the path
# construction to directories inside the working copy, using absolute
# paths. This function transforms relative paths passed as non-option
# arguments to centos-art.sh script command-line into absolute paths
# inside the working copy based on whether you are using Subversion or
# Git as version control system. Further verifications, (e.g., whether
# they really exist as directories inside the working copy or not)
# should be realized outside this function.
#
# NOTE: Transforming relative paths into absolute paths before
# processing them is very useful when you need to execute the
# centos-art.sh script as command (e.g., `centos-art') anywhere
# inside the workstation.
#
# Use this function whenever you need to be sure that non-option
# arguments passed to centos-art.sh script command-line will always
# point to directories inside the working copy.
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

function cli_checkRepoDirSource {

    local LOCATION=${1}

    # Remove any dot from arguments passed to centos-art.sh script.
    # This way it is possible to use a single dot to reflect the
    # current location from which centos-art.sh was executed. Notice
    # that using a dot as argument is optional (e.g.: when you pass no
    # argument to centos-art command-line, the current location is
    # used as default location). However, it might be useful to use a
    # dot as argument when you want to include the current location in
    # a list of arguments to process.
    LOCATION=$(echo "$LOCATION" | sed -r "s,^\.$,$(pwd),g")

    # Remove the working directory absolute path from location to
    # avoid path duplications here.
    LOCATION=$(echo "$LOCATION" | sed "s,${TCAR_WORKDIR}/,,g")

    # When we use Subversion as version control system, we follow the
    # `trunk', `branches', `tags' convention to organize files inside
    # the repository and need to redefine the source path in order to
    # build repository absolute path from repository's top level on.
    #
    # As we are removing the absolute path prefix (e.g.,
    # `/home/centos/artwork/') from all centos-art.sh output (in order
    # to save horizontal output space), we need to be sure that all
    # strings beginning with `trunk/...', `branches/...', and
    # `tags/...' use the correct absolute path. That is, you can refer
    # trunk's entries using both `/home/centos/artwork/trunk/...' or
    # just `trunk/...', the `/home/centos/artwork/' part is
    # automatically added here.
    #
    # When we use Git as version control system, there isn't a need of
    # using the `trunk', `branches', `tags' convention we were using
    # for Subversion.  Instead, we use a Git remote branch named
    # `develop' to do most of the work. Then, when we have something
    # functional in `develop' branch, we merge `develop' branch into
    # the `master' branch (probably doing a rebase on master branch).
    #
    # There isn't a need of verifying the paths built here.  This is
    # something we do later, using the cli_checkFiles function. We
    # don't do the file verification here to avoid malformed error
    # messages when we reassign variable values using this function as
    # reference (e.g., in order to prevent error messages to be also
    # stored inside variables.).
    LOCATION=${TCAR_WORKDIR}/${LOCATION}

    # Output the absolute path to location.
    echo "${LOCATION}"

}
