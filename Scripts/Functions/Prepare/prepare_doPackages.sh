#!/bin/bash
#
# prepare_doPackages.sh -- This function verifies the required
# packages your workstation needs to have installed in order for
# centos-art command to run correctly. If there is one or more missing
# packages, the `centos-art.sh' script asks you to confirm their
# installation through yum.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function prepare_doPackages {

    # Verify `--packages' option.
    if [[ $FLAG_PACKAGES == 'false' ]];then
        return
    fi

    # Print line separator.
    cli_printMessage '-' 'AsSeparatorLine'

    # Print action message.
    cli_printMessage "`gettext "Checking required packages"`" 'AsResponseLine'

    # Print line separator.
    cli_printMessage '-' 'AsSeparatorLine'

    local PACKAGE=''
    local WARNING=''
    local PACKAGES=''
    local PACKAGES_THIRDS=''
    local -a PACKAGES_MISSING
    local RPM='/bin/rpm'
    local YUM='/usr/bin/yum'

    # Check execution rights of package managers.
    cli_checkFiles $RPM 'x'
    cli_checkFiles $YUM 'x'

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

    # Build list of missing packages.
    for PACKAGE in $PACKAGES;do
        $RPM -q --queryformat "%{NAME}\n" $PACKAGE --quiet
        if [[ $? -ne 0 ]];then
            PACKAGES_MISSING[((++${#PACKAGES_MISSING[*]}))]=$PACKAGE
        fi
    done

    # Is there any package missing?
    if [[ ${#PACKAGES_MISSING[*]} -eq 0 ]];then
        cli_printMessage "`gettext "The required packages has been already installed."`"
        return
    fi

    # At this point there is one or more missing packages that need to
    # be installed in the workstation. Report this issue and specify
    # which these packages are.
    cli_printMessage "`ngettext "The following package needs to be installed" \
        "The following packages need to be installed" \
        "${#PACKAGES_MISSING[*]}"`:"

    # Build report of missing packages and remark those comming from
    # third party repository.
    for PACKAGE in ${PACKAGES_MISSING[@]};do
        if [[ $PACKAGE =~ $PACKAGES_THIRDS ]];then
            WARNING=" (`gettext "requires third party repository!"`)"
        fi
        cli_printMessage "${PACKAGE}${WARNING}" 'AsResponseLine'
    done

    # Print confirmation request.
    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

    # Use sudo to install the missing packages in your system through
    # yum.
    sudo ${YUM} install ${PACKAGES_MISSING[*]}

}
