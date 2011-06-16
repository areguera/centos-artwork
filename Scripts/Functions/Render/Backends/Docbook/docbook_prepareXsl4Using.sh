#!/bin/bash
#
# docbook_prepareXsl4Using.sh -- This function prepares XSL final
# instances used in transformations based on XSL templates.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function docbook_prepareXsl4Using {

    local XSL_TEMPLATE_FILE=''
    local XSL_TEMPLATE_FILES=$@
    local XSL_INSTANCE_COMMON=''
    local COUNT=0

    for XSL_TEMPLATE_FILE in $XSL_TEMPLATE_FILES;do

        XSL_TEMPLATE[((++${#XSL_TEMPLATE[*]}))]="${XSL_TEMPLATE_FILE}"
        XSL_INSTANCE[((++${#XSL_INSTANCE[*]}))]="$(cli_getTemporalFile ${XSL_TEMPLATE_FILE})"

        # Keep track of array's real index value. Remember, it starts
        # at zero but counting starts at 1 instead. So, substracting 1
        # from counting we have the real index value we need to work
        # with the information stored in the array.
        COUNT=$(( ${#XSL_INSTANCE[*]} - 1 ))

        # Create XSL instance from XSL template.
        cp ${XSL_TEMPLATE[$COUNT]} ${XSL_INSTANCE[$COUNT]}

        # Define both final an common XSL instances based on XSL
        # template.
        if [[ $XSL_TEMPLATE_FILE =~ 'docbook2fo\.xsl$' ]];then
            XSL_INSTANCE_FINAL=${XSL_INSTANCE[$COUNT]}
        elif [[ $XSL_TEMPLATE_FILE =~ 'docbook2xhtml-(chunks|single)\.xsl$' ]];then
            XSL_INSTANCE_FINAL=${XSL_INSTANCE[${COUNT}]}
        elif [[ $XSL_TEMPLATE_FILE =~ 'docbook2xhtml-common\.xsl$' ]];then
            XSL_INSTANCE_COMMON=${XSL_INSTANCE[${COUNT}]}
        fi

    done

    # Verify XSL final instance. This is the file used by `xsltproc'
    # to produce the specified output. We cannot continue without it.
    cli_checkFiles $XSL_INSTANCE_FINAL 

    # Expand common translation markers in XSL common instances. This
    # expantion is optional.
    if [[ -f $XSL_INSTANCE_COMMON ]];then
        cli_replaceTMarkers $XSL_INSTANCE_COMMON
    fi

    # Expand specific translation markers in XSL final instance.
    sed -r -i "s!=XSL_XHTML_COMMON=!${XSL_INSTANCE_COMMON}!" ${XSL_INSTANCE_FINAL}

}
