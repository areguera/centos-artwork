#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Print tcar version and license information.
function tcar_printVersion {

    # Reset text domain locally, in order to prevent this function
    # from using the last text domain definition. By default all
    # common functions do use the same MO file.
    local TEXTDOMAIN="${TCAR_SCRIPT_NAME}"

    tcar_printMessage "`eval_gettext "\\\$TCAR_SCRIPT_NAME version \\\$TCAR_SCRIPT_VERSION"`" --as-stdout-line
    tcar_printCopyrightInfo
    tcar_printMessage "`eval_gettext "\\\$TCAR_SCRIPT_NAME comes with NO WARRANTY, to the extent permitted by law. You may redistribute copies of \\\$TCAR_SCRIPT_NAME under the terms of the GNU General Public License. For more information about these matters, see the file named COPYING."`" --as-stdout-line | fold --width=66 --spaces

    exit 0

}
