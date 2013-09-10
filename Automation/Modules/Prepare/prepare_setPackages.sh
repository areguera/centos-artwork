#!/bin/bash
######################################################################
#
#   prepare_setPackages.sh -- This function verifies packages
#   required by centos-art.sh script and prints a list of installed
#   and missing packages based on it.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
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

function prepare_setPackages {

    local PACKAGES_REQUIRED="inkscape ImageMagick netpbm
    netpbm-progs syslinux gimp coreutils texinfo texinfo-tex info
    tetex-latex tetex-fonts tetex-xdvi tetex-dvips gettext texi2html
    gnome-doc-utils elinks docbook-style-xsl docbook-utils
    docbook-dtds docbook-style-dsssl docbook-simple docbook-utils-pdf
    docbook-slides firefox sudo yum rpm ctags vim-enhanced asciidoc
    dblatex"

    local -x  PACKAGES_THIRDPARTY='(inkscape|asciidoc|dblatex)'

    for PACKAGE in ${PACKAGES_REQUIRED};do
        rpm -q ${PACKAGE} --quiet
        if [[ $? -ne 0 ]];then
            PACKAGES_UNINSTALLED="${PACKAGES_UNINSTALLED} ${PACKAGE}"
        fi
    done

    local YUM_OPTIONS=''
    if [[ ${TCAR_FLAG_YES} == 'true' ]];then
        YUM_OPTIONS='-y'
    fi
    if [[ ${TCAR_FLAG_QUIET} == 'true' ]];then
        YUM_OPTIONS="${YUM_OPTIONS} --quiet"
    fi

    if [[ ! -z ${PACKAGES_UNINSTALLED} ]];then
        tcar_printMessage "`gettext "The following packages need to be installed:"`" --as-banner-line
        for PACKAGE in ${PACKAGES_UNINSTALLED};do
            if [[ ${PACKAGE} =~ ${PACKAGES_THIRDPARTY} ]];then
                tcar_printMessage "${PACKAGE} (`gettext "from third party repository"`)" --as-response-line
            else
                tcar_printMessage "${PACKAGE}" --as-response-line
            fi
        done
        tcar_printMessage '-' --as-separator-line
        tcar_printMessage "`gettext "Do you want to continue"`" --as-yesornorequest-line
        sudo yum install ${YUM_OPTIONS} ${PACKAGES_UNINSTALLED}
    else
        tcar_printMessage "`gettext "All required packages are already installed."`" --as-banner-line
    fi

}
