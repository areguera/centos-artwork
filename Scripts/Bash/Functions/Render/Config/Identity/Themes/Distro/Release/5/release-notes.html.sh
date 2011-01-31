#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation markers
# and replacements for release notes in HTML format.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id: splash.png.sh 963 2011-01-26 17:25:47Z al $
# ----------------------------------------------------------------------

function render_loadConfig {

    local INDEX=''
    local -a URL
    local COUNT=0

    # Define translation markers.
    SRC[0]='=TITLE='
    for INDEX in {1..6};do
        SRC[$INDEX]="=P${INDEX}="
    done
    SRC[7]='=LOCALE='

    # Define and build URLs for replacements.
    URLS[0]=''
    URLS[1]=''
    URLS[2]='=URL_WIKI=Manuals/ReleaseNotes/CentOS=RELEASE=/'
    URLS[3]='=URL_WIKI=FAQs/CentOS=MAJOR_RELEASE=/'
    URLS[4]='=URL_WIKI=Help/'
    URLS[5]='=URL_WIKI=Contribute/'
    URLS[6]='=URL='

    # Define replacements for translation markers.
    DST[0]="`gettext "CentOS =RELEASE= Release Notes"`"

    DST[1]="`gettext "The CentOS project welcomes you to CentOS
    =RELEASE=."`"

    DST[2]="`gettext "The complete release notes for CentOS =RELEASE=
    can be found online at: =LINK="`"

    DST[3]="`gettext "A list of frequently asked questions and answers
    about CentOS =MAJOR_RELEASE= can be found here: =LINK="`"

    DST[4]="`eval_gettext "If you are looking for help with CentOS, we
    recommend you start at =LINK= for pointers to the different
    sources where you can get help."`"

    DST[5]="`gettext "For more information about The CentOS Project in
    general please visit our homepage at: =LINK=."`"

    DST[6]="`gettext "If you would like to contribute to the CentOS
    Project, see =LINK= for areas where you could help."`"

    DST[7]="$(cli_getCurrentLocale)"

    # Redefine replacements in order to convert urls into html links.
    while [[ $COUNT -lt ${#URLS[*]} ]];do
        DST[$COUNT]=$(echo ${DST[$COUNT]} \
            | sed -r "s!=LINK=!<a href=\"${URLS[$COUNT]}\">${URLS[$COUNT]}</a>!g")
        COUNT=$(($COUNT + 1))
    done

}
