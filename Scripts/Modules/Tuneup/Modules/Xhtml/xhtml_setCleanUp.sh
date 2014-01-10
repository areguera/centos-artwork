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

# Create valid XHTML files from (probably malformed) HTML files.
function xhtml_setCleanUp {

    grep '<?xml' ${FILE} > /dev/null \
        || egrep '\-//W3C//DTD XHTML 1.0 (Strict|Transitional)//EN' ${FILE} > /dev/null
    if [[ $? -eq 0 ]];then
        /usr/bin/xmllint --xmlout --format --noblanks \
            --nonet --nowarning \
            --output ${FILE} ${FILE} 2&> /dev/null
    else
        /usr/bin/xmllint --html --xmlout --format --noblanks \
            --nonet --nowarning \
            --output ${FILE} ${FILE} 2&> /dev/null
    fi

}
