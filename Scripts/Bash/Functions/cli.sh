#!/bin/bash
#
# cli.sh -- This function initiates centos-art command-line interface.
# Variables defined in this function are accesible by all other
# functions. The cli function is the first script executed by
# centos-art command-line onces invoked.
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

function cli {

    # Initialize global variables.
    local FUNCNAM=''
    local FUNCDIR=''
    local FUNCDIRNAM=''
    local FUNCSCRIPT=''
    local FUNCCONFIG=''
    local ACTIONNAM=''
    local ACTIONVAL=''
    local REGEX=''
    local ARGUMENTS=''

    # Redefine positional parameters stored inside ARGUMENTS variable.
    cli_doParseArgumentsReDef "$@"

    # Define function directory (FUNCDIR). The directory path where
    # functionalities are stored inside the repository.
    FUNCDIR=/home/centos/artwork/trunk/Scripts/Bash/Functions

    # Define function name (FUNCNAM) variable from first command-line
    # argument.  As convenction we use the first argument to determine
    # the exact name of functionality to call.
    FUNCNAM=$(cli_getRepoName "$1" 'f')
    if [[ "$FUNCNAM" =~ '^[a-z]+$' ]];then

        # Define function directory. 
        FUNCDIRNAM=$(cli_getRepoName $FUNCNAM 'd')

        # Define function file name.
        FUNCSCRIPT=${FUNCDIR}/${FUNCDIRNAM}/${FUNCNAM}.sh

        # Define function configuration directory. The function
        # configuration directory is used to store functionality's
        # related files.
        FUNCCONFIG=${FUNCDIR}/${FUNCDIRNAM}/Config

        # Check function script existence.
        cli_checkFiles $FUNCSCRIPT 'f'

    else
        # Print an error message and stop script execution.
        cli_printMessage "`eval_gettext "The function \\\`\\\$FUNCNAM' is not valid."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Remove the first argument passed to centos-art.sh command-line
    # in order to build optional arguments inside functionalities. We
    # start counting from second argument (inclusive) on.
    shift 1

    # Redefine positional parameters stored inside ARGUMENTS variable.
    cli_doParseArgumentsReDef "$@"

    # Define default text editors used by centos-art.sh script.
    if [[ ! "$EDITOR" =~ '/usr/bin/(vim|emacs|nano)' ]];then
        EDITOR='/usr/bin/vim'
    fi
    
    # Check text editor execution rights. 
    cli_checkFiles $EDITOR 'x'

    # Initialize regular expression (REGEX) used to reduce file
    # processing. If no regular expression is defined, set regular
    # expression to match everything.
    REGEX='.+'

    # Go for function initialization. Keep the cli_getFunctions
    # function calling after all variables and arguments definitions.
    cli_getFunctions

}
