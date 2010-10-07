#!/bin/bash
#
# html_updateHeadings.sh -- This function transforms html headings to
# create the page table of content headings as reference. Multiple
# heading levels are supported using nested lists. Use this function
# over html files inside the repository to standardize their headings. 
#
#   - In order for this function to work, you need to put headings in
#     just one line and they must have the following format:
#
#       <h1><a name="head-de063c99357e6675f1ba05b33635e044">Title<a></h1>
#
#     Here h1 alternates between 1 and 6. Closing tag must be present
#     and match the one opening. The value of <a name=""> option is
#     the md5sum of page location, the 'head-' string plus heading
#     title. If heading title or page location changes, does the <a
#     name=""> option value changes too. This idea is similar to that
#     one used by MoinMoin wiki.
#
#   - This function looks for <div class="toc">...</div> specification
#     inside your page and, if present, replace the content inside
#     with the link list o headinds. 
#
#   - If <div class="toc">...</div> specification is present on the
#     page it is updated with headings links. Otherwise only heading
#     links are created. 
#
#   - If <div class="toc">...</div> specification is malformed (e.g.,
#     you forgot the closing tag), this function will look the next
#     closing div in your html code and replace everything in-between
#     with the table of content.
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

function html_updateHeadings {

    # Define variables as local to avoid conflicts outside.
    local FILES=''
    local LEVEL=1
    local HEADING=''
    local PATTERN=''
    local -a FIRST
    local -a NAME
    local -a FINAL
    local -a TITLE

    # Define list of html files to process using option value as
    # reference. 
    if [[ -d $OPTIONVAL ]];then
        FILES=$(find $OPTIONVAL -regextype posix-egrep -type f -regex '.*/*.(html|htm)$')
    elif [[ -f $OPTIONVAL ]];then
        FILES=$OPTIONVAL
    fi

    for FILE in $FILES;do

        # Verify list of html files. Are they really html files? If
        # they don't, continue with the next one in the list.
        if [[ ! $(file --brief $FILE) =~ '^(XHTML|HTML|XML)' ]];then
            continue
        fi

        # Output action message.
        cli_printMessage $FILE 'AsUpdatingLine'

        # Define how many heading levels this function works with.
        until [[ $LEVEL -eq 7 ]]; do

            # Define translation pattern. Use parenthisis to save
            # html option name, option value, and heading title.
            PATTERN="<h$LEVEL>(<a.*[^\>]>)(.*[^<])</a></h$LEVEL>"

            # Define list of headings to process. When building the
            # heading, it is required to change spaces characters from
            # its current output form to something different (e.g.,
            # its \x040 octal alternative). This is required because
            # the space character is used as egrep default field
            # separator and spaces can be present inside heading
            # strings we don't want to separate.
            for HEADING in $(egrep "$PATTERN" $FILE \
                | sed -r -e 's!^[[:space:]]+!!' -e "s! !\x040!g");do

                # Define initial heading information.
                FIRST[$COUNT]=$(echo $HEADING | sed -r "s!\x040! !g")
                TITLE[$COUNT]=$(echo ${FIRST[$COUNT]} | sed -r "s!$PATTERN!\2!")
                MD5SM[$COUNT]=$(echo "${FILE}${TITLE[$COUNT]}" | md5sum | sed -r 's![[:space:]]+-$!!')
                OPTNS[$COUNT]=$(echo ${FIRST[$COUNT]} | sed -r "s!$PATTERN!\1!")

                # Transform heading information using initial heading
                # information as reference.
                if [[ ${OPTNS[$COUNT]} =~ '^<a (href|name)=".*[^"]" (href|name)=".*[^"]">$' ]];then

                    OPTNS[$COUNT]='<a name="head-'${MD5SM[$COUNT]}'" href="#head-'${MD5SM[$COUNT]}'">'

                elif [[ ${OPTNS[$COUNT]} =~ '^<a name=".*[^"]">$' ]];then 

                    OPTNS[$COUNT]='<a name="head-'${MD5SM[$COUNT]}'">'

                elif [[ ${OPTNS[$COUNT]} =~ '^<a href=".*[^"]">$' ]];then

                    OPTNS[$COUNT]='<a href="#head-'${MD5SM[$COUNT]}'">'

                fi

                FINAL[$COUNT]='<h'$LEVEL'>'${OPTNS[$COUNT]}${TITLE[$COUNT]}'</a></h'$LEVEL'>'

                # Update heading information using transformed heading
                # information.
                sed -i -r "s!${FIRST[$COUNT]}!${FINAL[$COUNT]}!" $FILE

                # Increase heading counter.
                COUNT=$(($COUNT + 1))

            done

            # Reset heading counter.
            COUNT=0

            # Increase level counter. 
            LEVEL=$(($LEVEL + 1))

        done

        # Reset level counter.
        LEVEL=0

    done

}
