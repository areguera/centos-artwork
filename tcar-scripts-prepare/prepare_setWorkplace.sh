#!/bin/bash
######################################################################
#
#   prepare_setWorkplace.sh -- This function rebuilds the workplace
#   directory structure based on The CentOS Artwork Repository
#   directory structure. This is required because The CentOS Artwork
#   Repository directory structure might change from one release to
#   another.
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

function prepare_setWorkplace {

    local CONF=''

    if [[ -d ${TCAR_WORKDIR} ]];then
        tcar_printMessage "`gettext "The workplace you provided already exist and will be removed."`" --as-stdout-line
        tcar_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line
        tcar_printMessage "${TCAR_WORKDIR}" --as-removing-line
        rm -r ${TCAR_WORKDIR}
    fi

    tcar_printMessage "${TCAR_WORKDIR}" --as-creating-line

    for CONF in $(prepare_getWorkplaceConf);do
        local TCAR_WORKDIR_DIR=$(prepare_getWorkplaceDir ${CONF})
        local TCAR_WORKDIR_LNK=${TCAR_WORKDIR_DIR}/render.conf
        mkdir -p ${TCAR_WORKDIR_DIR} && ln -s ${CONF} ${TCAR_WORKDIR_LNK}
        tcar_checkFiles -s ${TCAR_WORKDIR_LNK}
    done

    if [[ -d ${TCAR_WORKDIR}/Brands ]];then
        tcar_printMessage "`gettext "The workplace doesn't include images for branding other images."`"
        tcar_printMessage "`gettext "Do you want to render them now?"`" --as-yesornorequest-line
        prepare_setRenderEnvironment -o "render-type" -v "svg" ${TCAR_WORKDIR}/Brands
    fi

}
