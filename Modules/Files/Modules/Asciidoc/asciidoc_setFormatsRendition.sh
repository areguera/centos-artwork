#!/bin/bash
######################################################################
#
#   asciidoc_setFormatsRendition.sh -- This function standardizes the
#   rendition formats supported by asciidoc module.
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

function asciidoc_setFormatsRendition {

    for FORMAT in ${FORMATS};do

        case ${FORMAT} in 

            'xhtml' )
                asciidoc_setXhtmlRendition "${RENDER_TARGET}"
                ;;

            * )
                tcar_printMessage "`gettext "The format you specified isn't supported, yet."`" --as-error-line
                ;;
        esac

    done

}
