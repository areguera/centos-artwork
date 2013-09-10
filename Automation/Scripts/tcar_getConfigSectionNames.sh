#!/bin/bash
######################################################################
#
#   tcar_getConfigSectionNames.sh -- This function standardizes the way
#   section names are retrieved from configuration files. Once section
#   names are retrieved they are printed to standard output for
#   further processing.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
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
######################################################################

function tcar_getConfigSectionNames {

    # Define absolute path to configuration file we want to retrieve
    # section names from. 
    local CONFIGURATION_FILE=${1}

    # Verify existence of configuration file.
    tcar_checkFiles -ef ${CONFIGURATION_FILE}

    # Define regular expression pattern used to retrieve section names
    # from configuration files. Don't permit any regular expression
    # meta-character either.
    local CONFIGURATION_SECTION_REGEX='^\[[[:alnum:]_.-]+\][[:space:]]*$'

    # Output all section names without brackets, one per line. Don't
    # permit any kind of expansion here. Section names are used as
    # reference to retrieve information from configuration file,
    # expanding them would create different points of verifications.
    egrep ${CONFIGURATION_SECTION_REGEX} ${CONFIGURATION_FILE} \
        | sed -r 's,\[(.+)\],\1,'

}
