#!/bin/bash
######################################################################
#
#   tcar.sh -- The CentOS Artwork Repository automation tool.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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

######################################################################
# Identity
######################################################################

declare -xr TCAR_SCRIPT_PACKAGE="tcar"
declare -xr TCAR_SCRIPT_VERSION="$(rpm -q --qf "%{VERSION}" ${TCAR_SCRIPT_PACKAGE})"

######################################################################
# Paths
######################################################################

# Base directory where repository files are installed in.
declare -xr TCAR_BASEDIR=/usr/share/tcar/Scripts

# Base directory where final content is produced. This value should be
# customized later by the user.
declare -xr TCAR_WORKDIR=/tmp

# Directory to store temporal files.
declare -xr TCAR_SCRIPT_TEMPDIR=$(mktemp -p /tmp -d ${TCAR_SCRIPT_PACKAGE}-XXXXXX)

# Configuration files in order of reading preference. The last file in
# the list overlaps options set in previous files in the list. Use
# colon character to separate files in the list.
declare -xr TCAR_SCRIPT_CONFIG=${HOME}/.tcar.conf

# Base directory where man pages are searched at.
declare -xr TCAR_SCRIPT_MANUALS=/usr/share/man

# Base directory where automation script modules are installed in.
declare -xr TCAR_SCRIPT_MODULES_BASEDIR=${TCAR_BASEDIR}/Modules

# Default text editor.
declare -x  TCAR_SCRIPT_EDITOR=/usr/bin/vim

######################################################################
# Internationalization
######################################################################

# Set the script language information using the LC format. This format
# shows both language and country information (e.g., `es_ES').
declare -xr TCAR_SCRIPT_LANG_LC=$(echo ${LANG} | cut -d'.' -f1)

# Set the script language information using the LL format. This format
# shows only the language information (e.g., `es').
declare -xr TCAR_SCRIPT_LANG_LL=$(echo ${TCAR_SCRIPT_LANG_LC} | cut -d'_' -f1)

# Set the script language information using the CC format. This format
# shows only the country information (e.g., `ES').
declare -xr TCAR_SCRIPT_LANG_CC=$(echo ${TCAR_SCRIPT_LANG_LC} | cut -d'_' -f2)

# Set function environments required by GNU gettext system.
. gettext.sh

# Set the script text domain. This information is used by gettext
# system to retrieve translated strings from machine object (MO) files
# with this name. This variable is reset each time a new module is
# loaded, so the correct files can be used.
declare -x TEXTDOMAIN="${TCAR_SCRIPT_PACKAGE}"

# Set the script text domain directory. This information is used by
# gettext system to know where the machine objects are stored in. This
# variable is reset each time a new module is loaded, so the correct
# files can be used.
declare -x TEXTDOMAINDIR=/usr/share/locale

######################################################################
# Global Flags
######################################################################

# Set filter flag (-f|--filter).  This flag is mainly used to reduce
# the number of files to process and is interpreted as egrep-posix
# regular expression.  By default, when this flag is not provided, all
# paths in the working copy will match, except files inside hidden
# directories like `.svn' and `.git' that will be omitted.
declare -x  TCAR_FLAG_FILTER='[[:alnum:]_/-]+'

# Set verbosity flag (-q|--quiet). This flag controls whether
# tcar.sh script prints messages or not. By default, all
# messages are suppressed except those directed to standard error.
declare -x  TCAR_FLAG_QUIET='false'

# Set affirmative flag (-y|--yes). This flag controls whether
# tcar.sh script does or does not pass confirmation request
# points. By default, it doesn't.
declare -x  TCAR_FLAG_YES='false'

# Set debugger flag (-d|--debug). This flag controls whether
# tcar.sh script does or does not print debugging information.
# The tcar.sh script prints debug information to standard
# output.
declare -x  TCAR_FLAG_DEBUG='false'

######################################################################
# Global Functions
######################################################################

