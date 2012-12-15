#!/bin/bash
#
# prepare_updateEnvironment.sh -- This function updates the
# `~/.bash_profile' file to provide default configuration values to
# centos-art.sh script. Those values which aren't set by this function
# are already set in the `bash_profile.conf' template file we use as
# reference to create the `~/.bash_profile' file.
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

function prepare_updateEnvironment {

    # Verify that centos-art.sh script is run using an absolute path.
    # We use this information to determine the exact working copy
    # location to use, later when `bash_profile' file is created.
    if [[ ! $0 =~ "^/[[:alnum:]/_-]+${CLI_NAME}.sh$" ]];then
        cli_printMessage "`gettext "To set environment variables you should run centos-art.sh using its abosolute path."`" --as-error-line
    fi

    local PROFILE=bash_profile
    local SOURCE=${PREPARE_CONFIG_DIR}/${PROFILE}.conf
    local TARGET=${HOME}/.${PROFILE}

    # Determine which is the absolute path the script has been
    # executed from. This information will be used to construct the
    # working copy absolute path and will easy the procedure to follow
    # when a new absolute path should be defined for the working copy.
    local TCAR_WORKDIR=$(dirname "$0")

    # Determine which is the brand information that will be used as
    # repository brand information. By default we are using `centos'
    # and shouldn't be change to anything else, at least if you
    # pretend to produce content for The CentOS Project.
    local TCAR_BRAND='centos'

    # Print action message.
    cli_printMessage "${TARGET}" --as-updating-line

    # Copy default configuration file to its final destination. Note
    # that we are not making a link here in order for different users
    # to be able of using different values in their own environments.
    cp -f $SOURCE $TARGET

    # Update bash_profile file with default values.
    sed -i -r \
        -e "s,^(TCAR_WORKDIR=).*,\1${TCAR_WORKDIR}," \
        -e "s,^(TCAR_BRAND=).*,\1${TCAR_BRAND}," \
        ${TARGET}

}
