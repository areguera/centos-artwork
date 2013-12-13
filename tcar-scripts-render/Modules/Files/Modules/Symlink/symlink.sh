#!/bin/bash
######################################################################
#
#   symlink.sh -- This function provides an interface for ln command.
#   It mainly exists to creates symbolic links based on information
#   set in configuration files that have symlink as value to
#   render-type option. In these sections, the render-from and
#   link-target options are used to specify the link locations. The
#   link-options option might be used to pass additional options to ln
#   command.
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

function symlink {

    # Define absolute path to command used to create symbolic links.
    local LN=/bin/ln

    # Retrieve command options (values are not required here). Just
    # grant you are always creating symbolic links.
    local LN_OPTIONS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "link-options")
    LN_OPTIONS="-si ${LN_OPTIONS}"

    # Retrieve link source. This is the file you want to link. This
    # file is generally inside the repository.
    local LN_SOURCE=${RENDER_FROM}
    tcar_checkFiles -ef ${LN_SOURCE}

    # Retrieve link target. This is the link you want to create. This
    # link may be inside or outside the repository. The value passed
    # to this value must be a directory because it is concatenated
    # with the section name to build the final path where link will be
    # created.
    local LN_TARGET=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "link-target")
    tcar_checkFiles -ed ${LN_TARGET}
    LN_TARGET=${LN_TARGET}/${SECTION}

    # Print action message.
    tcar_printMessage "${LN_TARGET}" --as-creating-line

    # Create link interactively.
    ${LN} ${LN_OPTIONS} ${LN_SOURCE} ${LN_TARGET}

}
