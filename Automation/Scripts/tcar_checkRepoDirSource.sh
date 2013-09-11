#!/bin/bash
######################################################################
#
#   tcar_checkRepoDirSource.sh -- This function standardizes the path
#   construction of directories inside the working copy, using
#   absolute paths. This function transforms relative paths passed as
#   non-option arguments to centos-art.sh script command-line into
#   absolute paths inside the working copy based on whether you are
#   using Subversion or Git as version control system. Further
#   verifications, (e.g., whether they really exist as directories
#   inside the working copy or not) should be realized outside this
#   function.
#
#   Use this function whenever you want to be sure non-option
#   arguments passed to centos-art.sh script command-line do always
#   point to directories inside the working copy.  Transforming
#   relative paths into absolute paths, before processing them, is
#   very useful when you need to execute the centos-art.sh script as
#   command (e.g., `centos-art') anywhere on your workstation.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
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

function tcar_checkRepoDirSource {

    local LOCATION=${1}

    # Remove any dot from arguments passed to centos-art.sh script.
    # This way it is possible to use a single dot to reflect the
    # current location from which centos-art.sh was executed. Notice
    # that using a dot as argument is optional (e.g.: when you pass no
    # argument to centos-art command-line, the current location is
    # used as default location). However, it might be useful to use a
    # dot as argument when you want to include the current location in
    # a list of arguments to process. Don't forget that dot slash can
    # be used to refere locations relatively.
    LOCATION=$(echo "${LOCATION}" | sed -r "s,^\.(/[[:alnum:]_/-.]+)?$,$(pwd)\1,g")

    # Remove the working directory absolute path from location to
    # avoid path duplications here.
    LOCATION=$(echo "${LOCATION}" | sed "s,${TCAR_BASEDIR}/,,g")

    # When we use Git as version control system, there isn't a need of
    # using the `trunk', `branches', `tags' convention we were using
    # for Subversion.  The working copy begins directly with the
    # content of our repository (e.g., Documentation, Scripts,
    # Identity and Locales).
    #
    # When we use Subversion as version control system, we follow the
    # `trunk', `branches', `tags' convention to organize files inside
    # the repository and need to redefine the source path in order to
    # build the repository absolute path from the repository top level
    # on.  As convention, when you prepare your working copy through
    # centos-art.sh script, the absolute path to the `trunk/'
    # directory is used as working copy. This is, path arguments
    # provided to centos-art.sh script will be interpreted from trunk/
    # directory level on. For example, the following command should
    # work correctly in both Subversion and Git repositories:
    #
    #   centos-art render Documentation/Manuals/Docbook/Tcar-ug
    #
    # There isn't a need of verifying the paths built here.  This is
    # something we do later, using the tcar_checkFiles function. We
    # don't do the file verification here to avoid malformed error
    # messages when we reassign variable values using this function as
    # reference (e.g., in order to prevent error messages from being
    # stored inside variables.).
    LOCATION=${TCAR_BASEDIR}/${LOCATION}

    # Output the absolute path to location.
    echo "${LOCATION}"

}
