#!/bin/bash
#
# cli_checkRepoDirTarget.sh -- This function provides input validation
# to repository entries considered as target location.
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
# $Id: cli_checkRepoDirTarget.sh 547 2010-11-26 16:58:06Z al $
# ----------------------------------------------------------------------

function cli_checkRepoDirTarget {

    # Check target value before making an absolute path from it. 
    if [[ $FLAG_TO =~ '(\.\.(/)?)' ]];then
        cli_printMessage "`gettext "The path provided can't be processed."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi
    if [[ ! $FLAG_TO =~ '^[A-Za-z0-9\.:/-]+$' ]];then
        cli_printMessage "`gettext "The path provided can't be processed."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Redefine target value to build repository absolute path from
    # repository top level on. As we are removing
    # /home/centos/artwork/ from all centos-art.sh output (in order to
    # save horizontal output space), we need to be sure that all
    # strings begining with trunk/..., branches/..., and tags/... use
    # the correct absolute path. That is, you can refer trunk's
    # entries using both /home/centos/artwork/trunk/... or just
    # trunk/..., the /home/centos/artwork/ part is automatically added
    # here. 
    if [[ $FLAG_TO =~ '^(trunk|branches|tags)/.+$' ]];then
        FLAG_TO=/home/centos/artwork/$FLAG_TO 
    fi

    # Check target value.
    if [[ -a ${FLAG_TO} ]];then

        # At this point target value does existent as working copy
        # entry. We don't use existent locations as target.  So, print
        # a message and stop script execution.
        cli_printMessage "`eval_gettext "The location \\\`\\\$FLAG_TO' already exists."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'

    else

        # At this point existent locations inside working copy and
        # invalid urls have been discarded. Assume a new target
        # location has being specified. So, build the absolute path
        # for it.

        # Add directory to the top of the directory stack.
        pushd "$(dirname $FLAG_TO)" > /dev/null

        # Check directory existence inside the repository.
        if [[ $(pwd) =~ '^/home/centos/artwork' ]];then
            # Re-define target value using absolute path.
            FLAG_TO=$(pwd)/$(basename $FLAG_TO)
        fi

        # Remove directory from the directory stack.
        popd > /dev/null

        # Verify target location. It is required that target location
        # points to an entry under (trunk|branches|tags)/Identity/...
        # directory structure *only*.  Remember that Identity parent
        # directory structure is the reference used to create parallel
        # directories (i.e., documentation, configuration scripts,
        # translations, etc.). We don't manipulate parallel
        # directories with path ---or any other--- functionality
        # directly.  Consider manipulation of parallel directories as
        # a consequence of a previous manipulation of Identity parent
        # directory structure.
        if [[ ! ${FLAG_TO} =~ '^.+/(trunk|branches|tags)/Identity/.+$' ]];then
            cli_printMessage "`eval_gettext "cannot create \\\`\\\$FLAG_TO': It isn't an identity directory structure."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
        fi
    fi

}
