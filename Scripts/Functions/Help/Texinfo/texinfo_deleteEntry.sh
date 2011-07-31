#!/bin/bash
#
# texinfo_deleteEntry.sh -- This function removes a documentation
# manuals, chapters or sections from the working copy.
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

function texinfo_deleteEntry {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Remove manual, chapter or section based on documentation entry
    # provided as non-option argument to `centos-art.sh' script.  
    if [[ ${MANUAL_SECN[$MANUAL_DOCENTRY_ID]} != '' ]];then

        # When a section is deleted, documentation entry points to a
        # section name. In this configuration, documentation entry is
        # deleted through subversion in order to register the change.
        # Once the documentation entry is deleted, the section menu
        # and nodes definition files are updated to keep manual in a
        # consistent state.
        ${FLAG_BACKEND}_deleteEntrySection

    elif [[ ${MANUAL_CHAN[$MANUAL_DOCENTRY_ID]} != '' ]];then

        # When a chapter is deleted, documentation entry doesn't point
        # to a section name but a chapter name. In this configuration,
        # it is necessary to build a list of all the section entries
        # available inside the chapter before deleting it. Once the
        # chapter has been marked for deletion, it is time to update
        # chapter definition files and later section definition files
        # using the list of section entries previously defined.
        # Actualization of section definition files must be done one
        # at a time because menu entries related to section
        # definitions are updated one at a time.
        ${FLAG_BACKEND}_deleteEntryChapter

    elif [[ ${MANUAL_DIRN[$MANUAL_DOCENTRY_ID]} != '' ]];then

        # When a manual is deleted, documentation entry doesnt' point
        # to either a section or chapter but a manual name only. In
        # this configuration the entire manual directory is marked for
        # deletion, and that way processed.
        ${FLAG_BACKEND}_deleteEntryManual

    else
        cli_printMessage "`gettext "The parameters you provided are not supported."`" --as-error-line
    fi


}
