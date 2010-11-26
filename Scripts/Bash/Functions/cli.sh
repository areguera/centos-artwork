#!/bin/bash
#
# cli.sh -- This function initializes centos-art command line
# interface.  Variables defined in this function are accesible by all
# other functions. The cli function is the first script executed by
# centos-art command-line onces invoked.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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
    local ACTIONNAM=''
    local ACTIONVAL=''
    local REGEX=''
    local ARGUMENTS=''
    local CLINAME=''
    local CLIVERSION=''
    local CLIDESCRIP=''
    local CLICOPYRIGHT=''

    # Define centos-art.sh script personal information.
    CLINAME='centos-art.sh'
    CLIVERSION='Beta'
    CLIDESCRIP="`gettext "Automate frequent tasks inside CentOS Artwork Repository."`"
    CLICOPYRIGHT="Copyright (C) 2009, 2010 Alain Reguera Delgado"

    # Redefine positional parameters stored inside ARGUMENTS variable.
    cli_doParseArgumentsReDef "$@"

    # Redefine action variables (i.e., FUNCNAM, ACTIONNAM, and
    # ACTIONVAL).  As convenction we use the first command-line
    # argument position to define FUNCNAM, and second argument
    # position to define both ACTIONNAM and ACTIONVAL.
    cli_getActionArguments

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

    # Go to defined actions. Keep the cli_getActions function calling
    # after all variables and arguments definitions. Reason? To make
    # all variables and arguments definitions available inside
    # cli_Actions and subsequent function calls inside it.
    cli_getActions

}
