#!/bin/bash
#
# identity_render.sh -- This function initiates rendition
# configuration functions and executes them to perform the rendition
# action specified in the `ACTIONS' array variable. Function
# initialization and execution is based on the absolute path
# convenction defined by ARTCONF variable.
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

function identity_render {

    local FILE=''

    # Initialize artwork identification.
    local ARTCOMP=''

    # Define default theme model.
    local THEMEMODEL='Default'

    # Build list of files to process.
    local FILES=$(cli_getFilesList "$ARTCONF" ".*/?render\.conf\.sh")

    # Set action preamble.
    cli_printActionPreamble "$FILES" '' ''

    # Process list of files.
    for FILE in $FILES;do

        # Print separator line.
        cli_printMessage '-' 'AsSeparatorLine'

        # Output action message.
        cli_printMessage $FILE 'AsConfigurationLine'

        # Define artwork-specific action arrays. We need to do this
        # here because ACTIONS variable is unset after
        # identity_renders execution. Otherwise, undesired
        # concatenations may occur.
        local -a ACTIONS
        local -a POSTACTIONS
        local -a LASTACTIONS
  
        # Initialize artwork-specific pre-rendition configuration
        # (function) scripts.
        . $FILE

        # Execute artwork-specific pre-rendition configuration
        # (function) scripts to re-define artwork-specific ACTIONS.
        identity_loadConfig

        # Check variables passed from artwork-specific pre-rendition
        # configuration scripts and make required transformations.
        identity_getConfig

        # Redefine action value (ACTIONVAL) based on pre-rendition
        # configuration script path value. Otherwise, massive
        # rendition may fail. Functions like renderImage need to know
        # the exact artwork path (that is, where images will be
        # stored).
        ACTIONVAL=$(dirname $(echo $FILE | sed -r \
            -e 's!/Scripts/Bash/Cli/Functions/Identity/Config/(Identity)!/\1!' \
            -e "s!/Themes!/Themes/Motifs/$(cli_getPathComponent '--theme')!" ))

        # Redefine artwork identification using redefined action
        # value.
        ARTCOMP=$(echo $ACTIONVAL | cut -d/ -f6-)

        # Remove motif name from artwork identification in order to
        # reuse motif artwork identification. There is not need to
        # create one artwork identification for each motif directory
        # structure if we can reuse just one.
        ARTCOMP=$(echo $ARTCOMP \
            | sed -r "s!Themes/Motifs/$(cli_getPathComponent '--theme')/!Themes/!")

        # Initiate base rendition using pre-rendition configuration
        # files.
        identity_renderBase

        # Unset artwork-specific actions so they can be redefined by
        # artwork-specific pre-rendition configuration scripts. This
        # is required in massive rendition. For example, if you say
        # centos-art.sh to render the whole Distro directory it first
        # renders Prompt entry, which defines the renderSyslinux
        # post-rendition action, and later Progress entry which does
        # not defines post-rendition actions. If we do not unset the
        # ACTIONS variable, post-rendition actions defined in Prompt
        # entry remain for Progress entry and that is not desired. We
        # want ACTIONS to do what we exactly tell it to do inside each
        # artwork-specific pre-rendition configuration script.
        unset ACTIONS
        unset POSTACTIONS
        unset LASTACTIONS

    done

}
