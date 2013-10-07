#!/bin/bash
######################################################################
#
#   locale_getFilesList.sh -- This function prints to standard output
#   the list of files that locale module will use for processing. The
#   list of files is conditioned by the LOCALE_FLAG_TYPE variable to
#   determine whether the processing is applied to one file, all files
#   in a directory only or all files in a directory recursively. By
#   default one file processing is performed.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function locale_getFilesList {

    if [[ ${LOCALE_FLAG_SIBLINGS} == 'true' ]];then

        # Process all files in the current location only.
        tcar_getFilesList ${DIRECTORY} --maxdepth=1 --mindepth=1 \
            --type="f" --pattern="^.+/.+\.${FILE_EXTENSION}$"

    elif [[ ${LOCALE_FLAG_ALL} == 'true' ]];then

        # Process all files in the current location recursively.
        tcar_getFilesList ${DIRECTORY} --type="f" --pattern="^.+/.+\.${FILE_EXTENSION}$"


    else

        # Process the file provided only.
        tcar_getFilesList ${DIRECTORY} --maxdepth=1 --mindepth=1 \
            --type="f" --pattern="^.+/${FILE_NAME}$"

    fi

}
