#!/bin/bash
#
# locale_updateMessageXmlSvg.sh -- This function parses XML-based
# files (e.g., scalable vector graphics), retrieves translatable
# strings and creates/update gettext portable objects.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function locale_updateMessageXmlSvg {

    # Inside `Identity/Models' and Documentation/Models/Svg/, design
    # models can be compressed or uncompressed. Because of this we
    # cannot process all the design models in one unique way. Instead,
    # we need to treat them individually based on their file type.

    local DIR=''
    local DIRS=''

    # Define regular expression to match extensions of shell scripts
    # we use inside the repository.
    local EXTENSION='(svgz|svg)'

    # Build list of directories in which we want to look files for.
    local DIRS=$(cli_getFilesList ${ACTIONVAL} \
        --pattern="${ACTIONVAL}/${FLAG_FILTER}")

    # Process list of directories, one by one.
    for DIR in $DIRS;do

        # Reset information related to temporal files.
        local TEMPFILE=''
        local TEMPFILES=''

        # Redefine localization working directory using the current
        # directory. The localization working directory is the place
        # where POT and PO files are stored inside the working copy.
        local L10N_WORKDIR=$(cli_getLocalizationDir "${DIR}")

        # Prepare working directory to receive translation files.
        locale_prepareWorkingDirectory ${L10N_WORKDIR}

        # Redefine final location of messages.po file, based on
        # current directory.
        MESSAGES=${L10N_WORKDIR}/messages

        # Build list of files we want to work with.
        FILES=$(cli_getFilesList ${DIR} --pattern="${DIR}/.+\.${EXTENSION}")

        for FILE in $FILES;do

            # Redefine temporal file based on file been processed.
            TEMPFILE=$(cli_getTemporalFile $(basename ${FILE}))

            # Update the command used to read content of XML files.
            if [[ $(file -b -i $FILE) =~ '^application/x-gzip$' ]];then
        
                # Create uncompressed copy of file.
                /bin/zcat $FILE > $TEMPFILE

            else
                
                # Create uncompressed copy of file.
                /bin/cat $FILE > $TEMPFILE

            fi

            # Concatenate temporal files into a list so we can process
            # them later through xml2po, all at once.
            TEMPFILES="${TEMPFILE} ${TEMPFILES}"

        done

        # Create the portable object template.
        cat $TEMPFILES | xml2po -a -l ${CLI_LANG_LC} - \
            | msgcat --output=${MESSAGES}.pot --width=70 --no-location -

        # Verify, initialize or merge portable objects from portable
        # object templates.
        locale_updateMessagePObjects "${MESSAGES}"

    done

}
