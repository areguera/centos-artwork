#!/bin/bash
#
# render_getIdentityDirOutput.sh -- This function defines the absolute
# directory path of identity contents final output. This is, the place
# where content produced will be stored in.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function render_getIdentityDirOutput {

    # Define base output directory. By default rendered identity
    # artworks are stored immediatly under identity entry structure.
    # But if Img/ or Txt/ directory exists, use it instead.
    if [[ -d ${ACTIONVAL}/Img ]]; then
        OUTPUT=${ACTIONVAL}/Img
    elif [[ -d ${ACTIONVAL}/Txt ]]; then
        OUTPUT=${ACTIONVAL}/Txt
    else
        OUTPUT=${ACTIONVAL}
    fi

    # Define final output directory. As convenction, when we produce
    # content in English language, we do not add a laguage-specific
    # directory to organize content.  However, when we produce content
    # in a language different from English we do use language-specific
    # directory to organize content.
    if [[ $(cli_getCurrentLocale) =~ '^en' ]];then
        OUTPUT=${OUTPUT}/$(dirname "${FILE}")
    else
        OUTPUT=${OUTPUT}/$(dirname "${FILE}")/$(cli_getCurrentLocale)
    fi

    # Remove leading `/.' string from path to final output directory.
    OUTPUT=$(echo ${OUTPUT} | sed -r 's!/\.!!')

    # Create final output directory, if it doesn't exist yet.
    if [[ ! -d ${OUTPUT} ]];then
        mkdir -p ${OUTPUT}
    fi

}
