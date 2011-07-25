#!/bin/bash
#
# texinfo_makeSeeAlso.sh -- This function creates a list of links with
# section entries one level ahead from the current section entry being
# processed. Desition of what of these texinfo definitions to use is
# set inside the section entry itself, through the following
# construction:
#
#   @c -- <[centos-art(SeeAlso,TYPE)
#   @c -- ]>
#
# In this construction, the TYPE variable can be either `itemize',
# `enumerate' or `menu'.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
# $Id$
# ----------------------------------------------------------------------

function texinfo_makeSeeAlso {

    # Initialize variables.
    local CHILD_ENTRIES=''
    local CHILD_ENTRY=''
    local ENTRY_PATTERN=''
    local LIST_DEF=''
    local LIST_ENTRIES=''
    local LIST_TYPE=''
    local LIST_TYPE_PATTERN=''
    local MANUAL_ENTRY=''
    local TMARK=''
    local TMARK_PATTERN=''
    local TMARKS=''

    # Define absolute path to section entry.
    MANUAL_ENTRY="$1"

    # Verify section entry. When section entries are deleted, there is
    # no menu definition to set.
    if [[ ! -f $MANUAL_ENTRY ]];then
        return
    fi

    # Define `SeeAlso' transltaion marker regular expression pattern.
    TMARK_PATTERN="^@c -- <\[${CLI_PROGRAM}\(SeeAlso(,(itemize|enumerate|menu))?\)$"

    # Retrive `SeeAlso' translation marker definition lines. Be sure
    # to retrive unique definitions only. If the same definition is
    # present more than once, it will be expanded in one pass. There's
    # no need to go through different passes in order to expand
    # repeated translation marker definition.
    TMARKS=$(egrep "${TMARK_PATTERN}" $MANUAL_ENTRY | sort | uniq)

    # Remove spaces from translation marker definition lines in order
    # to process them correctly. Otherwise the definition line would
    # be broken on each space character and then that wouldn't be the
    # definition line we initially conceived.
    TMARKS=$(echo "$TMARKS" | sed -r 's/ /\\040/g')

    # Define pattern used to build list of child sections. A child
    # section shares the same path information of its parent with out
    # file extension. For example, if you have the `identity',
    # `identity-images' and `identity-images-themes' section entries,
    # `identity-images' is a child entry of `identity' likewise
    # `identity-images-themes' is a child entry of `identity-images'.
    ENTRY_PATTERN=$(echo "$MANUAL_ENTRY" | sed -r "s/\.${MANUAL_EXTENSION}$//")

    # Define list of child entries we'll use as reference to build the
    # menu nodes. Reverse the output here to produce the correct value
    # based on menu nodes definition set further.
    CHILD_ENTRIES=$(cli_getFilesList $(dirname ${MANUAL_ENTRY}) \
        --pattern="${ENTRY_PATTERN}-[[:alnum:]]+\.${MANUAL_EXTENSION}" | sort -r | uniq )

    # Loop through translation marker definition lines.
    for TMARK in $TMARKS;do

        # Define list type based on translation marker definition.
        # Remember to revert back the space character transformation
        # we previously did, in order for the translation marker
        # regular expression pattern to match.
        LIST_TYPE=$(echo "$TMARK" | sed -r -e 's/\\040/ /g' -e "s/${TMARK_PATTERN}/\2/")

        # Define list type default value.  This is, the list type used
        # when no list type is specified in the translation marker
        # construction properties field.
        if [[ $LIST_TYPE == '' ]];then
            LIST_TYPE="itemize"
        fi

        # Define list properties (type included).
        LIST_PROP=$(echo "$TMARK" | sed -r -e 's/\\040/ /g' -e "s/${TMARK_PATTERN}/\1/")

        # Define `SeeAlso' transltaion marker regular expression
        # pattern that matches the translation marker definition.
        # Notice that we cannot use TMARK_PATTERN here because it
        # includes a selection list of all possible translation
        # markers that can provided and here we need to precisely set
        # the one being currently processed, not those whose could be
        # processed.
        LIST_TYPE_PATTERN="^@c -- <\[${CLI_PROGRAM}\(SeeAlso${LIST_PROP}\)$"

        # Redefine list's entry based on translation marker definition.
        if [[ $LIST_TYPE =~ '^menu$' ]];then
            for CHILD_ENTRY in $CHILD_ENTRIES;do
                LIST_ENTRIES="* $(${FLAG_BACKEND}_getEntryNode "$CHILD_ENTRY")::\n${LIST_ENTRIES}"
            done
        elif [[ $LIST_TYPE =~ '^(itemize|enumerate)$' ]];then 
            for CHILD_ENTRY in $CHILD_ENTRIES;do
                LIST_ENTRIES="@item @ref{$(${FLAG_BACKEND}_getEntryNode "$CHILD_ENTRY")}\n${LIST_ENTRIES}"
            done
        else
            # When an translation marker isn't recognize, go on with
            # the next one in the list.
            continue
        fi

        # Define menu using menu nodes.
        LIST_DEF="@c -- <[${CLI_PROGRAM}(SeeAlso${LIST_PROP})\n@${LIST_TYPE}\n${LIST_ENTRIES}@end ${LIST_TYPE}\n@c -- ]>"

        # Expand list definition using translation marker and list
        # definition itself. Be sure that no expansion be done when
        # the closing tag of translation marker isn't specified.
        # Otherwise, there might be lost of content.
        sed -r -i "/${LIST_TYPE_PATTERN}/{:a;N;/\n@c -- ]>$/!ba;s/.*/${LIST_DEF}/;}" $MANUAL_ENTRY

        # Clean up both list definition and list entries. Otherwise
        # undesired concatenations happen.
        LIST_DEF=''
        LIST_ENTRIES=''
        LIST_TYPE=''

    done
 
}
