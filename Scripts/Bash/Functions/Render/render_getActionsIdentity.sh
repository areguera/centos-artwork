#!/bin/bash
#
# render_getActionsIdentity.sh -- This function initiates rendering
# configuration functions and executes them to perform the rendering
# action specified in the `ACTIONS' array variable. Function
# initialization and execution is based on the absolute path
# convenction defined by ARTCONF variable.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

function render_getActionsIdentity {

    # Define variables as local to avoid conflicts outside.
    local ARTCOMP=''

    # Define default theme model to use.  
    local THEMEMODEL='Default'

    # Define default artworks matching list. The artworks matching
    # list lets you customize how translation files are applied to
    # design templates. When matching list is empty (the default
    # value), translation files are applied to design templates
    # sharing the same name (without the extension). This produces one
    # translated design for each translation file available.
    # Matching list definitions where translation files need to be
    # applied to specific design templates are defined inside
    # artwork-specific pre-rendering configuration scripts.
    local MATCHINGLIST=''

    # Check current scripts path value. If scripts path points to a
    # directory which currently doesn't exist there is nothing to do
    # here, so leave a message quit script execution.
    if [[ ! -d $ARTCONF ]];then
        cli_printMessage "`gettext "The path provided can't be processed."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    for FILE in $(find $ARTCONF -name 'render.conf.sh');do

        # Output action message.
        cli_printMessage $FILE 'AsConfigurationLine'
        echo '----------------------------------------------------------------------'

        # Define artwork-specific action arrays. We need to do this
        # here because ACTIONS variable is unset after
        # render_doIdentityImages execution. Otherwise, undesired
        # concatenations may occur.
        local -a ACTIONS
        local -a BASEACTIONS
        local -a POSTACTIONS
        local -a LASTACTIONS
  
        # Initialize artwork-specific pre-rendering configuration
        # (function) scripts.
        . $FILE

        # Execute artwork-specific pre-rendering configuration
        # (function) scripts to re-define artwork-specific ACTIONS and
        # MATCHINGLIST variables. 
        render_loadConfig

        # Check variables passed from artwork-specific pre-rendering
        # configuration scripts and make required transformations.
        render_checkConfig

        # Redefine action value (ACTIONVAL) based on pre-rendering
        # configuration script path value. Otherwise, massive
        # rendering may fail. Functions like renderImage need to know
        # the exact artwork path (that is, where images will be
        # stored).
        ACTIONVAL=$(dirname $(echo $FILE | sed -r \
            -e 's!Scripts/Bash/Functions/Render/Config/Identity/!Identity/!' \
            -e "s!Themes/!Themes/Motifs/$(cli_getThemeName)/!"))

        # Redefine artwork identification.
        ARTCOMP=$(echo $ACTIONVAL | cut -d/ -f6-)

        # Remove motif name from artwork identification in order to
        # reuse motif artwork identification. There is not need to
        # create one artwork identification for each motif directory
        # structure if we can reuse just one.
        if [[ $ARTCOMP =~ "Themes/Motifs/$(cli_getThemeName)/" ]];then
            ARTCOMP=$(echo $ARTCOMP | sed -r "s!Themes/Motifs/$(cli_getThemeName)/!Themes/!")
        fi

        # Start rendering as defined in artwork-specific pre-rendering
        # configuration file.
        render_doIdentity

        # Unset artwork-specific actions so they can be redefined by
        # artwork-specific pre-rendering configuration scripts. This
        # is required in massive rendering. For example, if you say
        # centos-art.sh to render the whole Distro directory it first
        # renders Prompt entry, which defines the renderSyslinux
        # post-rendering action, and later Progress entry which does
        # not defines post-rendering actions. If we do not unset the
        # ACTIONS variable, post-rendering actions defined in Prompt
        # entry remain for Progress entry and that is not desired. We
        # want ACTIONS to do what we exactly tell it to do inside each
        # artwork-specific pre-rendering configuration script.
        unset ACTIONS
        unset BASEACTIONS
        unset POSTACTIONS
        unset LASTACTIONS

    done

}