# Export script's environment functions.
for SCRIPT_FILE in $(ls ${TCAR_BASEDIR}/tcar_*.sh);do
    if [[ -x ${SCRIPT_FILE} ]];then
        . ${SCRIPT_FILE}
        export -f $(grep '^function ' ${SCRIPT_FILE} | cut -d' ' -f2)
    else
        echo "${SCRIPT_FILE} `gettext "has not execution rights."`"
        exit 1
    fi
done

######################################################################
# Signals
######################################################################

# Trap signals in order to terminate the script execution correctly
# (e.g., removing all temporal files before leaving).  Trapping the
# exit signal seems to be enough by now, since it is always present as
# part of the script execution flow. Each time the tcar.sh
# script is executed it will inevitably end with an EXIT signal at
# some point of its execution, even if it is interrupted in the middle
# of its execution (e.g., through `Ctrl+C').
trap tcar_terminateScriptExecution 0

######################################################################
# Parse Command-line Arguments
######################################################################

declare -x TCAR_MODULE_NAME=''
declare -x TCAR_MODULE_ARGUMENT=''
declare -x TCAR_SCRIPT_ARGUMENT=''

# Retrieve module's name using the first argument of tcar.sh
# script as reference.
if [[ ! ${1} =~ '^-' ]];then
    TCAR_MODULE_NAME="${1}"; shift 1
else
    TCAR_MODULE_NAME=""
fi

# Initialize tcar.sh script specific options. The way tcar.sh script
# retrieves its options isn't as sophisticated (e.g., it doesn't
# provide valid-option verifications) as it is provided by getopt
# command. I cannot use getopt here because it is already used when
# loading module-specific options. Using more than one invocation of
# getopt in the same script is not possible (e.g., one of the
# invocations may enter in conflict with the other one when different
# option definitions are expected in the command-line.)
while true; do

    # Store non-option arguments passed to tcar.sh script.
    if [[ ! ${1} =~ '^-' ]];then
        TCAR_SCRIPT_ARGUMENT="${1} ${TCAR_SCRIPT_ARGUMENT}"
        shift 1
        if [[ $# -gt 0 ]];then
            continue
        else
            break
        fi
    fi

    case "${1}" in

        --help* )

            if [[ -z ${TCAR_MODULE_NAME} ]];then
                # Print tcar.sh script's help. Consider that the
                # --help option can receive an argument by using the
                # equal sign (e.g.,
                # --help=tcar_setModuleEnvironment.sh).  However, it
                # is not possible to use spaces instead of equal sign
                # because that would confuse other options from being
                # parsed.
                tcar_printHelp "${1}"
                exit 0
            else
                # Store the argument for further processing inside the
                # module environment that will be executed later.
                TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
                shift 1
            fi
            ;;

        --version )

            # Print tcar.sh script's version.
            if [[ -z ${TCAR_MODULE_NAME} ]];then
                tcar_printVersion
                exit 0
            else
                TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
                shift 1
            fi
            ;;

        --quiet )

            TCAR_FLAG_QUIET='true'
            shift 1
            ;;

        --yes )

            TCAR_FLAG_YES='true'
            shift 1
            ;;

        --debug )

            TCAR_FLAG_DEBUG='true'
            shift 1
            ;;

        * ) 

            # Store module-specific option arguments. This is, all
            # arguments not considered part of tcar.sh script
            # itself. The module-specific option arguments are passed,
            # later, to getopt for option processing, inside the
            # module-specific environments.
            TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
            shift 1
            if [[ $# -gt 0 ]];then
                continue
            else
                break
            fi
            ;;
    esac
done

# Initiate module-specific environment.
tcar_setModuleEnvironment -m "${TCAR_MODULE_NAME}" ${TCAR_MODULE_ARGUMENT} ${TCAR_SCRIPT_ARGUMENT}

# At this point everything has been done without errors. So, exit
# tcar.sh script successfully.
exit 0
