#!/bin/bash
#
# help_updateOutputFilePlaintext.sh -- This function exports
# documentation manual to plain-text format.
#
# Copyright (C) 2009-2011 The CentOS Project
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

function help_updateOutputFilePlaintext {

    # Output action message.
    cli_printMessage "${MANUAL_BASEFILE}.txt.bz2" 'AsUpdatingLine'

    # Update plaintext output directory.
    /usr/bin/makeinfo --plaintext \
        ${MANUAL_BASEFILE}.texi --output=${MANUAL_BASEFILE}.txt

    # Compress plaintext output file.
    if [[ -f ${MANUAL_BASEFILE}.txt ]];then
        bzip2 ${MANUAL_BASEFILE}.txt --force
    fi

}
