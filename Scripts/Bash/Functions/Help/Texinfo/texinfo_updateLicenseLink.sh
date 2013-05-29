#!/bin/bash
#
# texinfo_updateLicenseLink.sh -- This function updates the link
# information related to License directory used by Texinfo
# documentation manuals. There isn't a need to duplicate the License 
# information in each documentation manual. In fact it is important
# not to have it duplicated so we can centralize such information for
# all documentation manuals.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function texinfo_updateLicenseLink {

    # Define directory where license templates are stored in.
    local DIR=${TCAR_WORKDIR}/Documentation/Models/Texinfo/Default/${CLI_LANG_LC}

    # Define files related to license templates.
    local FILES=$(find ${DIR} -name 'Licenses*')
    
    for FILE in $FILES;do

        # Remove path from license templates.
        FILE=$(basename ${FILE})

        # Remove license files from manual's specific models.
        if [[ -e ${MANUAL_BASEDIR_L10N}/${FILE} ]];then
            rm -r ${MANUAL_BASEDIR_L10N}/${FILE}
        fi

        # Create link from manual's default models to manual's
        # specific models.
        ln -s ${DIR}/${FILE} ${MANUAL_BASEDIR_L10N}/${FILE}

    done

}
