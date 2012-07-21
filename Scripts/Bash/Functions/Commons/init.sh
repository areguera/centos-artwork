#!/bin/bash
#
# init.sh -- This function initiates the application's command-line
# interface.  Variables defined in this function are accesible by all
# other functions. The cli function is the first script executed by
# the application command-line onces invoked.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function init {

    # Initialize global variables.
    local CLI_FUNCNAME=''
    local CLI_FUNCDIRNAM=''
    local CLI_FUNCSCRIPT=''
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

    # Initialize list of common functionalities to load.
    local FILES=$(ls ${CLI_FUNCDIR}/Commons/*.sh)

    # Initialize common functionalities.
    for FILE in ${FILES};do
        if [[ -x ${FILE} ]];then
            . ${FILE}
            export -f $(grep '^function ' ${FILE} | cut -d' ' -f2)
        else
            echo "`eval_gettext "The \\\$FILE needs to have execution rights."`"
            exit
        fi
    done

    # Trap signals in order to terminate the script execution
    # correctly (e.g., removing all temporal files before leaving).
    # Trapping the exit signal seems to be enough by now, since it is
    # always present as part of the script execution flow. Each time
    # the centos-art.sh script is executed it will inevitably end with
    # an EXIT signal at some point of its execution, even if it is
    # interrupted in the middle of its execution (e.g., through
    # `Ctrl+C').
    trap cli_terminateScriptExecution 0

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

    # Check function name. The function name is critical for
    # centos-art.sh script to do something coherent. If it is not
    # provided, execute the help functionality and end script
    # execution.
    if [[ ! "$1" ]] || [[ ! "$1" =~ '^[[:alpha:]]' ]];then
        exec ${CLI_BASEDIR}/${CLI_NAME}.sh help
        exit
    fi

    # Define function name (CLI_FUNCNAME) using the first argument in
    # the command-line.
    CLI_FUNCNAME=$(cli_getRepoName $1 -f | cut -d '-' -f 1)

    # Define function directory. 
    CLI_FUNCDIRNAM=$(cli_getRepoName $CLI_FUNCNAME -d)

    # Define function file name.
    CLI_FUNCSCRIPT=${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}/${CLI_FUNCNAME}.sh

    # Check function script execution rights.
    cli_checkFiles "${CLI_FUNCSCRIPT}" --execution

    # Remove the first argument passed to centos-art.sh command-line
    # in order to build optional arguments inside functionalities. We
    # start counting from second argument (inclusive) on.
    shift 1

    # Redefine ARGUMENTS using current positional parameters.
    cli_parseArgumentsReDef "$@"

    # Define default text editors used by centos-art.sh script.
    if [[ ! "$EDITOR" =~ '/usr/bin/(vim|emacs|nano)' ]];then
        EDITOR='/usr/bin/vim'
    fi
    
    # Check text editor execution rights.
    cli_checkFiles $EDITOR --execution

    # Go for function initialization. Keep the cli_exportFunctions
    # function calling after all variables and arguments definitions.
    cli_exportFunctions "${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}"

    # Execute function.
    eval $CLI_FUNCNAME

}
