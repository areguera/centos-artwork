#!/bin/bash
######################################################################
#
#   packages.sh -- This function defines and verifies packages
#   required by centos-art.sh script.
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

function packages {

    # Define required packages used by centos-art.sh script inside
    # CentOS base repository.
    local BASE_PACKAGES="ImageMagick netpbm netpbm-progs syslinux gimp
        coreutils texinfo texinfo-tex info tetex-latex tetex-fonts
        tetex-xdvi tetex-dvips gettext texi2html libxml2
        gnome-doc-utils elinks docbook-style-xsl docbook-utils
        docbook-dtds docbook-style-dsssl docbook-simple
        docbook-utils-pdf docbook-slides firefox sudo yum rpm ctags
        vim-enhanced"

    # Define required packages used by centos-art.sh script inside
    # EPEL repository. Start verifying the package that contains
    # repository configuration, then everything else.
    local EPEL_PACKAGES="epel-release inkscape asciidoc"

    # Verify required packages. The order in which packages are
    # verified my help to reduce some loops (e.g., verify packages
    # containing the repository's configuration files first and
    # packages from that repository later. It is rather possible that
    # you won't be able to install any package from a repository you
    # don't have configuration files for, in first place).
    tcar_checkFiles -n ${BASE_PACKAGES} ${EPEL_PACKAGES}

    # Print a confirmation message here.
    tcar_printMessage "`gettext "All required packages are installed already."`" --as-stdout-line

}
