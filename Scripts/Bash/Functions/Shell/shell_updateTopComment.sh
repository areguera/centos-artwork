#!/bin/bash
#
# shell_updateTopComment.sh -- This function replaces top comment
# section inside shell scripts (*.sh) with one of many pre-defined
# templates available. Use this function to maintain shell scripts top
# comments inside repository.
#
#   Usage:
#
#   centos-art shell --update-topcomment=path/to/dir --filter=filename
#
# In the above usage example `path/to/dir' represents the parent
# directory where shell scripts, you want to update top comment, are.
# The `--filter=filename' argument is optional and if provided just
# the file specificed is affected. Otherwise all files ending in `.sh'
# are massively modified.
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

function shell_updateTopComment {

    local TEMPLATES=''
    local TEMPLATE=''
    local INSTANCE=''
    local YEAR=''

    # Define absolute path to template files.
    TEMPLATES=~/artwork/trunk/Scripts/Bash/Functions/Shell/Config

    # Define template file we want to apply. More than one template
    # file may exist, so let the user choose which one to use.
    cli_printMessage "`gettext "Select the template you want to apply"`:"
    select TEMPLATE in $(ls $TEMPLATES);do
       TEMPLATE=$TEMPLATES/$TEMPLATE
       break
    done

    # Check template file existence.
    cli_checkFiles $TEMPLATE 'f'

    # Define template instance name.
    INSTANCE=$(cli_getTemporalFile $TEMPLATE)

    # Define the last year to use in the copyright note. As last year
    # we understand the last year in which the files were modified, or
    # what is the same, the present year in which this automation
    # script was applied on.
    YEAR=$(date +%Y)

    for FILE in $FILES;do

        # Create template instance.
        sed -r -e "s!=YEAR=!$YEAR!" \
            $TEMPLATE > $INSTANCE

        # Apply template instance to file.
        sed -i -f $INSTANCE $FILE

        # Remove template instance.
        cli_checkFiles $INSTANCE 'f'
        rm $INSTANCE

    done \
        | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk

    # Check repository changes and ask user to commit them up to
    # central repository.
    cli_commitRepoChanges

}
