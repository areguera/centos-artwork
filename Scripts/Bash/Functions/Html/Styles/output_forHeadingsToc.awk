#!/usr/bin/gawk
#
# output_forHadingsToc.awk -- This file provides the output format
# required by html_updateHeadings.sh function, inside centos-art.sh
# script.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

BEGIN {FS=":"}

{
    if ($1 == 0 && $2 == $3) { 
        opentags  = "<ul><li>"
        closetags = ""
    }

    if ($1 >  0 && $2 >  $3) {
        opentags  = "<ul><li>"
        closetags = ""
    }

    if ($1 >  0 && $2 == $3) { 
        opentags  = "</li><li>"
        closetags = ""
    }

    if ($1 >  0 && $2 <  $3) { 
        opentags = ""
        for (i = 1; i <= ($3 - $2); i++) {
            opentags  = opentags "</li></ul>"
            closetags = ""
        }
        opentags = opentags "</li><li>"
    }

    printf "%s%s%s\n",opentags,$4,closetags

}

END {

    if ($1 > 0 && $2 >= $3 && $3 > 1) {
        for (i = 1; i <= $3; i++) {
            print "</li></ul>"
        }
    }
    
    if ($1 > 0 && $2 >= $3 && $3 == 1) {
        print "</li></ul>"
        print "</li></ul>"
    }

    if ($1 > 0 && $2 < $3) {
        for (i = 1; i <= $2; i++) {
            print "</li></ul>"
        }
    }

    print "</div>"
}
