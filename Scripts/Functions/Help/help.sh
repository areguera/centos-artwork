#!/bin/bash
#
# help.sh -- This function initializes the interface used by
# centos-art.sh script to perform documentation tasks through
# different documentation backends.
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
    
function help {

    # Initialize action name with an empty value.
    local ACTIONNAM=''

    # Initialize search option (`--search'). This option is used to
    # look for documentation inside documentation backends.
    local FLAG_SEARCH=""

    # Initialize manual's language.
    local MANUAL_L10N=$(cli_getCurrentLocale)

    # Initialize manuals's top-level directory. This is the place
    # where the manual will be stored in. To provide flexibility, the
    # current directory where the `centos-art.sh' script was called
    # from is used as manual's top-level directory.  Notice that this
    # relaxation is required because we need to create/maintain
    # manuals both under `trunk/Manuals/' and `branches/Manuals/'
    # directories.
    local MANUAL_TLDIR=${PWD}

    # Verify manual's top-level directory. To prevent messing the
    # things up, we need to restrict the possible locations
    # where documentation manuals can be created in the working copy.
    # When manual's top-level location is other but the ones
    # permitted, use `trunk/Manuals' directory structure as default
    # location to store documentation manuals.
    if [[ ! $MANUAL_TLDIR =~ "^${CLI_WRKCOPY}/(trunk/Manuals|branches/Manuals/[[:alnum:]-]+)$" ]];then
        MANUAL_TLDIR="${CLI_WRKCOPY}/trunk/Manuals"
    fi

    # Initialize documentation entries arrays. Arrays defined here
    # contain all the information needed to process documentation
    # entries (e.g., manual, chapter, section).
    local -a MANUAL_SLFN
    local -a MANUAL_DIRN
    local -a MANUAL_CHAN
    local -a MANUAL_SECN

    # Initialize documentation entries counter.
    local MANUAL_DOCENTRY_COUNT=0
    local MANUAL_DOCENTRY_ID=0

    # Interpret option arguments passed through the command-line.
    ${CLI_FUNCNAME}_getOptions

    # Redefine arrays related to documentation entries using
    # non-option arguments passed through the command-line. At this
    # point all options have been removed from ARGUMENTS and
    # non-option arguments remain. Evaluate ARGUMENTS to retrive the
    # information related documentation entries from there.
    ${CLI_FUNCNAME}_getEntries

    # Execute backend-specific documentation tasks for each
    # documentation entry specified in the command-line, individually.
    # Notice that we've stored all documentation entries passed as
    # non-option arguments in array variables in order to process them
    # now, one by one.  This is particularily useful when we need to
    # reach items in the array beyond the current iteration cycle. For
    # example, when we perform actions that require source and target
    # locations (e.g., copying and renaming): we use the current value
    # as source location and the second value in the array as target
    # location; both defined from the first iteration cycle.
    while [[ $MANUAL_DOCENTRY_ID -lt $MANUAL_DOCENTRY_COUNT ]];do

        # Define name used by manual's main definition file.
        MANUAL_NAME=${MANUAL_SLFN[${MANUAL_DOCENTRY_ID}]}

        # Define absolute path to directory holding language-specific
        # directories.
        MANUAL_BASEDIR="${MANUAL_TLDIR}/${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]}"

        # Define absolute path to directory holding language-specific
        # texinfo source files.
        MANUAL_BASEDIR_L10N="${MANUAL_BASEDIR}/${MANUAL_L10N}"

        # Define absolute path to changed directories inside the
        # manual. For example, when a section entry is edited, copied
        # or renamed inside  the same manual there is only one
        # aboslute path to changed directory to look for changes, the
        # one holding the section entry.  However, when a manual entry
        # is renamed, there are two different locations to look for
        # changes, the source manual removed and the target manual
        # added.
        MANUAL_CHANGED_DIRS="${MANUAL_BASEDIR_L10N}"

        # Define absolute path to base file. This is the main file
        # name (without extension) we use as reference to build output
        # files in different formats (.info, .pdf, .xml, etc.).
        MANUAL_BASEFILE="${MANUAL_BASEDIR_L10N}/${MANUAL_NAME}"

        # Define chapter name.
        MANUAL_CHAPTER_NAME=${MANUAL_CHAN[${MANUAL_DOCENTRY_ID}]}

        # Define absolute path to chapter's directory. This is the
        # place where chapter-specific files are stored in.
        MANUAL_CHAPTER_DIR="${MANUAL_BASEDIR_L10N}/${MANUAL_CHAPTER_NAME}"

        # Define section name.
        MANUAL_SECTION_NAME=${MANUAL_SECN[${MANUAL_DOCENTRY_ID}]}

        # Define absolute path to manual's configuration file.  This
        # is the file that controls the way template files are applied
        # to documentation entries once they have been created as well
        # as the style and order used for printing sections. 
        MANUAL_CONFIG_FILE="${MANUAL_BASEFILE}.conf" 

        # Define documentation backend. This information defines the
        # kind of source files we work with inside the documentation
        # manual as well as the kind of actions required by them to
        # perform actions related to document management (e.g.,
        # creation, edition, deletion, copying, renaming, etc.).
        if [[ -f ${MANUAL_CONFIG_FILE} ]];then

            # Retrive documentation backend from configuration file.
            MANUAL_BACKEND=$(cli_getConfigValue \
                "${MANUAL_CONFIG_FILE}" "main" "manual_backend")

            # Verify documentation backend. This is required because
            # in order to prevent malformed values from being used. Be
            # sure only supported documentation backends could be
            # provided as value to `manual_backend' option in
            # configuration files.
            if [[ ! $MANUAL_BACKEND =~ '^(texinfo)$' ]];then
                cli_printMessage "`gettext "The documentation backend provided isn't supported."`" --as-error-line
            fi 

        else

            # When the current documentation manual is being created
            # for first time, there's no way to get the documentation
            # backend to use in the future manual, but asking the user
            # creating it which one to use.
            cli_printMessage "`gettext "Select one of the following documentation backends:"`"
            MANUAL_BACKEND=$(cli_printMessage "texinfo" --as-selection-line)

        fi

        # Define file extension used by source files inside manuals.
        MANUAL_EXTENSION="${MANUAL_BACKEND}"

        # Define absolute path to template directory. This is the
        # place where we store locale directories (e.g., en_US, es_ES,
        # etc.) used to build manuals in texinfo format.
        MANUAL_TEMPLATE=${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}/$(cli_getRepoName \
            ${MANUAL_BACKEND} -d)/Templates

        # Define absolute path to language-specific template
        # directory.  This is the place where we store locale-specific
        # files used to build manuals in texinfo format.
        MANUAL_TEMPLATE_L10N=${MANUAL_TEMPLATE}/${MANUAL_L10N}

        # Verify absolute path to language-speicific template
        # directory.  If it doesn't exist, use English language as
        # default location to retrive template files.
        if [[ ! -d $MANUAL_TEMPLATE_L10N ]];then
            MANUAL_TEMPLATE_L10N=${MANUAL_TEMPLATE}/en_US
        fi

        # Notice that, because we are processing non-option arguments
        # one by one, there is no need to sycronize changes or
        # initialize functionalities to the same manual time after
        # time (assuming all documentation entries passed as
        # non-option arguments refer the same manual directory name).
        # That would be only necessary when documentation entries
        # refer to different manual directory names that could be
        # written in different documentation backends.
        if [[ ${MANUAL_DOCENTRY_ID} -eq 0 \
            || ( ( ${MANUAL_DOCENTRY_ID} -gt 0 ) && ( \
            ${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]} != ${MANUAL_DIRN[((${MANUAL_DOCENTRY_ID} - 1))]} ) ) ]];then

            # Syncronize changes between repository and working copy.
            # At this point, changes in the repository are merged in
            # the working copy and changes in the working copy
            # committed up to repository.
            if [[ -d ${MANUAL_CHANGED_DIRS} ]];then
                cli_syncroRepoChanges ${MANUAL_CHANGED_DIRS}
            fi

            # Initialize documentation backend functionalities. At
            # this point we load all functionalities required into
            # `centos-art.sh''s execution environment and make them
            # available, this way, to perform backend-specific
            # documentation tasks.
            cli_exportFunctions "${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}/$(cli_getRepoName \
                ${MANUAL_BACKEND} -d)" "${MANUAL_BACKEND}"

        fi

        # Execute backend-specific documentation tasks.
        ${MANUAL_BACKEND}

        # Unset the exported functions before go on with the next
        # documentation entry provided as non-option argument to
        # `centos-art.sh' script. Different documentation entries may
        # be written in different documentation backends. Each
        # documentation backend is loaded in order to perform their
        # related documentation tasks. Assuming more that one
        # documentation entry be passed as non-option argument to
        # `centos-art.sh' script and they are written in different
        # formats, we might end up loading documentation backend
        # functionalities that aren't used in the current
        # documentation entry being processed. In that sake, unset
        # documentation bakend functionalities when the next
        # documentation entry refers to a manual directory different
        # to that one being currently processed.
        if [[ ${MANUAL_DOCENTRY_ID} -gt 0 \
            && ${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]} != ${MANUAL_DIRN[((${MANUAL_DOCENTRY_ID} + 1))]} ]];then
            cli_unsetFunctions "${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}/$(cli_getRepoName \
                ${MANUAL_BACKEND} -d)" "${MANUAL_BACKEND}"
        fi

        # Increment documentation entry counter id.
        MANUAL_DOCENTRY_ID=$(($MANUAL_DOCENTRY_ID + 1))

    done

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncroRepoChanges ${MANUAL_CHANGED_DIRS}

}
