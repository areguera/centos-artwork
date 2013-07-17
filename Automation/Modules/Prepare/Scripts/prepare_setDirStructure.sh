#!/bin/bash
######################################################################
#
#   prepare_setDirStructure.sh -- This function standardizes the
#   relation between source and target directory structures inside the
#   repository.
#
#   This function takes two arguments. The first is the source
#   directory and the second is the target directory where you wan to
#   reproduce the source directory structure.  In order for this to
#   work, all source directory structures provided to this function
#   must have one level of directories more than its related target
#   directory.  The purpose of this level is content categorization.
#   For example, consider the following path:
#
#       ----------++++++++++++++++++++++++
#       ${SOURCE}/${CATEGORY}/${COMPONENT}
#       ----------++++++++++++++++++++++++
#       +++++++++++++++++++++++++++++------------
#       ${TARGET}/${NAME}/${VERSION}/${COMPONENT}
#       +++++++++++++++++++++++++++++------------
#
#   So we end with the following path:
#
#       ${TARGET}/${CATEGORY}/${COMPONENT}
# 
#   In this path, ${CATEGORY} makes reference to a categorization
#   directory used to describe source components related to target
#   components. However, in the target side, such ${CATEGORY}
#   directory is not needed and should be removed from it in order to
#   get the final target path, which is:  
#
#       ${TARGET}/${COMPONENT}
#
#   ${CATEGORY} is always a one-level directory, but ${COMPONENT}
#   might have several levels deep inside.
#
# Copyright (C) 2009-2013 The CentOS Project
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
######################################################################

function prepare_setDirStructure {

    # Define absolute path to design models' directory structure. This
    # directory contains the directory structure you want to verify
    # inside target path.
    local SOURCE_DIRECTORY=$(tcar_checkRepoDirSource "${1}")

    # Verify existence source path, just to be sure it was passed and
    # it is a valid directory.
    tcar_checkFiles ${SOURCE_DIR} -d

    # Define absolute path to directory inside the repository where
    # you want to replicate the source path directory structure.
    local TARGET_DIRECTORY=$(tcar_checkRepoDirSource "${2}")

    # NOTE: It is possible that target path doesn't exist. So verify
    # the relation between target and source path. If there is a
    # source path for the target, create an empty directory as target,
    # using the related source directory as reference.

    # Define list of directories inside source path.
    local DIRECTORIES=$(tcar_getFilesList ${SOURCE_DIRECTORY} \
        --pattern='.+/[[:alpha:]]+$' --type='d')

    # Iterate through directories inside source path and verify
    # whether or not they exist in the target path. If they don't
    # exist create them.
    for DIRECTORY in ${DIRECTORIES};do

        local DIRECTORY_BASENAME=$(echo ${DIRECTORY} \
            | sed -r "s,${SOURCE_DIRECTORY}/,,")

        if [[ ${DIRECTORY} == ${DIRECTORY_BASENAME} ]];then
            continue
        fi

        local DIRECTORY_TARGET=${TARGET_DIRECTORY}/${DIRECTORY_BASENAME}

        if [[ ! -d ${DIRECTORY_TARGET} ]];then
            mkdir -p ${DIRECTORY_TARGET}
        fi

    done

}
