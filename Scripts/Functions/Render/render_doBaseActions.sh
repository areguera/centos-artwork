#!/bin/bash
#
# render_doBaseActions.sh -- This function performs base-rendition
# action for all files.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

function render_doBaseActions {

    local -a FILES
    local FILE=''
    local OUTPUT=''
    local TEMPLATE=''
    local PARENTDIR=''
    local EXTENSION=''
    local TRANSLATION=''
    local EXTERNALFILE=''
    local EXTERNALFILES=''
    local THIS_FILE_DIR=''
    local NEXT_FILE_DIR=''
    local COUNT=0

    # Initialize post-rendition list of actions,  the specification of
    # what actions does centos-art execute immediatly after producing
    # the base file in the same directory structure. 
    local -a POSTACTIONS
    
    # Initialize last-rendition list of actions, the specification of
    # what actions does centos-art execute once all base files in the
    # same directory structure have been produced, this is just
    # immediatly before passing to produce the next directory
    # structure.
    local -a LASTACTIONS

    # Verify default directory where design models are stored in.
    cli_checkFiles "$(cli_getRepoTLDir)/Identity/Models/Themes/${FLAG_THEME_MODEL}" --directory

    # Define the extension pattern for template files. This is the
    # file extensions that centos-art will look for in order to build
    # the list of files to process. The list of files to process
    # contains the files that match this extension pattern.
    EXTENSION='(svgz|svg|xhtml|docbook)'

    # Redefine parent directory for current workplace.
    PARENTDIR=$(basename "${ACTIONVAL}")

    # Define base location of template files.
    render_getDirTemplate
    
    # Define list of files to process. Use an array variable to store
    # the list of files to process. This make posible to realize
    # verifications like: is the current base directory equal to the
    # next one in the list of files to process?  This is used to know
    # when centos-art.sh is leaving a directory structure and entering
    # into another. This information is required in order for
    # centos-art.sh to know when to apply last-rendition actions.
    for FILE in $(cli_getFilesList ${TEMPLATE} --pattern="${FLAG_FILTER}.*\.${EXTENSION}");do
        FILES[((++${#FILES[*]}))]=$FILE
    done

    # Start processing the base rendition list of FILES. Fun part
    # approching :-).
    while [[ $COUNT -lt ${#FILES[*]} ]];do

        # Define base file.
        FILE=${FILES[$COUNT]}

        # Define the base directory path for the current file being
        # process.
        THIS_FILE_DIR=$(dirname ${FILES[$COUNT]})

        # Define the base directory path for the next file that will
        # be process.
        if [[ $(($COUNT + 1)) -lt ${#FILES[*]} ]];then
            NEXT_FILE_DIR=$(dirname ${FILES[$(($COUNT + 1))]})
        else
            NEXT_FILE_DIR=''
        fi

        # Print separator line.
        cli_printMessage '-' --as-separator-line

        # Define final location of translation file.
        TRANSLATION=$(dirname $FILE \
           | sed -r 's!trunk/Identity/(.+)!trunk/Locales/Identity/\1!')/$(cli_getCurrentLocale)/messages.po

        # Print final location of translation file.
        if [[ ! -f "$TRANSLATION" ]];then
            cli_printMessage "`gettext "None"`" --as-translation-line
        else
            cli_printMessage "$TRANSLATION" --as-translation-line
        fi

        # Define final location of template file.
        TEMPLATE=${FILE}

        # Print final location of template file.
        if [[ ! -f "$TEMPLATE" ]];then
            cli_printMessage "`gettext "None"`" --as-design-line
        else
            cli_printMessage "$TEMPLATE" --as-design-line
        fi
 
        # Define final location of output directory.
        render_getDirOutput

        # Get relative path to file. The path string (stored in FILE)
        # has two parts: 1. the variable path and 2. the common path.
        # The variable path is before the common point in the path
        # string. The common path is after the common point in the
        # path string. The common point is the name of the parent
        # directory (stored in PARENTDIR).
        #
        # Identity/Models/Themes/.../Firstboot/3/splash-small.svg
        # -------------------------^| the     |^------------^
        # variable path             | common  |    common path
        # -------------------------v| point   |    v------------v
        # Identity/Images/Themes/.../Firstboot/Img/3/splash-small.png
        #
        # What we do here is remove the varibale path, the common
        # point, and the file extension parts in the string holding
        # the path retrived from design models directory structure.
        # Then we use the common path as relative path to store the
        # the final image file.
        #
        # The file extension is removed from the common path because
        # it is set when we create the final image file. This
        # configuration let us use different extensions for the same
        # file name.
        #
        # When we render using base-rendition action, the structure of
        # files under the output directory will be the same used after
        # the common point in the related design model directory
        # structure.
        FILE=$(echo ${FILE} \
            | sed -r "s!.*${PARENTDIR}/!!" \
            | sed -r "s/\.${EXTENSION}$//")

        # Define absolute path to final file (without extension).
        FILE=${OUTPUT}/$(basename "${FILE}")

        # Define instance name from design model.
        INSTANCE=$(cli_getTemporalFile ${TEMPLATE})

        # Verify translation file existence and create template
        # instance accordingly.
        if [[ -f ${TRANSLATION} ]];then

            # Create translated instance from design model.
            /usr/bin/xml2po -a -p ${TRANSLATION} ${TEMPLATE} > ${INSTANCE}

            # Remove .xml2po.mo temporal file.
            if [[ -f ${PWD}/.xml2po.mo ]];then
                rm ${PWD}/.xml2po.mo
            fi

        else
            # Create non-translated instance form design model.
            /bin/cp ${TEMPLATE} ${INSTANCE}    
        fi

        # Apply translation markers replacements to template instance.
        cli_replaceTMarkers ${INSTANCE}

        # Verify the extension of template instance and render content
        # accordingly.
        if [[ $INSTANCE =~ '\.(svgz|svg)$' ]];then

            # Perform base-rendition action for svg files.
            render_doSvg

            # Perform post-rendition action for svg files.
            render_doSvgPostActions

            # Perform last-rendition action for svg files.
            render_doSvgLastActions
            
        elif [[ $INSTANCE =~ '\.docbook$' ]];then

            # Perform base-rendition action for Docbook files.
            render_doDocbook

            # Perform post-rendition action for Docbook files.
            #render_doDocbookPostActions

            # Perform base-rendition action for Docbook files.
            #render_doDocbookLastActions

        elif [[ $INSTANCE =~ '\.xhtml$' ]];then

            # Perform base-rendition action for XHTML files.
            render_doXhtml

            # Perform post-rendition action for Docbook files.
            #render_doXhtmlPostActions

            # Perform base-rendition action for Xhtml files.
            #render_doXhtmlLastActions

        else
            cli_printMessage "`gettext "The template file you try to render is not supported yet."`" --as-error-line
        fi

        # Remove template instance. 
        if [[ -f $INSTANCE ]];then
            rm $INSTANCE
        fi

        # Perform post-rendition actions for all files.
        render_doPostActions

        # Perform last-rendition actions for all files.
        render_doLastActions

        # Increment file counter.
        COUNT=$(($COUNT + 1))

    done

}
