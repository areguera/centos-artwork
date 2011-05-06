#!/bin/bash
#
# cli.sh -- This function initiates centos-art command-line interface.
# Variables defined in this function are accesible by all other
# functions. The cli function is the first script executed by
# centos-art command-line onces invoked.
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

function cli {

    # Initialize global variables.
    local FUNCNAM=''
    local FUNCDIR=''
    local FUNCDIRNAM=''
    local FUNCSCRIPT=''
    local FUNCCONFIG=''
    local ARGUMENTS=''

    # Initialize default value to filter flag. The filter flag
    # (--filter) is used mainly to reduce the number of files to
    # process. The value of this variable is interpreted as
    # egrep-posix regular expression.  By default, everything matches.
    local FLAG_FILTER='.+'

    # Initialize default value to verbosity flag. The verbosity flag
    # (--quiet) controls whether centos-art.sh script prints messages
    # or not. By default, all messages are printed out.
    local FLAG_QUIET='false'
    
    # Initialize default value to answer flag. The answer flag
    # (--answer-yes) controls whether centos-art.sh script does or
    # does not pass confirmation request points. By default, it
    # doesn't.
    local FLAG_ANSWER='false'

    # Initialize default value to don't commit changes flag. The don't
    # commit changes flag (--dont-commit-changes) controls whether
    # centos-art.sh script syncronizes changes between the central
    # repository and the working copy. By default, it does.
    local FLAG_DONT_COMMIT_CHANGES='false'

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Define function directory (FUNCDIR). The directory path where
    # functionalities are stored inside the repository.
    FUNCDIR=${CLI_BASEDIR}/Functions

    # Check function name. The function name is critical for
    # centos-art.sh script to do something coherent. If it is not
    # provided, execute the help functionality and end script
    # execution.
    if [[ "$1" == '' ]];then
        exec ${CLI_BASEDIR}/centos-art.sh help
        exit
    fi

    # Define function name (FUNCNAM) variable from first command-line
    # argument.  As convenction we use the first argument to determine
    # the exact name of functionality to call.
    FUNCNAM=$(cli_getRepoName "$1" 'f')

    # Define function directory. 
    FUNCDIRNAM=$(cli_getRepoName "$FUNCNAM" 'd')

    # Define function file name.
    FUNCSCRIPT=${FUNCDIR}/${FUNCDIRNAM}/${FUNCNAM}.sh

    # Check function script execution rights.
    cli_checkFiles "${FUNCSCRIPT}" --execution

    # Define function configuration directory. The function
    # configuration directory is used to store functionality's
    # related files.
    FUNCCONFIG=${FUNCDIR}/${FUNCDIRNAM}/Config

    # Remove the first argument passed to centos-art.sh command-line
    # in order to build optional arguments inside functionalities. We
    # start counting from second argument (inclusive) on.
    shift 1

    # Redefine ARGUMENTS using current positional parameters.
    cli_doParseArgumentsReDef "$@"

    # Define default text editors used by centos-art.sh script.
    if [[ ! "$EDITOR" =~ '/usr/bin/(vim|emacs|nano)' ]];then
        EDITOR='/usr/bin/vim'
    fi
    
    # Check text editor execution rights.
    cli_checkFiles $EDITOR --execution

    # Go for function initialization. Keep the cli_getFunctions
    # function calling after all variables and arguments definitions.
    cli_getFunctions "${FUNCDIR}/${FUNCDIRNAM}"

}
