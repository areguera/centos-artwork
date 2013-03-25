#!/bin/bash
#
# vcs.sh -- This function standardizes version control tasks inside
# the repository.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function vcs {

    local ACTIONNAM=''
    local ACTIONNAMS=''
    local ACTIONVAL=''

    # Verify whether version control actions should be performed or
    # not inside the repository directory structure.
    local ENABLED=$(cli_getConfigValue "${CLI_BASEDIR}/${CLI_NAME}.conf" "version_control" "enabled")
    if [[ ! ${ENABLED} =~ '^(yes|ye|y|0)$' ]];then
        return
    fi

    # Initialize version control system to use inside the repository.
    local PACKAGE=$(cli_getConfigValue "${CLI_BASEDIR}/${CLI_NAME}.conf" "version_control" "package")

    # Set possible values to packages used as version control system.
    if [[ ${PACKAGE} =~ '^(git|subversion)$' ]];then

        # Initialize the absolute path to commands we'll use as
        # version control system in the working copy.
        case ${PACKAGE} in

            'git' )
                COMMAND=/usr/bin/git
                ;;

            'subversion' )
                COMMAND=/usr/bin/svn
                ;;
        esac

    else
        cli_printMessage "${PACKAGE} `gettext "isn't supported as version control system."`" --as-error-line
    fi

    # Verify whether the related package is installed or not.
    cli_checkFiles ${PACKAGE} --is-installed
    
    # Interpret arguments and options passed through command-line.
    vcs_getOptions

    # Initialize function specific export id.
    local EXPORTID="${CLI_FUNCDIRNAM}/$(cli_getRepoName ${PACKAGE} -d)/$(cli_getRepoName ${PACKAGE} -f)"

    # Export specific functionalities to the script environment.
    cli_exportFunctions "${EXPORTID}"

    # Execute version control.
    ${PACKAGE}

    # Unset specific functionalities from the script environment.
    cli_unsetFunctions "${EXPORTID}"

}
