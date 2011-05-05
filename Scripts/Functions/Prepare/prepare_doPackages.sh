#!/bin/bash
#
# prepare_doPackages.sh -- This function verifies the required
# packages your workstation needs to have installed in order for
# centos-art command to run correctly. If there is one or more missing
# packages, the `centos-art.sh' script asks you to confirm their
# installation through yum.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

function prepare_doPackages {

    # Verify `--packages' option.
    if [[ $FLAG_PACKAGES == 'false' ]];then
        return
    fi

    local PACKAGE=''
    local PACKAGES=''
    local PACKAGES_THIRDS=''
    local -a PACKAGES_MISSING
    local -a PACKAGES_INSTALL
    local RPM='/bin/rpm'
    local YUM='/usr/bin/yum'
    local YUM_OPTIONS=''

    # Check execution rights of package managers.
    cli_checkFiles $RPM --execution
    cli_checkFiles $YUM --execution

    # Define required packages needed by centos-art.sh script.
    PACKAGES="inkscape ImageMagick netpbm netpbm-progs syslinux gimp
        coreutils texinfo info tetex-latex tetex-fonts tetex-xdvi
        tetex-dvips gettext texi2html gnome-doc-utils elinks
        docbook-style-xsl docbook-utils docbook-dtds
        docbook-style-dsssl docbook-simple docbook-utils-pdf
        docbook-slides firefox sudo yum rpm"

    # Define packages from third party repositories (i.e., packages
    # not included in CentOS [base] repository.) required by
    # centos-art to work as expected.
    PACKAGES_THIRDS="(inkscape|blender)"

    # Build list of installed and missing packages.
    for PACKAGE in $PACKAGES;do
        $RPM -q --queryformat "%{NAME}\n" $PACKAGE --quiet
        if [[ $? -ne 0 ]];then
            PACKAGES_MISSING[((++${#PACKAGES_MISSING[*]}))]=$PACKAGE
        else
            PACKAGES_INSTALL[((++${#PACKAGES_INSTALL[*]}))]=$PACKAGE
        fi
    done

    # Define relation between centos-art.sh options and yum options.
    [[ $FLAG_ANSWER == 'true' ]] && YUM_OPTIONS="${YUM_OPTIONS} -y"
    [[ $FLAG_QUIET  == 'true' ]] && YUM_OPTIONS="${YUM_OPTIONS} -q"

    # Use `sudo yum' to install missing packages in your workstation.
    if [[ ${#PACKAGES_MISSING[*]} -gt 0 ]];then
        sudo ${YUM} ${YUM_OPTIONS} install ${PACKAGES_MISSING[*]}
    fi
        
    # Use `sudo yum' to update installed packages in your workstation.
    if [[ ${#PACKAGES_INSTALL[*]} -gt 0 ]];then
        sudo ${YUM} ${YUM_OPTIONS} update ${PACKAGES_INSTALL[*]}
    fi
    
}
