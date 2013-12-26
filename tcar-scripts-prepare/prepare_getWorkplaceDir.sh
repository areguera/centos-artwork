#!/bin/bash
######################################################################
#
#   prepare_getWorkplaceDir.sh -- This function transform absolute
#   paths to configuration files inside The CentOS Artwork Repository
#   to directory absolute paths inside the workplace.
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

function prepare_getWorkplaceDir {

    local DIRECTORY=$1 

    echo ${DIRECTORY} \
        | sed -r -e "s!${TCAR_BASEDIR}/Models/!${TCAR_WORKDIR}/!" \
                 -e 's!/[a-z]+\.conf(\.tpl)?$!!'

}
