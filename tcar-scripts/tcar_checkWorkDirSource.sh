#!/bin/bash
######################################################################
#
#   tcar_checkWorkDirSource.sh -- This function standardizes the path
#   construction of directories inside the workplace, using absolute
#   paths. This function transforms relative paths passed as
#   non-option arguments to tcar.sh script command-line into absolute
#   paths inside the workplace. Further verifications, (e.g., whether
#   they really exist as directories inside the working copy or not)
#   should be realized outside this function.
#
#   Use this function whenever you want to be sure non-option
#   arguments passed to tcar.sh script command-line do always point to
#   directories inside the workplace.  Transforming relative paths
#   into absolute paths, before processing them, is very useful when
#   you need to execute the tcar.sh script as command (e.g., `tcar')
#   anywhere on your workstation.
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

function tcar_checkWorkDirSource {

    local LOCATION=${1}

    # Remove any dot from arguments passed to tcar.sh script.  This
    # way it is possible to use a single dot to reflect the current
    # location from which tcar.sh was executed. Notice that using a
    # dot as argument is optional (e.g., when you pass no argument to
    # tcar command-line, the current location is used as default
    # location). However, it might be useful to use a dot as argument
    # when you want to include the current location in a list of
    # arguments to process. Remember that dot slash can be used to
    # refer locations relatively.
    LOCATION=$(echo "${LOCATION}" | sed -r "s,^\.(/([[:alnum:]_/.-]+)?)?$,$(pwd)\1,g")

    # Remove the workplace absolute path from location in order to
    # avoid path duplications here.
    LOCATION=$(echo "${LOCATION}" | sed "s,${TCAR_WORKDIR}/,,g")

    # Rebuild location using the workplace absolute path. 
    LOCATION=${TCAR_WORKDIR}/${LOCATION}

    # Remove trailing slashes passed as argument. The single slash
    # form is used to refer the repository's root directory. The
    # single slash form passed as argument of tcar.sh script is
    # useful to execute commands over the
    # entire repository tree.
    echo "${LOCATION}" | sed -r -e 's,/+,/,g' -e 's,/+$,,g'

    # There isn't a need of verifying the paths built here.  This is
    # something we do later, using the tcar_checkFiles function. We
    # don't do the file verification here to avoid malformed error
    # messages when we reassign variable values using this function as
    # reference (e.g., in order to prevent error messages from being
    # stored inside variables.).

}
