#!/bin/bash
#
# prepare_updateManuals.sh -- This option initializes documentation files
# inside the working copy. When you provide this option, the
# centos-art.sh script renders all documentation manuals from their
# related source files so you can read them nicely.
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

function prepare_updateManuals {

    local RELEASE=$(cat /etc/redhat-release | gawk '{ print $3 }')

    # Define base directory used by documentation manuals. This is the
    # top level directory where all documentation manuals are stored
    # in the repository.
    local MANUALS=Manuals

    # Define key documentation manuals.
    local MANUALS_NAMES="Tcar-ug Tcar-fs"

    # Verify related design models, images, and common stylesheets
    # used by documentation manuals.
    for DIR in $(echo "Identity/Images/Manuals
                       Identity/Models/Manuals
                       Identity/Webenv/Css
                       Identity/Models/Webenv
                       Identity/Images/Webenv");do
        MANUALS_ABSPATH=$(cli_getRepoTLDir)/${DIR}
        if [[ ! -d $MANUALS_ABSPATH ]];then
            cli_printMessage "`eval_gettext "The directory \\\"\\\$MANUALS_ABSPATH\\\" doesn't exist."`" 
            cli_printMessage "`gettext "Do you want to download a working copy for it now?"`" --as-yesornorequest-line
            mkdir -p $MANUALS_ABSPATH
            svn co $(cli_printUrl --projects-artwork)trunk/${DIR} ${MANUALS_ABSPATH}
        fi
    done

    # Verify directory structure used by documentation manuals.
    for MANUALS_NAME in $MANUALS_NAMES;do
        MANUALS_ABSPATH=$(cli_getRepoTLDir)/${MANUALS}/${MANUALS_NAME}
        if [[ ! -d $MANUALS_ABSPATH ]];then
            cli_printMessage "`eval_gettext "The directory \\\"\\\$MANUALS_ABSPATH\\\" doesn't exist."`" 
            cli_printMessage "`gettext "Do you want to download a working copy for it now?"`" --as-yesornorequest-line
            mkdir -p $MANUALS_ABSPATH
            svn co $(cli_printUrl --projects-artwork)trunk/${MANUALS}/${MANUALS_NAME} ${MANUALS_ABSPATH}
        fi
    done

    # Render dependent files and key documentation manuals.
    ${CLI_BASEDIR}/${CLI_NAME}.sh render trunk/Identity/Images/Manuals --dont-commit-changes
    ${CLI_BASEDIR}/${CLI_NAME}.sh render trunk/Identity/Images/Webenv --dont-commit-changes
    ${CLI_BASEDIR}/${CLI_NAME}.sh render trunk/Manuals/Tcar-ug --filter="tcar-ug" --dont-commit-changes
    ${CLI_BASEDIR}/${CLI_NAME}.sh help   trunk/Manuals/Tcar-fs --update --dont-commit-changes

}
