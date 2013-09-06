#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Svg/Scripts/svg_setBaseRenditionCommand.sh
#   -- This function standardizes the way SVG files are produced
#   inside the centos-art.sh script.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function svg_setBaseRenditionCommand {

    inkscape ${SOURCE_INSTANCES[${COUNTER}]} ${INKSCAPE_OPTIONS[${COUNTER}]} > /dev/null

}
