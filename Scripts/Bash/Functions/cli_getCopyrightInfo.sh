#!/bin/bash
#
# cli_getCopyrightInfo.sh -- This function outputs copyright
# information based on action value (ACTIONVAL) variable.
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

function cli_getCopyrightInfo {

    # Define default copyright information.
    local COPYRIGHT="Copyright © 2003-$(date +%Y) The CentOS Project. All rights reserved."

    # When the concept directory structure of an artistic motif is
    # rendered, redefine copyright information printed on images to
    # reflect the fact that authors of artistic motifs own the
    # creation rights of the artistic motif. We want to motivate
    # people to produce more artistic motifs, so they should have the
    # creation rights of artistic motifs they create and also know
    # that fact. 
    # 
    # In order for an artistic motif to store under CentOS Artwork
    # Repository, the author of the artistic motif needs to agree the
    # terms of the license The CentOS Project set for the CentOS
    # artistic motifs to have.  Otherwise, The CentOS Project should
    # reject that artistic motif from being stored under CentOS
    # Artwork Repository.
    if [[ $ACTIONVAL =~ "$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getThemeName)/Concept" ]];then

        # Define path to file containing artistic motifs authors
        # copyright information.
        local AUTHORS="$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getThemeName)/authors.txt"

        # Verify file containing artistic motifs authors' copyright
        # information and redefine default copyright information to
        # use authors' copyright information instead.
        if [[ -f $AUTHORS ]];then
            COPYRIGHT="$(cat $AUTHORS)"
        fi
        
    fi

    # Print copyright information.
    echo $COPYRIGHT

}
