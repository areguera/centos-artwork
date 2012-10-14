#!/bin/bash
#
# texinfo.sh -- This function initilializes Texinfo documentation
# format used by `centos-art.sh' script to produce and maintain
# documentation manuals written in Texinfo format, inside the working
# copy of The CentOS Artwork Repository.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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
    
function texinfo {

    # Verify documentation entry to be sure it coincides with
    # Texinfo's supported structuring (e.g., texinfo-4.8 doesn't
    # support structuring through parts, but chapters and sections
    # only).
    if [[ $MANUAL_PART_NAME != '' ]];then
        cli_printMessage "`gettext "The documentation entry provided isn't supported."`" --as-error-line
    fi

    # Verify documentation format based on file type.
    if [[ -f ${MANUAL_BASEFILE}.${MANUAL_EXTENSION} ]];then
        cli_checkFiles -i "text/x-texinfo" ${MANUAL_BASEFILE}.${MANUAL_EXTENSION}
    fi

    # Define absolute path to template directory. This is the place
    # where we store locale directories (e.g., en_US, es_ES, etc.)
    # used to build manuals in texinfo format.
    MANUAL_TEMPLATE=${MANUAL_TLDIR}/$(cli_getRepoName ${FLAG_FORMAT} -d)/Default

    # Define absolute path to language-specific template directory.
    # This is the place where we store locale-specific files used to
    # build manuals in texinfo format.
    MANUAL_TEMPLATE_L10N=${MANUAL_TEMPLATE}/${MANUAL_L10N}

    # Verify absolute path to language-specific template directory.
    # If it doesn't exist, use English language as default location to
    # retrieve template files.
    if [[ ! -d $MANUAL_TEMPLATE_L10N ]];then
        MANUAL_TEMPLATE_L10N=${MANUAL_TEMPLATE}/en_US
    fi

    # Initialize document structure for new manuals.
    texinfo_createStructure

    # Define documentation entry default values. To build the
    # documentation entry, we combine the manual's name, part, chapter
    # and section information retrieved from the command-line.
    if [[ $MANUAL_CHAPTER_NAME == '' ]];then

        # When chapter option is not provided, discard the section
        # name and define documentation entry based on manual's main
        # definition file.
        MANUAL_ENTRY="${MANUAL_BASEFILE}.${MANUAL_EXTENSION}"

    elif [[ $MANUAL_CHAPTER_NAME != '' ]] && [[ $MANUAL_SECTION_NAME == '' ]];then

        # When chapter option is provided without a section name,
        # verify chapter's directory inside the manual,
        texinfo_createChapter

        # and define documentation entry based on chapter's main
        # definition file.
        MANUAL_ENTRY="${MANUAL_BASEDIR_L10N}/${MANUAL_CHAPTER_NAME}/chapter.${MANUAL_EXTENSION}"

    elif [[ $MANUAL_CHAPTER_NAME != '' ]] && [[ $MANUAL_SECTION_NAME != '' ]];then

        # When both the chapter option and non-option arguments are
        # provided, define documentation entries based on manual,
        # chapter and non-option arguments.
        MANUAL_ENTRY="$(texinfo_getEntry "$MANUAL_SECTION_NAME")"

    else
        cli_printMessage "`gettext "The parameters you provided are not supported."`" --as-error-line
    fi

    # Execute action names. Notice that we've separated execution of
    # action names in order to control and save differences among
    # them.
    if [[ $ACTIONNAM == "" ]];then

        # When no action name is provided to `centos-art.sh' script,
        # read manual's info output in order to provide a way for
        # people to get oriented about The CentOS Artwork Repository
        # and its automation too. Be sure the manual and its info
        # output file do exist. Later, once the reading is done,
        # terminate the script execution.

        # Update manual's output files.
        texinfo_updateOutputFiles
            
        # Read manual's Top node from its info output file.
        info --node="Top" --file="${MANUAL_OUTPUT_BASEFILE}.info.bz2"

    elif [[ $ACTIONNAM =~ "^(copy|rename|delete)Entry$" ]];then

        # Both `--copy' and `--rename' actions interpret non-option
        # arguments passed to `centos-art.sh' script in a special way.
        # In this configuration, only two non-option arguments are
        # processed in the first loop of their interpretation.
        texinfo_${ACTIONNAM}

        # Rebuild output files to propagate recent changes, if any.
        texinfo_updateOutputFiles

        # Break interpretation of non-option arguments to prevent the
        # second and further non-option arguments from being
        # considered as source location.
        break

    else

        # Execute action names as part of normal help command's
        # execution flow, without any extra modification.
        texinfo_${ACTIONNAM}

    fi

}
