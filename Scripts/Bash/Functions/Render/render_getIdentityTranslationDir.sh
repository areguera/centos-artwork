#!/bin/bash
#
# render_getIdentityTranslationDir.sh -- This function re-defines
# absolute path to artwork's related translation entry.  Be sure there
# is at least one translation file inside it.  Otherwise consider
# artwork's translation entry as empty.  
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id: render_getIdentityTranslationDir.sh 53 2010-09-17 10:51:42Z al $
# ----------------------------------------------------------------------

function render_getIdentityTranslationDir {

    TRANSLATIONPATH=${REPO_PATHS[5]}/$ARTCOMP

    if [[ "$(find $TRANSLATIONPATH -name '*.sed')" == '' ]];then
        TRANSLATIONPATH=''
    fi

}
