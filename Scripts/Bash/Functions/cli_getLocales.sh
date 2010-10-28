#!/bin/bash
#
# cli_getLocales.sh -- This function outputs locale codes in LL and
# LL_CC format. Combine both ISO639 and ISO3166 specification in order
# to build the final locale list. This function defines which
# translation locales are supported inside CentOS Artwork Repository.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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

function cli_getLocales {

    local LOCALES=''

    # Add to locale list language codes (not country-specific).
    # Sometimes one language is spoken in many different countries
    # with almost irrelevant differences. For these cases using a
    # common language locale specification is convenient and help
    # locale maintainance.
    LOCALES=$(cli_getLangCodes)

    # Add to locale list language codes for some specific countries.
    # Sometimes one language is spoken in many different countires
    # with highly relevant differences. For these cases use
    # country-specific language locale specification in the following
    # list using the format LL_CC, where LL is the language code and
    # CC the country code.
    LOCALES="$LOCALES pt_BR bn_IN"

    # Replace spaces by new lines in order to transform the space
    # separated list of locales into a newline separated list of
    # locales. This let us apply commands like sort and uniq to
    # organize the final list of locales.
    LOCALES=$(echo $LOCALES | sed -r "s![[:space:]]+!\n!g")

    # Output locales organized by name and avoiding duplication lines.
    echo "$LOCALES" | sort | uniq

}
