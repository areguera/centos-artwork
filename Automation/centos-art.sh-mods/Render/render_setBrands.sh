#!/bin/bash
#
# render_setBrands.sh -- This function performs brand-specific
# rendition.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render_setBrands {

    local BRANDS_MODELS_DIR=${TCAR_WORKDIR}/Identity/Models/Brands
    local BRANDS_IMAGES_DIR=${TCAR_WORKDIR}/Identity/Images/Brands

    render_setBrandsDirValidates ${BRANDS_IMAGES_DIR} ${ACTIONVAL}
    render_setBrandsDirStructure ${BRANDS_MODELS_DIR} ${BRANDS_IMAGES_DIR}

    render_setBaseRendition

}
