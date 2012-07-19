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
    local TEMPLATE_HAS_DOCTYPE=''
    local PARENTDIR=''
    local TRANSLATION=''
    local EXTERNALFILE=''
    local EXTERNALFILES=''
    local THIS_FILE_DIR=''
    local NEXT_FILE_DIR=''
    local RENDER_EXTENSION=''
    local COUNT=0

    # Verify default directory where design models are stored in.
    cli_checkFiles "$(cli_getRepoTLDir)/Identity/Models/Themes/${FLAG_THEME_MODEL}" --directory

    # Redefine parent directory for current workplace.
    PARENTDIR=$(basename "${ACTIONVAL}")

    # Define base location of template files.
    render_getDirTemplate
    
    # Loop through list of supported file extensions. 
    for RENDER_EXTENSION in ${RENDER_EXTENSIONS};do

        # Redefine name of rendition format based on supported file
        # extension.
        if [[ $RENDER_EXTENSION =~ '^(svg|docbook)$' ]];then
            RENDER_FORMAT=${RENDER_EXTENSION}
        else
           cli_printMessage "`eval_gettext "The \\\"\\\$RENDER_EXTENSION\\\" file extension is not supported yet."`" --as-error-line 
        fi

        # Define the list of files to process. Use an array variable
        # to store the list of files to process. This make posible to
        # realize verifications like: is the current base directory
        # equal to the next one in the list of files to process?
        # Questions like this is let us to know when centos-art.sh is
        # leaving a directory structure and entering another. This
        # information is required in order for centos-art.sh to know
        # when to apply last-rendition actions.
        #
        # Another issue is that some directories might be named as if
        # they were files (e.g., using a renderable extension like
        # .docbook).  In these situations we need to avoid such
        # directories from being interpreted as a renderable file. For
        # this, pass the `--type="f"' option when building the list of
        # files to process in order to retrive regular files only.
        #
        # Another issue to consider here, is that in some cases both
        # templates and outputs might be in the same location. In
        # these cases localized content are stored in the same
        # location where template files are retrived from and we need
        # to avoid using localized content from being interpreted as
        # design models. In that sake, supress language-specific files
        # from the list of files to process.
        #
        # Another issue to consider here, is the way of filtering. We
        # cannot expand the pattern specified by FLAG_FILTER with a
        # `.*' here (e.g., "${FLAG_FILTER}.*\.${RENDER_EXTENSION}")
        # because that would suppress any possibility from the user to
        # specifiy just one file name in locations where more than one
        # file with the same name as prefix exists (e.g.,
        # `repository.docbook', `repository-preamble.docbook' and
        # `repository-parts.docbook').  Instead, pass filtering
        # control to the user whom can use regular expression markup
        # in the `--filter' option to decide whether to match
        # `repository.docbook' only (e.g., through
        # `--filter="repository"') or `repository-preamble.docbook'
        # and `repository-parts.docbook' but not `repository.docbook'
        # (e.g., through `--filter="repository-.*"').
        for FILE in $(cli_getFilesList ${TEMPLATE} \
            --pattern="${FLAG_FILTER}\.${RENDER_EXTENSION}" --type="f" \
            | egrep -v '/[[:alpha:]]{2}_[[:alpha:]]{2}/');do
            FILES[((++${#FILES[*]}))]=$FILE
        done

        # Verify list of files to process. Assuming no file is found,
        # evaluate the next supported file extension.
        if [[ ${#FILES[*]} -eq 0 ]];then
            continue
        fi

        # Initialize format-specific functionalities.
        cli_exportFunctions "${RENDER_FORMAT_DIR}/$(cli_getRepoName \
            ${RENDER_FORMAT} -d)" "${RENDER_FORMAT}"

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
               | sed -r 's!trunk/(Manuals|Identity)!trunk/Locales/\1!')/$(cli_getCurrentLocale)/messages.po

            # Define final location of template file.
            TEMPLATE=${FILE}

            # Verify design models file existence. We cannot continue
            # with out it.
            if [[ ! -f $TEMPLATE ]];then
                cli_printMessage "`gettext "The template file doesn't exist."`" --as-error-line
            fi

            # Verify whether the design model uses DOCTYPE definition
            # or not; and redefine related variable for further using.
            egrep '^<!DOCTYPE' ${TEMPLATE} > /dev/null
            TEMPLATE_HAS_DOCTYPE=$?

            # Validate design model before processing it. This step is
            # very important in order to detect document's
            # malformations and warn you about it, so you can correct
            # them before processing the document as input.  Notice
            # that, here, validation is possible only for documents
            # which have a DOCTYPE definition inside.
            if [[ $TEMPLATE_HAS_DOCTYPE -eq 0 ]];then

                # Print action message.
                cli_printMessage "$TEMPLATE" --as-validating-line

                # Validate document before processing it.  
                xmllint --valid --noent --noout $TEMPLATE
                if [[ $? -ne 0 ]];then
                    cli_printMessage "`gettext "Validation failed."`" --as-error-line
                fi

            else
                # Print action message.
                cli_printMessage "$TEMPLATE" --as-template-line
            fi
 
            # Define final location of output directory.
            render_getDirOutput

            # Get relative path to file. The path string (stored in
            # FILE) has two parts: 1. the variable path and 2. the
            # common path.  The variable path is before the common
            # point in the path string. The common path is after the
            # common point in the path string. The common point is the
            # name of the parent directory (stored in PARENTDIR).
            #
            # Identity/Models/Themes/.../Firstboot/3/splash-small.svg
            # -------------------------^| the     |^------------^
            # variable path             | common  |    common path
            # -------------------------v| point   |    v------------v
            # Identity/Images/Themes/.../Firstboot/Img/3/splash-small.png
            #
            # What we do here is remove the varibale path, the common
            # point, and the file extension parts in the string
            # holding the path retrived from design models directory
            # structure.  Then we use the common path as relative path
            # to store the the final image file.
            #
            # The file extension is removed from the common path
            # because it is set when we create the final image file.
            # This configuration let us use different extensions for
            # the same file name.
            #
            # When we render using base-rendition action, the
            # structure of files under the output directory will be
            # the same used after the common point in the related
            # design model directory structure.
            FILE=$(echo ${FILE} \
                | sed -r "s!.*${PARENTDIR}/!!" \
                | sed -r "s/\.${RENDER_EXTENSION}$//")

            # Define absolute path to final file (without extension).
            FILE=${OUTPUT}/$(basename "${FILE}")

            # Define instance name from design model.
            INSTANCE=$(cli_getTemporalFile ${TEMPLATE})

            # Apply translation file to design model to produce the design
            # model translated instance. 
            render_doTranslation

            # Expand translation markers inside design model instance.
            cli_expandTMarkers ${INSTANCE}

            # Perform format base-rendition.
            ${RENDER_FORMAT}

            # Remove template instance. 
            if [[ -f $INSTANCE ]];then
                rm $INSTANCE
            fi

            # Increment file counter.
            COUNT=$(($COUNT + 1))

        done

        # Unset format-specific functionalities.
        cli_unsetFunctions "${RENDER_FORMAT_DIR}/$(cli_getRepoName \
            ${RENDER_FORMAT} -d)" "${RENDER_FORMAT}"

    done
}
