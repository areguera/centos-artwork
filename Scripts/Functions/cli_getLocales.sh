#!/bin/bash
#
# cli_getLocales.sh -- This function outputs/verifies locale codes in
# LL and LL_CC format. Combine both ISO639 and ISO3166 specification
# in order to build the final locale list. This function defines which
# translation locales are supported inside CentOS Artwork Repository.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getLocales {

    # Print locales supported by centos-art.sh script.
    locale -a | egrep '^[a-z]{2,3}_[A-Z]{2}$' | sort | uniq

}
