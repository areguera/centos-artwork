#!/bin/bash
#
# license.sh -- This function outputs centos-art.sh license message.
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
# $Id: license.sh 61 2010-09-17 12:03:51Z al $
# ----------------------------------------------------------------------

function license {

    # Define command-line information.
    local COMMAND="centos-art.sh"
    local DESCRIPTION="$COMMAND - `gettext "Automate frequent tasks inside CentOS Artwork Repository."`"
    local RELEASE="alpha"
    local COPYRIGHT="Copyright (C) 2009-2010 Alain Reguera Delgado."
    local LICENSE="This program is free software; you can redistribute
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

    # Build license message.
    local LICENSE="$DESCRIPTION

        $COPYRIGHT

        $LICENSE"

    # Output license message.
    cli_printMessage "$LICENSE" "AsHeadingLine"

}
