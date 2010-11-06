#!/bin/bash
#
# cli.sh -- This function initializes centos-art command line
# interface.  Variables defined in this function are accesible by all
# other functions. The cli function is the first script executed by
# centos-art command-line onces invoked.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli {

    # Initialize global variables.
    local ACTION=''
    local OPTIONNAM=''
    local OPTIONVAL=''
    local REGEX=''

    # Define action variable using first argument (lowercase) value.
    ACTION=$(cli_getRepoName "$1" 'f')

    # Define option name (OPTIONNAM) and option value (OPTIONVAL)
    # variables passed as second argument to the command line
    # interface when the format is `--option=value' without the value
    # part.
    if [[ "$2" =~ '^--[a-z-]+=.+$' ]];then
        
        # Define option name passed in the second argument.
        OPTIONNAM=$(echo "$2" | cut -d = -f1)

        # Define option value passed in the second argument. 
        OPTIONVAL=$(echo "$2" | cut -d = -f2-)

        # Check option value passed in the second argument.
        cli_checkOptionValue

    # Define option name (OPTIONNAM), and option value (OPTIONVAL)
    # variables passed as second argument to the command line
    # interface when the format is `--option' without the value part.
    elif [[ "$2" =~ '^--[a-z-]+=?$' ]];then

        # Define option name passed in the second argument.
        OPTIONNAM=$(echo "$2" | cut -d = -f1)

        # Define option value passed in the second argument. Assume
        # the local path. This saves you some typing when you are
        # in the place you want to apply your action on.
        if [[ $(pwd) =~ '^/home/centos/artwork/.+$' ]];then
            OPTIONVAL=$(pwd)
        else
            OPTIONVAL='/home/centos/artwork/trunk'
        fi

    # Define default option name (OPTIONNAM), and default option value
    # (OPTIONVAL) when no second argument is passed to the command
    # line interface.
    else

        # Define default option name.
        OPTIONNAM="default"

        # Define default option value.
        if [[ $(pwd) =~ '^/home/centos/artwork/.+$' ]];then
            OPTIONVAL=$(pwd)
        else
            OPTIONVAL='/home/centos/artwork/trunk'
        fi

    fi

    # Define regular expression (REGEX) used to reduce file
    # processing. If no regular expression is defined, set regular
    # expression to match everything.
    if [[ "$3" =~ '^--filter=.+$' ]];then
        REGEX=$(echo "$3" | cut -d '=' -f2-)
    else
        REGEX='.+'
    fi

    # If option value plus the filter value (REGEX) points to a valid
    # file, re-define the option value (OPTIONVAL) using the
    # directory/file absolute path combination instead. This let you
    # create documentation entries for files too.
    if [[ -f $OPTIONVAL/$REGEX ]];then
        OPTIONVAL=$OPTIONVAL/$REGEX
    fi

    # Define prefix for temporal files.
    TMPFILE="/tmp/centos-art-$$"

    # Define default text editors used by centos-art.sh script.
    if [[ ! "$EDITOR" =~ '/usr/bin/(vim|emacs|nano)' ]];then
        EDITOR='/usr/bin/vim'
    fi
    
    # Check text editor execution rights. 
    cli_checkFiles $EDITOR 'x'

    # Go to defined actions. Keep the cli_getActions function calling
    # after all variables and arguments definitions. Reason? To make
    # all variables and arguments definitions available inside
    # cli_Actions and subsequent function calls inside it.
    cli_getActions "$@"

}
