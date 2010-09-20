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
# $Id: cli.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function cli {

    # Define action variable using first argument (lowercase) value.
    ACTION=$(cli_getRepoName 'f' "$1")

    # Define command-line information.
    CLI_COMMAND="centos-art.sh"
    CLI_DESCRIPTION="$CLI_COMMAND - `gettext "Automate frequent tasks inside CentOS Artwork Repository."`"
    CLI_RELEASE="alpha"
    CLI_COPYRIGHT="Copyright (C) 2009-2010 Alain Reguera Delgado."
    CLI_LICENSE="This program is free software; you can redistribute
        it and/or modify it under the terms of the GNU General Public License
        as published by the Free Software Foundation; either version 2 of the
        License, or (at your option) any later version.
     
        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
        General Public License for more details.
         
        You should have received a copy of the GNU General Public License
        along with this program; if not, write to the Free Software
        Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
        USA."

    # Define option name (OPTIONNAM) and option value (OPTIONVAL)
    # variables passed as second argument to the command line
    # interface when the format is `--option=value' without the value
    # part.
    if [[ "$2" =~ '^-{1,2}[a-z]+=.+$' ]];then
        
        # Define option name passed in the second argument.
        OPTIONNAM=$(echo "$2" | cut -d = -f1)

        # Define option value passed in the second argument. 
        OPTIONVAL=$(echo "$2" | cut -d = -f2-)

        # Check option value passed in the second argument.
        cli_checkOptionValue

    # Define option name (OPTIONNAM), and option value (OPTIONVAL)
    # variables passed as second argument to the command line
    # interface when the format is `--option' without the value part.
    elif [[ "$2" =~ '^-{1,2}[a-z]+=?$' ]];then

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

    # Define centos-art.sh standard paths.
    REPO_PATHS[0]=/home/centos
    REPO_PATHS[1]=${REPO_PATHS[0]}/bin
    REPO_PATHS[2]=${REPO_PATHS[1]}/centos-art
    REPO_PATHS[3]=${REPO_PATHS[0]}/artwork/trunk/Scripts/Bash/$CLI_COMMAND
    REPO_PATHS[4]=${REPO_PATHS[0]}/artwork/trunk/Scripts/Bash
    REPO_PATHS[5]=${REPO_PATHS[0]}/artwork/trunk/Translations
    REPO_PATHS[6]=${REPO_PATHS[0]}/.fonts
    REPO_PATHS[7]=${REPO_PATHS[0]}/artwork/trunk/Identity/Fonts/Ttf
    REPO_PATHS[8]=${REPO_PATHS[0]}/artwork/trunk/Scripts/Bash/Functions

    # Define positive answer.
    Y="`gettext "y"`"

    # Define negative answer.
    N="`gettext "N"`"

    # Define default answer to questions.
    ANSWER=${N}

    # Define a unique string based on script name and process id used
    # to create temporal files under /tmp/.
    FILEID="centos-art$$"

    # Define text editor used to edit texinfo documentation. Predifine
    # possible editors paths here to avoid malevolent values. If we do
    # not create this restriction editor can be set to anything other
    # than a text editor and in that case be executed when you try to
    # edit a documentation entry using the `centos-art help --edit'
    # command.
    if [[ ! "$EDITOR" =~ '/usr/bin/(emacs|vim|nano)' ]];then
        EDITOR='/usr/bin/vim'
    fi

    # Go to defined actions. Keep the cli_getActions function calling
    # after all variables and arguments definitions. Reason? To make
    # all variables and arguments definitions available inside
    # cli_Actions and subsequent function calls inside it.
    cli_getActions "$@"

}
