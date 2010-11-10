#!/bin/bash
#
# render_loadConfig.sh -- This function defines Anaconda progress
# pre-rendering configuration script.
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

function render_loadConfig {

    # Define rendering actions.
    ACTIONS[0]='BASE:renderImage'

    # Define matching list.
    MATCHINGLIST="\
    first-lowres.svg:\
       first-lowres.sed\
        progress_first-lowres.sed
    first.svg:\
        first.sed\
        progress_first.sed
    paragraph.svg:\
        01-welcome.sed\
        02-donate.sed\
        03-yum.sed\
        04-repos.sed\
        05-centosplus.sed\
        06-support.sed\
        08-wiki.sed\
        09-virtualization.sed
    list.svg:\
        07-docs.sed
        "

    # Deifne theme model.
    #THEMEMODEL='Default'

}
