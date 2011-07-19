#!/bin/bash
#
# texinfo.sh -- This function initilializes the Texinfo documentation
# backend used by centos-art.sh script to produce and maintain Texinfo
# documentation manuals inside the working copy of The CentOS Artwork
# Repository.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------
    
function texinfo {

    # Define file extension used by source files inside manuals.
    MANUAL_EXTENSION='texinfo'

    # Define absolute path to chapter's directory. This is the place
    # where chapter-specific files are stored in.
    MANUAL_CHAPTER_DIR=${MANUAL_BASEDIR_L10N}/$(cli_getRepoName \
        "${MANUAL_CHAPTER_NAME}" -d | tr -d ' ' | sed -r 's!/$!!')

    # Define absolute path to template directory. This is the place
    # where we store locale directories (e.g., en_US, es_ES, etc.)
    # used to build manuals in texinfo format.
    MANUAL_TEMPLATE=${FUNCDIR}/${FUNCDIRNAM}/$(cli_getRepoName \
        ${FLAG_BACKEND} -d)/Templates

    # Define absolute path to language-specific template directory.
    # This is the place where we store locale-specific files used to
    # build manuals in texinfo format.
    MANUAL_TEMPLATE_L10N=${MANUAL_TEMPLATE}/${MANUAL_L10N}

    # Verify absolute path to language-speicific template directory.
    # If it doesn't exist, use English language as default location to
    # retrive template files.
    if [[ ! -d $MANUAL_TEMPLATE_L10N ]];then
        MANUAL_TEMPLATE_L10N=${MANUAL_TEMPLATE}/en_US
    fi

    # Initialize document structure of new manuals.
    ${FLAG_BACKEND}_createStructure

    # Define documentation entry default values. To build the
    # documentation entry, we combine the manual's name, the chapter's
    # name and the section name retrived from the command-line.
    if [[ $MANUAL_CHAPTER_NAME == '' ]];then

        # When chapter option is not provided, discard the section
        # name and define documentation entry based on manual's main
        # definition file.
        MANUAL_ENTRY="${MANUAL_BASEFILE}.${MANUAL_EXTENSION}"

    elif [[ $MANUAL_CHAPTER_NAME != '' ]] && [[ $MANUAL_SECTION_NAME == '' ]];then

        # When chapter option is provided whith out a section name,
        # verify chapter's directory inside the manual,
        ${FLAG_BACKEND}_createChapter

        # and define documentation entry based on chapter's main
        # definition file.
        MANUAL_ENTRY="${MANUAL_BASEDIR_L10N}/${MANUAL_CHAPTER_NAME}/chapter.${MANUAL_EXTENSION}"

    elif [[ $MANUAL_CHAPTER_NAME != '' ]] && [[ $MANUAL_SECTION_NAME != '' ]];then

        # When both the chapter option and non-option arguments are
        # provided, define documentation entries based on manual,
        # chapter and non-option arguments.
        MANUAL_ENTRY="$(${FLAG_BACKEND}_getEntry "$MANUAL_SECTION_NAME")"

    else
        cli_printMessage "`gettext "The parameters you provided are not supported."`" --as-error-line
    fi

    # Execute action names. Notice that we've separated execution of
    # action names in order to control and save differences among
    # them.
    if [[ $ACTIONNAM == "" ]];then

        # When no action name is provided to `centos-art.sh' script,
        # read manual's output in info format in order to provide a
        # way for people to get oriented about The CentOS Artwork
        # Repository and its automation tool, the centos-art.sh
        # script. Be sure the manual's output file does exist and
        # terminate the script execution once the reading is done.

        # Update manual's info output format.
        ${FLAG_BACKEND}_updateOutputFiles
            
        # Read Top node from manual's info output format.
        info --node="Top" --file=${MANUAL_BASEFILE}.info.bz2

        # Terminate script execution right here.
        exit

    elif [[ $ACTIONNAM =~ "^(copy|rename)Entry$" ]];then

        # Both `--copy' and `--rename' actions interpret non-option
        # arguments passed to `centos-art.sh' script in a special way.
        # In this configuration, only two non-option arguments are
        # used and interpreted from the first loop of their
        # interpretation.
        ${FLAG_BACKEND}_${ACTIONNAM}

        # Break interpretation of non-option arguments, to prevent the
        # second non-option argument from be considered a source
        # location.
        break

    elif [[ $ACTIONNAM =~ "^(search(Node|Index)|updateOutputFiles)$" ]];then

        # The two final actions of help functionality are precisely to
        # update manual output files and commit all changes from
        # working copy to central repository. In this situation, when
        # the `--update' action name is provided to `centos-art.sh',
        # don't duplicate the rendition of manual output files (e.g.,
        # one as action name and another as help's normal execution
        # flow) nor commit any change form working copy to central
        # repository (e.g., output files are not under version
        # control).
        ${FLAG_BACKEND}_${ACTIONNAM}

        # Terminate script execution right here. Actions realized in
        # this configuration doesn't need to update manual output
        # files, nor commit changes from working copy up to central
        # repository.
        exit

    else

        # Execute action names that follow help's execution flow as it
        # is, without any modification.
        ${FLAG_BACKEND}_${ACTIONNAM}

    fi

}
