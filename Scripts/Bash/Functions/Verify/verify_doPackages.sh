#!/bin/bash
#
# verify_doPackages.sh -- This function verifies required packages
# your workstation needs in order to run the centos-art command
# correctly. If there are missing packages, the `centos-art.sh' script
# asks you to confirm their installation. When installing packages,
# the `centos-art.sh' script uses the yum application in order to
# achieve the task.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
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

function verify_doPackages {

    local PACKAGES=''
    local PACKAGES_THIRD_REGEX=''
    local -a PACKAGES_MISSING
    local PACKAGES_COUNT=0

    # Define required packages needed by centos-art.sh script.
    PACKAGES="bash inkscape ImageMagick netpbm netpbm-progs
        syslinux gimp coreutils texinfo info tetex-latex tetex-fonts
        tetex-doc tetex-xdvi tetex-dvips gettext texi2html"

    # Define, from required packages, packages being from third
    # parties (i.e., packages not included in CentOS [base]
    # repository.).
    PACKAGES_THIRD_REGEX="(inkscape|blender)"

    verify_doPackageCheck
    verify_doPackageReport
    verify_doPackageInstall

    # At this point we need to recheck installed packages in order to
    # be sure the user decided not to continue when there are still
    # missing packages to be install.  For example this may happen
    # when we try to install third party packages and there is no
    # third party repository availabe to get those packages from.
    verify_doPackages

}
