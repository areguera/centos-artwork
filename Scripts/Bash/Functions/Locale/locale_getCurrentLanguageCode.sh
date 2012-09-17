#!/bin/bash
#
# locale_getCurrentLanguageCode.sh -- This function checks LANG
# environment variable and returns the current locale information in
# the LL format.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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
# $Id: locale_getCurrentLanguageCode.sh 5653 2012-09-16 20:37:21Z al $
# ----------------------------------------------------------------------

function locale_getCurrentLanguageCode {

    # Output current language code.
    locale_getCurrentLocale | cut -d'_' -f1

}

