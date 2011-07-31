#!/bin/bash
#
# render.sh -- This function initializes rendition variables and
# actions to centos-art.sh script.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function render {

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize `--releasever' option. The release version option
    # controls the release number used to produce release-specific
    # content.  By default no release number is used.
    local FLAG_RELEASEVER=''

    # Initialize `--basearch' option. The base architecture option
    # controls the architecture type used to produce
    # architecture-specific content. By default no architecture type
    # is used.
    local FLAG_BASEARCH=''

    # Initialize `--theme-model' option. The theme model option
    # specifies the the theme model name used to produce theme
    # artistic motifs.
    local FLAG_THEME_MODEL='Default'

    # Initialize `--post-rendition' option. This option defines what
    # command to use as post-rendition. Post-rendition takes palce
    # over base-rendition output.
    local FLAG_POSTRENDITION=''

    # Initialize `--last-rendition' option. This option defines what
    # command to use as last-rendition. Last-rendition takes palce
    # once both base-rendition and post-rendition has been performed
    # in the same directory structure.
    local FLAG_LASTRENDITION=''

    # Initialize `--dont-dirspecific' option. This option can take two
    # values only (e.g., `true' or `false') and controls whether to
    # perform or not directory-specific rendition.  Directory-specific
    # rendition may use any of the three types of renditions (e.g.,
    # base-rendition, post-rendition and last-rendition) to accomplish
    # specific tasks when specific directory structures are detected
    # in the rendition flow. By default, the centos-art.sh script
    # performs directory-specific rendition.
    local FLAG_DONT_DIRSPECIFIC='false'

    # Initialize `--with-brands' option. This option controls whether
    # to brand output images or not. By default output images are not
    # branded.
    local FLAG_WITH_BRANDS='false'

    # Initialize name of rendition backend as an empty value. The name
    # of rendition backend is determined automatically based on
    # template file extension, later, at rendition time. 
    local RENDER_BACKEND=''

    # Initialize absolute path to backend's base directory, the place
    # where backend-specific directories are stored in.
    local RENDER_BACKEND_DIR="${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}"

    # Initialize list of supported file extensions. These file
    # extensions are used by design model files, the files used as
    # base-rendition input. In order for design model files to be
    # correclty rendered, they must end with one of the file
    # extensions listed here.
    local RENDER_EXTENSIONS='svg docbook'

    # Interpret arguments and options passed through command-line.
    ${CLI_FUNCNAME}_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action value. We use non-option arguments to define the
    # action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do
        
        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        ACTIONVAL=$(cli_checkRepoDirSource "$ACTIONVAL")

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges

        # Define renderable directories and the way they are produced.
        # To describe the way renderable directories are produced, we
        # take the action value (ACTIONVAL) as reference and describe
        # the production through an action name (ACTIONNAM).
        if [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Identity/Images/Themes" ]];then
            ACTIONNAM="${CLI_FUNCNAME}_doThemeActions"
        elif [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Identity/Images" ]];then
            ACTIONNAM="${CLI_FUNCNAME}_doBaseActions"
        elif [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Manuals" ]];then
            ACTIONNAM="${CLI_FUNCNAME}_doBaseActions"
        else
            cli_printMessage "`gettext "The path provided does not support rendition."`" --as-error-line
        fi

        # Execute action name.
        ${ACTIONNAM}

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges

    done

}
