#!/bin/bash
#
# identity_getDirOutput.sh -- This function defines the final
# absolute path the centos-art.sh script uses to store identity
# contents produced at rendition time.
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

function identity_getDirOutput {

    # Define base output directory using design model path as reference.
    OUTPUT=$(dirname $FILE | sed -r \
        -e "s!/Models/${THEMEMODEL}!/Motifs/$(cli_getPathComponent "$ACTIONVAL" "--theme")!")

    # By default rendered identity content is stored immediatly under
    # identity entry structure,  but if `Img/' directory exists use it
    # instead.
    if [[ -d ${OUTPUT}/Img ]]; then
        OUTPUT=${OUTPUT}/Img
    fi

    # Redefine base output directory to introduce specific information
    # like release number, architecture, etc.
    OUTPUT=${OUTPUT}/${FLAG_RELEASE}/${FLAG_ARCHITECTURE}

    # Define whether to use or not locale-specific directory to store
    # content, using current locale information as reference. As
    # convenction, when we produce content in English language, we do
    # not add a laguage-specific directory to organize content.
    # However, when we produce language-specific content in a language
    # different from English we do use language-specific directory to
    # organize content.
    if [[ ! $(cli_getCurrentLocale) =~ '^en' ]];then
        OUTPUT=${OUTPUT}/$(cli_getCurrentLocale)
    fi

    # Remove two or more consecutive slashes as well as the last
    # remaining slash in the path.
    OUTPUT=$(echo $OUTPUT | sed -r 's!/{2,}!/!g' | sed -r 's!/$!!')

    # Create final output directory, if it doesn't exist yet.
    if [[ ! -d ${OUTPUT} ]];then
        mkdir -p ${OUTPUT}
    fi

}
