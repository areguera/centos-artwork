#!/bin/bash
#
# html_updateHeadings.sh -- This function transforms html headings to
# to make them accessible (e.g., through a table of contents).
#
# - In order for this function to work, you need to put headings in
# just one line and they must have the following formats:
#
# <h1><a name="">Title</a></h1>
# <h1><a href="">Title</a></h1>
# <h1><a name="" href="">Title</a></h1>
#
# In the above examples, h1 alternates from h1 to h6. Closing tag
# must be present and match the one opentaging. The value of <a
# name=""> and <a href=""> options are the md5sum of page
# location, plus the 'head-' string, plus the heading string. If
# heading title or page location changes, the values of <a
# name=""> and <a href=""> options will change too.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function html_updateHeadings {

    # Define variables as local to avoid conflicts outside.
    local COUNT=0
    local PREVCOUNT=0
    local PATTERN=''
    local -a FINAL
    local -a TITLE
    local -a MD5SM
    local -a OPTNS
    local -a LEVEL
    local -a PARENT
    local -a TOCENTRIES
    local -a LINK

    # Define html heading regular expression pattern. Use parenthisis
    # to save html action name, action value, and heading title.
    PATTERN="<h([1-9])>(<a.*[^\>]>)(.*[^<])</a></h[1-9]>"

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="filter:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in
            --filter )
               REGEX="$2"
               shift 2
               ;;
            * )
                break
        esac
    done

    # Re-define regular expression to match html files only.
    REGEX=$(echo "${REGEX}.*\.(html|htm)")

    # Define list of files to process.
    cli_getFilesList

    # Process list of files.
    for FILE in $FILES;do

        # Verify list of html files. Are files really html files? If
        # they don't, continue with the next one in the list.
        if [[ ! $(file --brief $FILE) =~ '^(XHTML|HTML|XML)' ]];then
            continue
        fi

        # Output action message.
        cli_printMessage $FILE 'AsUpdatingLine'

        # Define list of headings to process. When building the
        # heading, it is required to change spaces characters from its
        # current decimal output to something different (e.g., its
        # \040 octal alternative). This is required because the space
        # character is used as egrep default field separator and
        # spaces can be present inside heading strings we don't want
        # to separate.
        for HEADING in $(egrep "$PATTERN" $FILE \
            | sed -r -e 's!^[[:space:]]+!!' -e "s! !\\\040!g");do

            # Define previous counter value using current counter
            # value as reference.
            if [[ $COUNT -ne 0 ]];then
                PREVCOUNT=$(($COUNT-1))
            fi

            # Define initial heading information.
            FIRST[$COUNT]=$(echo $HEADING | sed -r "s!\\\040! !g")
            TITLE[$COUNT]=$(echo ${FIRST[$COUNT]} | sed -r "s!$PATTERN!\3!")
            MD5SM[$COUNT]=$(echo "${FILE}${FIRST[$COUNT]}" | md5sum | sed -r 's![[:space:]]+-$!!')
            OPTNS[$COUNT]=$(echo ${FIRST[$COUNT]} | sed -r "s!$PATTERN!\2!")
            LEVEL[$COUNT]=$(echo ${FIRST[$COUNT]} | sed -r "s!$PATTERN!\1!")
            PARENT[$COUNT]=${LEVEL[$PREVCOUNT]}

            # Transform heading information using initial heading
            # information as reference.
            if [[ ${OPTNS[$COUNT]} =~ '^<a (href|name)="(.*)" (href|name)="(.*)">$' ]];then
                OPTNS[$COUNT]='<a name="head-'${MD5SM[$COUNT]}'" href="#head-'${MD5SM[$COUNT]}'">'
            elif [[ ${OPTNS[$COUNT]} =~ '^<a name="(.*)">$' ]];then 
                OPTNS[$COUNT]='<a name="head-'${MD5SM[$COUNT]}'">'
            elif [[ ${OPTNS[$COUNT]} =~ '^<a href="(.*)">$' ]];then
                OPTNS[$COUNT]='<a href="#head-'${MD5SM[$COUNT]}'">'
            fi

            # Build final html heading structure.
            FINAL[$COUNT]='<h'${LEVEL[$COUNT]}'>'${OPTNS[$COUNT]}${TITLE[$COUNT]}'</a></h'${LEVEL[$COUNT]}'>'

            # Build html heading link structure. These links are used
            # by the table of contents later.
            LINK[$COUNT]='<a href="#head-'${MD5SM[$COUNT]}'">'${TITLE[$COUNT]}'</a>'

            # Build table of contents entry with numerical
            # identifications. The numerical identification is what we
            # use to determine the correct position of each heading
            # link on the table of content.
            TOCENTRIES[$COUNT]="$COUNT:${LEVEL[$COUNT]}:${PARENT[$COUNT]}:${LINK[$COUNT]}"

            # Update heading information inside the current file being
            # processed. Use the first and final heading information.
            sed -i -r "s!${FIRST[$COUNT]}!${FINAL[$COUNT]}!" $FILE

            # Increase heading counter.
            COUNT=$(($COUNT + 1))

        done

        # Build the table of contents using heading numerical
        # identifications as reference. The numerical identification
        # describes the order of headings in one html file. This
        # information is processed by awk to make the appropriate
        # replacements. Finnally, the result is stored in the TOC
        # variable.
        TOC=$(echo '<div class="toc">'
            echo "<h3>`gettext "Table of contents"`</h3>"
            for TOCENTRY in "${TOCENTRIES[@]}";do
                echo $TOCENTRY
            done \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Functions/Html/Config/output_forHeadingsToc.awk)

        # Update table of contents inside the current file being
        # processed.
        sed -i -r '/<div class="toc">(.*)<\/div>/c'"$(echo -e $TOC)" $FILE

        # Reset counters.
        COUNT=0
        PREVCOUNT=0

        # Clean up variables to receive the next file.
        unset FINAL
        unset TITLE
        unset MD5SM
        unset OPTNS
        unset LEVEL
        unset PARENT
        unset TOCENTRIES
        unset LINK

    done

}
