#!/bin/bash
#
# html_updateHeadings.sh -- This function transforms html headings to
# to make them accessible (e.g., through a table of contents).
#
#   - In order for this function to work, you need to put headings in
#     just one line and they must have the following formats:
#
#       <h1><a name="">Title</a></h1>
#       <h1><a href="">Title</a></h1>
#       <h1><a name="" href="">Title</a></h1>
#
#     In the above examples, h1 alternates from h1 to h6. Closing tag
#     must be present and match the one opening. The value of <a
#     name=""> and <a href=""> options are the md5sum of page
#     location, plus the 'head-' string, plus the heading string. If
#     heading title or page location changes, the values of <a
#     name=""> and <a href=""> options will change too.
#
#   - When creating the table of contents, this function looks for
#     <div class="toc">...</div> specification inside your page and,
#     if present, replaces the content inside with the list of heading
#     links.
#
#   - If <div class="toc">...</div> specification is present on the
#     page it is updated with headings links. Otherwise only heading
#     links are updated. 
#
#   - If <div class="toc">...</div> specification is malformed (e.g.,
#     you forgot the closing tag), this function will look the next
#     closing div in your html code and replaces everything in-between
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
    local COUNT=0
    local HEADING=''
    local PATTERN=''
    local -a FIRST
    local -a FINAL
    local -a TITLE
    local -a MD5SM
    local -a OPTNS

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

                # Define entry list used to show table of contents.
                LIENTRIES[$COUNT]='<li><a href="#head-'${MD5SM[$COUNT]}'">'${TITLE[$COUNT]}'</a></li>'

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

            # Define list structure using list entries for each
            # heading level.
            if [[ ${#LIENTRIES[*]} -gt 0 ]];then
                LISTS[$(($LEVEL-1))]="${LIENTRIES[*]}"
            fi
        
            # Clean up list entries of heading.
            unset LIENTRIES

            # Reset heading counter.
            COUNT=0

            # Increase level counter. 
            LEVEL=$(($LEVEL + 1))

        done

        # Define table of contents using specific list entries.
        TOC=$(for LIST in "${LISTS[@]}";do
            if [[ $LIST != '' ]];then
                echo $LIST | sed -r 's!</li>$!<ul>!'
            fi
        done
        for LIST in "${LISTS[@]}";do
            if [[ $LIST != '' ]];then
                echo '</ul></li>'
            fi
        done)
        if [[ $TOC != '' ]];then
            TOC=$(echo -e '<div class="toc"><h3>Table of contents</h3><ul>'${TOC}'</ul></div>')
        fi

        # Update table of contents html structure.
        egrep '<div class="toc">' $FILE > /dev/null \
            && sed -i -r '\%<div class="toc">%,\%</div>%c'"$TOC" $FILE

        # Give format to table of contents html structure.
        sed -i -r '/<div class="toc">/{
            s!<h3>!\n<h3>!;
            s!</h3>!</h3>\n!;
            s!</li>!</li>\n!g;
            s!<ul>!<ul>\n!g;
            s!</div>!\n</div>!;
            }' $FILE

        # Reset level counter.
        LEVEL=1

        # Clean up level specific list entries.
        unset LISTS

    done

}
