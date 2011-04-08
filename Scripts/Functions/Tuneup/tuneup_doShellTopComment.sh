#!/bin/bash
#
# tuneup_doShellTopComment.sh -- This function tunnes up the top
# comment section inside shell scripts (*.sh) using a predefined
# template.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function tuneup_doShellTopComment {

    # Define absolute path to template file.
    local TEMPLATE="${FUNCCONFIG}/shell_topcomment.sed"

    # Check template file existence.
    cli_checkFiles $TEMPLATE 'f'

    # Define file name to template instance.
    local INSTANCE=$(cli_getTemporalFile $TEMPLATE)

    # Create template instance.
    cp $TEMPLATE $INSTANCE

    # Check template instance. We cannot continue if template instance
    # couldn't be created.
    cli_checkFiles $INSTANCE 'f'

    # Expand translation markers in template instance.
    cli_replaceTMarkers $INSTANCE

    # Apply template instance to file.
    sed -r -i -f $INSTANCE $FILE

    # Remove template instance.
    if [[ -f ${INSTANCE} ]];then
        rm ${INSTANCE} 
    fi

}
