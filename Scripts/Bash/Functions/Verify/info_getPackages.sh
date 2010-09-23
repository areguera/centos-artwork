#!/bin/bash
#
# info_getPackages.sh -- This function queries your system's
# rpm database to verify centos-art.sh required packages existence.
# If there is any missing package, leave a message and quit script
# execution.
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

function info_getPackages {

    # Define variables as local to avoid conflicts outside.
    local PACKAGE=''
    local PACKAGES=''
    local PACKAGE_INFO=''

    # Define required packages needed by centos-art.sh script.
    PACKAGES="bash inkscape ImageMagick netpbm netpbm-progs
        syslinux gimp coreutils texinfo info tetex-latex tetex-fonts
        tetex-doc tetex-xdvi tetex-dvips gettext texi2html"

    # Define, from required packages, packages being from third
    # parties (i.e., packages not included in rhel, nor centos [base]
    # repository.).
    PACKAGES_FROM_THIRDS="(inkscape|blender)"

    # Output table of packages needed by centos-art.sh script.
    for PACKAGE in $PACKAGES;do
        PACKAGE_INFO=$(rpm -q --queryformat "%{SUMMARY}" $PACKAGE \
            | tr "\n" ' ' | sed -r 's!^([[:alpha:]])!\u\1!' )
        cli_printMessage "$PACKAGE | $PACKAGE_INFO"
    done \
        | egrep -i $REGEX \
        | awk 'BEGIN {FS="|"; format ="%15s|%s\n"
                      printf "--------------------------------------------------------------------------------\n"
                      printf format, "'`gettext "Package"`' ", " '`gettext "Description"`'"
                      printf "--------------------------------------------------------------------------------\n"}
                     {printf format, substr($1,0,15), $2}
                 END {printf "--------------------------------------------------------------------------------\n"}'

    cli_printMessage "$(caller)" "AsToKnowMoreLine"
}
