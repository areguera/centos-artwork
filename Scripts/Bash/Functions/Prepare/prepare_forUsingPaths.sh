#!/bin/bash
#
# prepare_forUsingPaths.sh -- This function verifies centos-art.sh
# required paths existence. If there is any missing path, leave a
# message and quit script execution.
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
# $Id: prepare_forUsingPaths.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function prepare_forUsingPaths {

    # Output action message.
    cli_printMessage "`gettext "Directories and files"`" "AsHeadingLine"

    # Define variables as local to avoid conflicts outside.
    local DIRECTORY=''

    # Check centos user's home directory.
    cli_printMessage "${REPO_PATHS[0]}" "AsResponseLine"
    if [[ ! -d ${REPO_PATHS[0]} ]];then
        cli_printMessage "`gettext "The following directory doesn't exist:"`"
        cli_printMessage "${REPO_PATHS[0]}" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to create the directory now?"`" "AsYesOrNoRequestLine"
        eval sudo useradd centos
        eval sudo passwd centos
    fi

    # Check centos user's bin directory.
    cli_printMessage "${REPO_PATHS[1]}" "AsResponseLine"
    if [[ ! -d ${REPO_PATHS[1]} ]];then
        cli_printMessage "`gettext "The following directory doesn't exist:"`"
        cli_printMessage "${REPO_PATHS[1]}" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to create the directory now?"`" "AsYesOrNoRequestLine"
        eval mkdir ${REPO_PATHS[1]}
    fi

    # Check centos-art.sh invocation link.
    cli_printMessage "${REPO_PATHS[2]}" "AsResponseLine"
    if [[ ! -h ${REPO_PATHS[2]} ]];then
        cli_printMessage "`gettext "The following symbolic link doesn't exist:"`"
        cli_printMessage "${REPO_PATHS[2]}" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to create the link now?"`" "AsYesOrNoRequestLine"

        # Check centos-art.sh script file before creating its
        # invocation link.
        cli_printMessage "${REPO_PATHS[3]}" "AsResponseLine"
        if [[ -f ${REPO_PATHS[3]} ]];then
            eval ln -fs ${REPO_PATHS[3]} ${REPO_PATHS[2]}
        else
            cli_printMessage "`gettext "The following file doesn't exist:"`"
            cli_printMessage "${REPO_PATHS[3]}" "AsResponseLine"
            cli_printMessage "trunk/Scripts/Bash/Functions/Prepare --filter='prepare_forUsingPaths.sh" "AsToKnowMoreLine"
        fi
    fi

    # Check user's fonts directory. In order for some artworks to be
    # rendered correctly, denmark font needs to be available. By
    # default, denmark font doesn't come with CentOS distribution so
    # create a symbolic link (from the one we have inside repository)
    # to make it available if it isn't yet.
    if [[ ! -d ${REPO_PATHS[6]} ]];then
        cli_printMessage "`gettext "The following directory doesn't exist:"`"
        cli_printMessage "${REPO_PATHS[6]}" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to create the directory now?"`" "AsYesOrNoRequestLine"
        mkdir ${REPO_PATHS[6]}
    fi
    if [[ ! -f ${REPO_PATHS[6]}/denmark.ttf ]];then
        if [[ ! -h ${REPO_PATHS[6]}/denmark.ttf ]];then
            cli_printMessage "`gettext "The following file doesn't exist:"`"
            cli_printMessage "${REPO_PATHS[6]}/denmark.ttf" "AsResponseLine"
            cli_printMessage "`gettext "Do you want to create the link now?"`" "AsYesOrNoRequestLine"
            ln -sf ${REPO_PATHS[7]}/denmark.ttf ${REPO_PATHS[6]}/denmark.ttf
        fi
    fi

    cli_printMessage "`gettext "Permissions"`" "AsHeadingLine"

    # Reset script files permissions. This is to be sure script files
    # are using the correct file permissions. Otherwise some script
    # may not be loaded.
    cli_printMessage "${REPO_PATHS[4]}" "AsResponseLine"
    eval "chmod -R 755 ${REPO_PATHS[4]}"
    eval "chown -R $USER:$USER ${REPO_PATHS[4]}"

}
