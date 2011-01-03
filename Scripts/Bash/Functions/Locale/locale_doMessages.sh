#!/bin/bash
#
# locale_doMessages.sh -- This function standardize centos-art.sh
# localization process using gettext commands.  All messages inside
# centos-art.sh script are written in English language.
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
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_doMessages {

    # Define variables as local to avoid conflicts outside.
    local POT_FILE=$TEXTDOMAINDIR/$TEXTDOMAIN.pot
    local PO_FILE=$TEXTDOMAINDIR/$(cli_getCurrentLocale)/$TEXTDOMAIN.po
    local MO_FILE=$TEXTDOMAINDIR/$(cli_getCurrentLocale)/LC_MESSAGES/$TEXTDOMAIN.mo
    local LANGNAME=$(cli_getLangName $(cli_getCurrentLocale))
    local PO_HEAD_DATE=''
    local PO_HEAD_BUGS=''

    # Output action message.
    cli_printMessage "`gettext "The following translation files will be updated:"`"
    cli_printMessage "$POT_FILE" "AsResponseLine"
    cli_printMessage "$PO_FILE" "AsResponseLine"
    cli_printMessage "$MO_FILE" "AsResponseLine"
    cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

    # Prepare directory structure for centos-art.sh localization
    # files.
    if [[ ! -d $(dirname $MO_FILE) ]];then
        mkdir -p $(dirname $MO_FILE)
    fi

    # Create portable object template (.pot). 
    find /home/centos/artwork/trunk/Scripts/Bash -name '*.sh' \
        | xargs xgettext --language=Shell --output=$POT_FILE -

    # Create portable object (.po) for the current language.
    if [[ ! -f $PO_FILE ]];then
        msginit --input=$POT_FILE --output=$PO_FILE
    else
        msgmerge --update $PO_FILE $POT_FILE
    fi

    # Update portable object bugs report in its header entries. This
    # entry is removed each time the portable object is generated. To
    # avoid loosing its value, re-define it before editing the portable
    # object (.po) file.
    PO_HEAD_BUGS="\"Report-Msgid-Bugs-To: CentOS Documentation SIG <centos-docs@centos.org>\\\n\""
    sed -i -r "/^\"Report-Msgid-Bugs-To:/c$PO_HEAD_BUGS" $PO_FILE

    # Edit portable object (.po) for the current language. In this
    # step is when translators do their work.
    eval $EDITOR $PO_FILE

    # Update portable object revision date in its header entries.
    PO_HEAD_DATE="\"PO-Revision-Date: $(date "+%Y-%m-%d %H:%M%z")\\\n\""
    sed -i -r "/^\"PO-Revision-Date:/c$PO_HEAD_DATE" $PO_FILE

    # Create machine object (.mo).
    msgfmt $PO_FILE --output=$MO_FILE

    # Check repository changes and ask you to commit them up to
    # central repository.
    cli_commitRepoChanges "$TEXTDOMAINDIR"
    
}
