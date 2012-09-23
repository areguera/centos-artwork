#!/bin/bash
#
# prepare_updateEnvironment.sh -- This function updates the
# ~/.bash_profile file to provide default configuration values to
# centos-art.sh script.
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

    local BASH_PROFILE=bash_profile
    local SOURCE=${PREPARE_CONFIG_DIR}/${BASH_PROFILE}.conf
    local TARGET=${HOME}/.${BASH_PROFILE}

    # Print action message.
    cli_printMessage "`gettext "${HOME}/.${BASH_PROFILE}"`" --as-updating-line

    # Copy default configuration file to its final destination. Note
    # that we are not making a link here in order for different users
    # to be able of using different values in their own environments.
    cp -f $SOURCE $TARGET

    # Determine which is the absolute path the script has been
    # executed from. This information will be used to construct the
    # working copy absolute path and will easy the procedure to follow
    # when a new absolute path should be defined for the working copy.
    if [[ $0 =~ "${CLI_NAME}.sh$" ]];then
        local TCAR_WORKDIR=$(echo "$0" | sed -r 's!^(.+)/trunk.*!\1!')
        sed -i -r "s!^(TCAR_WORKDIR=).*!\1${TCAR_WORKDIR}!" ${TARGET}
    fi

}
