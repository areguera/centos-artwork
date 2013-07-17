#!/bin/bash
######################################################################
#
#   prepare_setDirStructure.sh -- This function standardizes
#   the relation between source directory structures and target
#   directory structures inside the repository. 
#
#   This function takes source and target directory paths as
#   arguments, analyses them and builds the target directory structure
#   based on source directory structure.  This function must be
#   executed before executing production modules like render.
#
#   In order for this verification to work, all source directory
#   structures provided must be organized using one directory level
#   more than its related target directory. The purpose of this
#   directory is content categorization. For example, consider the
#   following path:
#
#       ---------------++++++++++++++++++++++++
#       ${SOURCE_PATH}/${CATEGORY}/${COMPONENT}
#       ---------------++++++++++++++++++++++++
#       ++++++++++++++++++++++++++++++++++------------
#       ${TARGET_PATH}/${NAME}/${VERSION}/${COMPONENT}
#       ++++++++++++++++++++++++++++++++++------------
#
#   So we end with the following path:
#
#       ${TARGET_PATH}/${CATEGORY}/${COMPONENT}
# 
#   In this path, ${CATEGORY} makes reference to a categorization
#   directory used to describe source components related to target
#   components. However, in the target side, such ${CATEGORY}
#   directory is not needed and should be removed from it in order to
#   get the final target path, which is:  
#
#       ${TARGET_PATH}/${COMPONENT}
#
#   ${CATEGORY} is always a one-level directory, but ${COMPONENT}
#   might have several levels deep.
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
    local SOURCE_PATH=$(tcar_checkRepoDirSource "${1}")

    # Verify existence source path, just to be sure it was passed and
    # it is a valid directory.
    tcar_checkFiles ${SOURCE_PATH} -d

    # Define absolute path to directory inside the repository where
    # you want to replicate the source path directory structure.
    local TARGET_PATH=$(tcar_checkRepoDirSource "${2}")

    # NOTE: It is possible that target path doesn't exist. So verify
    # the relation between target and source path. If there is a
    # source path for the target, create an empty directory as target,
    # using the related source directory as reference.

    # Define list of directories inside source path.
    local SOURCE_DIRS=$(tcar_getFilesList ${SOURCE_PATH} \
        --pattern='.+/[[:alpha:]]+$' --type=d)

    # Iterate through directories inside source path and verify
    # whether or not they exist in the target path. If they don't
    # exist create them.
    for SOURCE_DIR in ${SOURCE_DIRS};do

        local SOURCE_DIR_BASENAME=$(echo ${SOURCE_DIR} \
            | sed -r "s,${SOURCE_PATH}/,,")

        local TARGET_DIR=${TARGET_PATH}/${SOURCE_DIR_BASENAME}

        if [[ ${SOURCE_DIR} == ${SOURCE_DIR_BASENAME} ]];then
            continue
        fi

        # Keep this for debugging ;)
        #echo '---'
        #echo $SOURCE_DIR_BASENAME;
        #echo $SOURCE_DIR;
        #echo $TARGET_DIR;
        #echo $TARGET_PATH;
        #echo '---'
        #continue

        if [[ ! -d ${TARGET_DIR} ]];then
            mkdir -p ${TARGET_DIR}
        fi

    done

}
