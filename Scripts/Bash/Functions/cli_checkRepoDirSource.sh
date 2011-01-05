#!/bin/bash
#
# cli_checkRepoDirSource.sh -- This function provides input validation
# to repository entries considered as source locations.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function cli_checkRepoDirSource {
                
    # Check source value before making an absolute path from it.
    if [[ $ACTIONVAL == '' ]] \
        || [[ $ACTIONVAL =~ '(\.\.(/)?)' ]] \
        || [[ ! $ACTIONVAL =~ '^[A-Za-z0-9\.:/-]+$' ]];then
        cli_printMessage "`eval_gettext "The value \\\`\\\$ACTIONVAL' is not valid."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Redefine source value to build repository absolute path from
    # repository top level on. As we are removing
    # /home/centos/artwork/ from all centos-art.sh output (in order to
    # save horizontal output space), we need to be sure that all
    # strings begining with trunk/..., branches/..., and tags/... use
    # the correct absolute path. That is, you can refer trunk's
    # entries using both /home/centos/artwork/trunk/... or just
    # trunk/..., the /home/centos/artwork/ part is automatically added
    # here. 
    if [[ $ACTIONVAL =~ '^(trunk|branches|tags)' ]];then
        ACTIONVAL=/home/centos/artwork/$ACTIONVAL 
    fi

    # Re-define source value to build repository absolute path from
    # repository relative paths. This let us to pass repository
    # relative paths as source value.  Passing relative paths as
    # source value may save us some typing; specially if we are stood
    # a few levels up from the location we want to refer to as source
    # value.  There is no need to pass the absolute path to it, just
    # refere it relatively.
    if [[ -d ${ACTIONVAL} ]];then

        # Add directory to the top of the directory stack.
        pushd "$ACTIONVAL" > /dev/null

        # Check directory existence inside the repository.
        if [[ $(pwd) =~ '^/home/centos/artwork' ]];then
            # Re-define source value using absolute path.
            ACTIONVAL=$(pwd)
        else
            cli_printMessage "`eval_gettext "The location \\\`\\\$ACTIONVAL' is not valid."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
        fi

        # Remove directory from the directory stack.
        popd > /dev/null

    elif [[ -f ${ACTIONVAL} ]];then

        # Add directory to the top of the directory stack.
        pushd "$(dirname $ACTIONVAL)" > /dev/null

        # Check directory existence inside the repository.
        if [[ $(pwd) =~ '^/home/centos/artwork' ]];then
            # Re-define source value using absolute path.
            ACTIONVAL=$(pwd)/$(basename $ACTIONVAL)
        else
            cli_printMessage "`eval_gettext "The location \\\`\\\$ACTIONVAL' is not valid."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
        fi

        # Remove directory from the directory stack.
        popd > /dev/null

    else

        # At this there is no existent working copy entry, nor a valid
        # url. The source value can only be considered as such if it
        # is an existent working copy or valid url. So, print a
        # message and stop script execution.
        cli_printMessage "`eval_gettext "The location \\\`\\\$ACTIONVAL' is not valid."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'

    fi

}
