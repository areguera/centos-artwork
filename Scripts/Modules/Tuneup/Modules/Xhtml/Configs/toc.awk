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

# This file provides the output format required by `xhtml_setToc'
# function, inside centos-art.sh script, to produce the table of
# contents correctly.
BEGIN {FS=":"}

{
    if ($1 == 0 && $2 == $3) { 
        opentags  = "<dl><dt>"
        closetags = ""
    }

    if ($1 >  0 && $2 >  $3) {
        opentags  = "<dl><dt>"
        closetags = ""
    }

    if ($1 >  0 && $2 == $3) { 
        opentags  = "</dt><dt>"
        closetags = ""
    }

    if ($1 >  0 && $2 <  $3) { 
        opentags = ""
        for (i = 1; i <= ($3 - $2); i++) {
            opentags  = opentags "</dt></dl>"
            closetags = ""
        }
        opentags = opentags "</dt><dt>"
    }

    printf "%s%s%s\n",opentags,$4,closetags

}

END {

    if ($1 > 0 && $2 >= $3 && $3 > 1) {
        for (i = 1; i <= $3; i++) {
            print "</dt></dl>"
        }
    }
    
    if ($1 > 0 && $2 >= $3 && $3 == 1) {
        print "</dt></dl>"
        print "</dt></dl>"
    }

    if ($1 > 0 && $2 < $3) {
        for (i = 1; i <= $2; i++) {
            print "</dt></dl>"
        }
    }

    print "</div>"
}
