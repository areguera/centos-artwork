#!/bin/bash
#
# render_loadConfig.sh -- This function defines widgets pre-rendering
# configuration script.
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
# $Id$
# ----------------------------------------------------------------------

function render_loadConfig {

    # Define rendering actions.
    ACTIONS[0]='BASE:renderImage'

    # Define matching list.
    MATCHINGLIST="\
    poweredby.svg: \
        poweredby-1.sed poweredby-2.sed poweredby-3.sed\
        poweredby-4.sed poweredby-5.sed poweredby-6.sed
    icon-arrow.svg: \
        icon-arrow-right-blue.sed\
        icon-arrow-right-green.sed\
        icon-arrow-right-orange.sed\
        icon-arrow-right-violet.sed\
        icon-arrow-right-red.sed\
        icon-arrow-right.sed
    icon-admonition-alert.svg:      icon-admonition-alert.sed
    icon-admonition-info.svg:       icon-admonition-info.sed
    icon-admonition-attention.svg:  icon-admonition-attention.sed
    icon-admonition-download.svg:   icon-admonition-download.sed
    icon-admonition-error.svg:      icon-admonition-error.sed
    icon-admonition-star.svg:       icon-admonition-star.sed
    icon-admonition-svn.svg:        icon-admonition-svn.sed
    icon-admonition-idea.svg:       icon-admonition-idea.sed
    icon-admonition-doc-old.svg:      icon-admonition-doc-old.sed
    icon-admonition-doc-redirect.svg: icon-admonition-doc-redirect.sed
    icon-admonition-success.svg: icon-admonition-success.sed
    "
}
