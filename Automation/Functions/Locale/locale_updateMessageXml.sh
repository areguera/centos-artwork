#!/bin/bash
#
# locale_updateMessageXml.sh -- This function parses XML-based files
# (e.g., Scalable Vector Graphics and Docbook files), retrieves
# translatable strings and creates/update gettext portable objects.
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

function locale_updateMessageXml {

    # Define what kind of XML file we are generating translation
    # messages for. This is relevant because scalable vector graphics
    # (SVG) files are not using entity expansion while DocBook files
    # do.
    if [[ $ACTIONVAL =~ "^${TCAR_WORKDIR}/Documentation/Models/Docbook/[[:alnum:]-]+$" ]];then

        locale_updateMessageXmlDocbook

        # Combine template messages and licenses messages so when
        # template be merged into the final portable object the
        # translations be there. If we cannot treat licenses as
        # independent documents (e.g., through XInclude), then lets
        # keep translation messages as synchronized as possible.

    elif [[ $ACTIONVAL =~ "^${TCAR_WORKDIR}/Identity/Models/.+$" ]] \
        || [[ $ACTIONVAL =~ "^${TCAR_WORKDIR}/Documentation/Models/Svg/.+$" ]];then

        locale_updateMessageXmlSvg

    else

        cli_printMessage "`gettext "The path provided doesn't support localization."`" --as-error-line

    fi

}
