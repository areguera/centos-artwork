#!/bin/bash
#
# locale.sh -- This function provides internationalization features to
# centos-art.sh script by means of gettext.
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

function locale {

    # Initialize default value to create/update machine object flag.
    # The machine object flag (--create-mo) controls whether
    # centos-art.sh script creates/updates the machine object related
    # to portable object or not.
    local FLAG_DONT_CREATE_MO='false'

    # Define the command-line interface.
    locale_getActions

}
