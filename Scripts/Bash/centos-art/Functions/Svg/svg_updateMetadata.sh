#!/bin/bash
#
# svg_updateMetadata.sh -- This function updates metadata values
# inside scalable vector graphic (SVG) files. First, we ask user to
# provide the information. If user doesn't provide the information,
# centos-art.sh script uses autogenerated values as default ---when
# possible--- taking as reference SVG file path. 
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
# $Id$
# ----------------------------------------------------------------------

function svg_updateMetadata {

    local NAM=''
    local URL=''
    local KEYS=''
    local FILE=''
    local COUNT=0
    local FILES=''
    local INSTANCE=''
    local TEMPLATES=''
    local -a TITLE
    local -a VALUE
    local -a PATTERN
    local -a PATTERN_MSG
    local -a MARKER
    local -a DEFAULT

    # Define template file name.
    TEMPLATE="${CLI_BASEDIR}/Functions/Svg/Config/tpl_forMetadata.sed"

    # Check template file existence.
    cli_checkFiles $TEMPLATE 'f'

    # Define titles using Inkscape 0.46 metadata definition as reference.
    TITLE[0]="`gettext "Title"`"
    TITLE[1]="`gettext "Date"`"
    TITLE[2]="`gettext "Creator"`"
    TITLE[3]="`gettext "Rights"`"
    TITLE[4]="`gettext "Publisher"`"
    TITLE[5]="`gettext "Identifier"`"
    TITLE[6]="`gettext "Source"`"
    TITLE[7]="`gettext "Relation"`"
    TITLE[8]="`gettext "Language"`"
    TITLE[9]="`gettext "Keywords"`"
    TITLE[10]="`gettext "Coverage"`"
    TITLE[11]="`gettext "Description"`"
    TITLE[12]="`gettext "Contributor"`"

    # Define markers. These values are used inside template.
    MARKER[0]='=TITLE='
    MARKER[1]='=DATE='
    MARKER[2]='=CREATOR='
    MARKER[3]='=RIGHTS='
    MARKER[4]='=PUBLISHER='
    MARKER[5]='=IDENTIFIER='
    MARKER[6]='=SOURCE='
    MARKER[7]='=RELATION='
    MARKER[8]='=LANGUAGE='
    MARKER[9]='=KEYWORDS='
    MARKER[10]='=COVERAGE='
    MARKER[11]='=DESCRIPTION='
    MARKER[12]='=CONTRIBUTOR='

    # Define pattern. These values are used as regular
    # expression patterns for user's input further verification.
    PATTERN[0]='^([[:alnum:] _-.]+)?$'
    PATTERN[1]='^([0-9]{4}-(0[1-9]|1[0-2])-([0-2][1-9]|3[0-1]))?$'
    PATTERN[2]=${PATTERN[0]}
    PATTERN[3]=${PATTERN[0]}
    PATTERN[4]=${PATTERN[0]}
    PATTERN[5]='^(https://projects.centos.org/svn/artwork/[[:alnum:]/._-]+)?$'
    PATTERN[6]=${PATTERN[5]}
    PATTERN[7]=${PATTERN[5]}
    PATTERN[8]='^([a-z]{2}(_[A-Z]{2})?)?$'
    PATTERN[9]=${PATTERN[0]}
    PATTERN[10]=${PATTERN[0]}
    PATTERN[11]=${PATTERN[0]}
    PATTERN[12]=${PATTERN[0]}

    # Define pattern message. These values are used as output
    # message when user's input doesn't match the related pattern.
    PATTERN_MSG[0]="`gettext "Try using alphanumeric characters."`"
    PATTERN_MSG[1]="`gettext "Try using 'YYYY-MM-DD' date format."`"
    PATTERN_MSG[2]=${PATTERN_MSG[0]}
    PATTERN_MSG[3]=${PATTERN_MSG[0]}
    PATTERN_MSG[4]=${PATTERN_MSG[0]}
    PATTERN_MSG[5]="`gettext "Only locations under https://projects.centos.ort/svn/artwork are supported."`"
    PATTERN_MSG[6]=${PATTERN_MSG[0]}
    PATTERN_MSG[7]=${PATTERN_MSG[0]}
    PATTERN_MSG[8]="`gettext "Try using 'LL' or 'LL_CC' locale format."`"
    PATTERN_MSG[9]=${PATTERN_MSG[0]}
    PATTERN_MSG[10]=${PATTERN_MSG[0]}
    PATTERN_MSG[11]=${PATTERN_MSG[0]}
    PATTERN_MSG[12]=${PATTERN_MSG[0]}

    # Define common default values.
    DEFAULT[1]=$(date +%Y-%m-%d)
    DEFAULT[2]="The CentOS Project"
    DEFAULT[3]=${DEFAULT[2]}
    DEFAULT[4]=${DEFAULT[2]}
    DEFAULT[8]=$(cli_getCurrentLocale)
    DEFAULT[10]=${DEFAULT[2]}

    # Initialize values using user's input.
    cli_printMessage "`gettext "Enter metadata information you want to apply:"`"
    while [[ $COUNT -ne ${#TITLE[*]} ]];do

        # Request value.
        cli_printMessage "${TITLE[$COUNT]}" 'AsRequestLine'
        read VALUE[$COUNT]

        # Sanitate values to exclude characters that could
        # introduce possible markup malformations to final SVG files.
        until [[ ${VALUE[$COUNT]} =~ ${PATTERN[$COUNT]} ]];do
            cli_printMessage "${PATTERN_MSG[$COUNT]}"
            cli_printMessage "${TITLE[$COUNT]}" 'AsRequestLine'
            read VALUE[$COUNT]
        done

        # Set default value to empty values. 
        if [[ ${VALUE[$COUNT]} == '' ]];then
            VALUE[$COUNT]=${DEFAULT[$COUNT]}
        fi

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    # Build list of files to process.
    FILES=$(cli_getFilesList "$ACTIONVAL" "${FLAG_FILTER}.*\.(svgz|svg)")

    # Set action preamble.
    cli_printActionPreamble "${FILES}"

    # Process list of scalable vector graphics.
    for FILE in $FILES;do

        # Output action message.
        cli_printMessage $FILE 'AsUpdatingLine'

        # Build title from file path.
        NAM=$(basename "$FILE")

        # Build url from file path.
        URL=$(echo $FILE | sed 's!/home/centos!https://projects.centos.org/svn!')

        # Build keywords from file path. Do not include filename, it
        # is already on title.
        KEYS=$(dirname "$FILE" | cut -d/ -f6- | tr '/' '\n')

        # Build keywords using SVG standard format. Note that this
        # information is inserted inside template file. The
        # template file is a replacement set of sed commands
        # so we need to escape the new line of each line using one
        # backslash (\). As we are doing this inside bash, it is
        # required to escape the backslash with another backslash so
        # one of them passes literally to template file.
        KEYS=$(\
            for KEY in $KEYS;do
                echo "            <rdf:li>$KEY</rdf:li>\\"
            done)

        # Redefine template instance file name.
        INSTANCE=$(cli_getTemporalFile $TEMPLATE)

        # Create template instance.
        cp $TEMPLATE $INSTANCE

        # Check template instance. We cannot continue if the template
        # instance couldn't be created.
        cli_checkFiles $INSTANCE 'f'

        # Reset counter.
        COUNT=0

        while [[ $COUNT -ne ${#TITLE[*]} ]];do

            # Redefine file-specific values.
            if [[ $COUNT -eq 0 ]];then
                VALUE[$COUNT]=$NAM
            elif [[ $COUNT -eq 5 ]];then
                VALUE[$COUNT]=$URL
            elif [[ $COUNT -eq 6 ]];then
                VALUE[$COUNT]=$URL
            elif [[ $COUNT -eq 7 ]];then
                VALUE[$COUNT]=$URL
            elif [[ $COUNT -eq 9 ]];then
                VALUE[$COUNT]=$KEYS
            fi

            # Apply translation marker replacement.
            if [[ $COUNT -eq 9 ]];then
                sed -i -r "/${MARKER[$COUNT]}/c\\${VALUE[$COUNT]}" $INSTANCE
            else
                sed -i -r "s!${MARKER[$COUNT]}!${VALUE[$COUNT]}!g" $INSTANCE
            fi

            # Increase counter.
            COUNT=$(($COUNT + 1))

        done
        
        # Sanitate template instance.
        sed -i -r -e 's/>$/>\\/g' $INSTANCE

        # Apply template instance to scalable vector graphic
        # file.
        sed -i -f $INSTANCE $FILE

        # Remove template instance.
        if [[ -f $INSTANCE ]];then
            rm $INSTANCE
        fi

        # Sanitate scalable vector graphic.
        sed -i -r '/^[[:space:]]*$/d' $FILE

    done

}
