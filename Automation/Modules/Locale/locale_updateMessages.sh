#!/bin/bash
#
#   locale_updateMessages.sh -- This function extracts translatable
#   strings from both XML-based files (using xml2po) and shell scripts
#   (using xgettext). Translatable strings are initially stored in
#   portable objects templates (.pot) which are later merged into
#   portable objects (.po) in order to be optionally converted as
#   machine objects (.mo).
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>
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

function locale_updateMessages {

    case ${RENDER_TYPE} in

        'svg' )
            locale_convertSvgToPo
            ;;

        'asciidoc' )
            locale_convertAsciidocToPo
            ;;

        'sh' )
            locale_convertShellToPo
            ;;

        * )
            cli_printMessage "`gettext "Couldn't find a valid render-type."`" --as-error-line
            ;;

    esac

}
