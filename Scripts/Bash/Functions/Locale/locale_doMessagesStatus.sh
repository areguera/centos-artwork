#!/bin/bash
#
# locale_doMessagesStatus.sh -- This function outputs the
# centos-art.sh translations table. Use this function to know how many
# languages the centos-art.sh script is available in, the last
# translators and revision dates.
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
# $Id$
# ----------------------------------------------------------------------

function locale_doMessagesStatus {

    # Define variables as local to avoid conflicts outside.
    local LOCALESLIST=''
    local LANG_NAME=''
    local LANG_COUNTRY=''
    local PO_LASTAUTHOR=''
    local PO_REVDATE=''
    local PO_STATUS=''

    # Define list of locale codes.
    LOCALESLIST=$(cli_getLocales) 

    for LOCALECODE in $LOCALESLIST;do

        LANG_NAME=$(cli_getLangName $LOCALECODE)
        LANG_COUNTRY=$(cli_getCountryName $LOCALECODE)

        if [[ -f $TEXTDOMAINDIR/$LOCALECODE/$TEXTDOMAIN.po ]] \
            && [[ -f $TEXTDOMAINDIR/$LOCALECODE/LC_MESSAGES/$TEXTDOMAIN.mo ]];then

            # Re-define translation's status.
            PO_STATUS="`gettext "Available"`"

            # Re-define translation's last update.
            PO_REVDATE=$(egrep '^"PO-Revision-Date:' $TEXTDOMAINDIR/$LOCALECODE/$TEXTDOMAIN.po \
                | cut -d: -f2- | sed -r 's!\\n"!!' | sed -r 's!^[[:space:]]+!!' | cut -d ' ' -f1)

            # Re-define translation's last author.
            PO_LASTAUTHOR=$(egrep '^"Last-Translator:' $TEXTDOMAINDIR/$LOCALECODE/$TEXTDOMAIN.po \
                | cut -d: -f2 | sed -r 's!\\n"!!' | sed -r 's!^[[:space:]]+!!')

        else

            LANGCOUNTRY=""
            PO_LASTAUTHOR=""
            PO_REVDATE=""
            PO_STATUS=""

        fi

        # Output information line.
        echo "$LOCALECODE | $LANG_NAME | $LANG_COUNTRY | $PO_STATUS | $PO_REVDATE | $PO_LASTAUTHOR"

    done \
        | egrep -i $REGEX \
        | awk 'BEGIN {FS="|"; format ="%7s\t%-15s\t%-15s\t%-12s\t%-12s\t%-s\n"
                      printf "--------------------------------------------------------------------------------\n"
                      printf format, "'`gettext "Code"`'", " '`gettext "Language"`'", " '`gettext "Country"`'",\
                      " '`gettext "Status"`'", " '`gettext "LastRev"`'", " '`gettext "Author"`'"
                      printf "--------------------------------------------------------------------------------\n"}
                     {printf format, substr($1,0,7), substr($2,0,15), substr($3,0,15), $4, $5, $6}
                 END {printf "--------------------------------------------------------------------------------\n"}'
}
