#!/bin/bash
########################################################################
#
#   centos-art.sh -- The CentOS Artwork Repository automation tool.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
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
########################################################################

# Initialize default configuration values.
. $(dirname ${0})/centos-art.conf

# Initialize user-specific configuration values.
if [[ -f ${TCAR_USER_CONFIG} ]];then
    . ${TCAR_USER_CONFIG}
fi

# Initialize internationalization through GNU gettext.
. gettext.sh
declare -xr TEXTDOMAIN=${TCAR_CLI_NAME}
declare -xr TEXTDOMAINDIR=${TCAR_CLI_L10NDIR}

# Initialize the centos-art.sh script command-line interface.
if [[ -x ${TCAR_CLI_INIT_FILE} ]];then
    . ${TCAR_CLI_INIT_FILE}; export -f ${TCAR_CLI_INIT_FUNCTION}
    ${TCAR_CLI_INIT_FUNCTION} "$@"
else
    echo "${TCAR_CLI_INIT_FILE} `gettext "has not execution rights."`"
fi
