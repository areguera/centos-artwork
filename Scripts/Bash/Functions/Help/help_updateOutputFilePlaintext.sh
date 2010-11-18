#!/bin/bash
#
# help_updateOutputFilePlaintext.sh -- This function updates manuals'
# plaintext related output file.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function help_updateOutputFilePlaintext {

    # Output action message.
    cli_printMessage "`gettext "Updating manual's plaintext output"`" 'AsResponseLine'

    # Check plaintext output directory.
    [[ ! -d ${MANUALS_DIR[5]} ]] &&  mkdir -p ${MANUALS_DIR[5]}

    # Update plaintext output directory.
    /usr/bin/makeinfo ${MANUALS_FILE[1]} --output=${MANUALS_FILE[5]} \
        --plaintext \
        -I=/home/centos/artwork

}
