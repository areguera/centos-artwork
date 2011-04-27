#!/bin/bash
#
# cli_getCopyrightInfo.sh -- This function outputs the copyright
# information of content produced by the centos-art command-line
# interface.
#
# As I understand, the copyright exists to make people create more.
# The copyright gives creators the legal power over their creations
# and so the freedom to distribute them under the ethical terms the
# creator considers better. 
#
# At this moment I don't feel very sure about this legal affairs, but
# need to decide what copyright information the centos-art will
# output. So, I'm taking the wiki (wiki.centos.org) copyright
# information as reference.
#
# Copyright (C) 2009-2011 The CentOS Project
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

function cli_getCopyrightInfo {

    case "$1" in

        '--license' )

            # Output default license name used by all image-based
            # creations inside CentOS Artwork Repository.
            echo "Creative Common Attribution-ShareAlike 3.0"
            ;;

        '--license-url' )

            # Ouput default license url used by all image-based
            # creations inside CentOS Artwork Repository.
            echo "http://creativecommons.org/licenses/by-sa/3.0/"
            ;;

        '--copyright-year' )

            # Output default copyright year.
            date +%Y
            ;;
    
        '--copyright-holder' )
            
            # Output default copyright holder.
            echo "The CentOS Project"
            ;;

        '--copyright' | * )
            local YEAR=$(cli_getCopyrightInfo '--copyright-year')
            local HOLDER=$(cli_getCopyrightInfo '--copyright-holder')
            echo "Copyright © $YEAR $HOLDER"
            ;;

    esac

}
