#!/bin/bash
#
# manual_createLanguageLayout.sh -- This function creates texinfo's main
# documentation structure for an specific language.
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

function manual_createLanguageLayout {

    # Define variables as local to avoid conflicts outside
    local COUNTER=0
    local MESSAGE=''

    # Initialize translation markers for texinfo manual template.
    local DOCTPL[0]="`gettext "Set the document's title"`"
    local DOCTPL[1]="`gettext "Set the document's subtitle"`"
    local DOCTPL[2]="`gettext "Set the document's description"`"
    local DOCTPL[3]="`gettext "Set the document's author"`"

    # Request texinfo document initial information. Since the main
    # texinfo documentation file (repository.texi) requires language
    # specific values (e.g., document title, subtitle, description,
    # author, etc.) before they can be used, there is no way to create
    # those files automatically without requesting the user for those
    # initial information on his/her own language. The requesting
    # process is done in English language.
    for MESSAGE in "${DOCTPL[@]}";do
        cli_printMessage "`gettext "Step"` ${COUNTER}: $MESSAGE:" "AsRequestLine"
        read DOCTPL[${COUNTER}]
        if [[ ! $DOCTPL[${COUNTER}] =~ '[[:print:]]+' ]];then
            cli_printMessage "`gettext "The string entered isn't valid."`"
            cli_printMessage "$(caller)" "AsToKnowMoreLine"
        fi
        COUNTER=$(($COUNTER + 1))
    done
    
    # At this point all information required to build texinfo document
    # has been collected. Leave a message and start creating texinfo
    # files based on template.
    local LANGNAME=$(cli_getLangName $(cli_getCurrentLocale))

    # Create language directory to store texinfo document structure.
    if [[ ! -d ${MANUALS_DIR[2]} ]];then
        mkdir -p ${MANUALS_DIR[2]}
    fi

    # Fill texinfo template with entered values and store the result
    # as new texinfo document structure.
    cat ${MANUALS_DIR[6]}/repository.texi \
        | sed -r "s!=TITLE=!${DOCTPL[0]}!g" \
        | sed -r "s!=SUBTITLE=!${DOCTPL[1]}!g" \
        | sed -r "s!=DESCRIPTION=!${DOCTPL[2]}!g" \
        | sed -r "s!=AUTHOR=!${DOCTPL[3]}!g" \
        | sed -r "s!=LANGUAGE=!$(cli_getLangCodes $(cli_getCurrentLocale))!g" \
        > ${MANUALS_DIR[2]}/repository.texi

    # Copy menu and nodes from template to texinfo document structure.
    cp ${MANUALS_DIR[6]}/$(basename "${MANUALS_FILE[2]}") ${MANUALS_DIR[2]}/
    cp ${MANUALS_DIR[6]}/$(basename "${MANUALS_FILE[3]}") ${MANUALS_DIR[2]}/
    cp ${MANUALS_DIR[6]}/$(basename "${MANUALS_FILE[11]}") ${MANUALS_DIR[2]}/

    # Translate English words. As we are creating texinfo
    # documentation from an English template, it is needed to
    # translate some words from English to the current language we are
    # creating texinfo documentation for.
    sed -r -i "s!Index!`gettext "Index"`!" ${MANUALS_FILE[11]} ${MANUALS_FILE[2]}

    # Output action message.
    cli_printMessage "`eval_gettext "The \\\"\\\$LANGNAME\\\" documentation structure has been created."`"

}
