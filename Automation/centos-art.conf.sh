#!/bin/bash
######################################################################
#
#   centos-art.conf.sh -- This file provides default configuration
#   values to centos-art.sh script.
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
# Script's identity configuration variables.
######################################################################

# Set the script name.
declare -xr TCAR_SCRIPT_NAME="centos-art.sh"

# Set the script version. You can use this number as pattern
# to identify the relation between the centos-artwork repository
# and the script. Both repository and script version must be the same.
# This way we can say that specific functionalities inside the script
# will work as expected when run over the repository directory structure.
declare -xr TCAR_SCRIPT_VERSION='0.6'

# Set the script command name.
declare -xr TCAR_SCRIPT_COMMAND="centos-art"

######################################################################
# Script's path configuration variables.
######################################################################

# Set the script modules directory.
declare -xr TCAR_SCRIPT_MODULES_BASEDIR=${TCAR_SCRIPT_BASEDIR}/Modules

# Set the script temporal directory.
declare -xr TCAR_SCRIPT_TEMPDIR=$(mktemp -p /tmp -d ${TCAR_SCRIPT_NAME}-XXXXXX)

######################################################################
# Internationalization configuration variables and functions.
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
declare -xr TEXTDOMAIN="${TCAR_SCRIPT_NAME}"

# Set the script text domain directory. This information is used by
# gettext system to know where the machine objects are stored in. This
# variable is reset each time a new module is loaded, so the correct
# files can be used.
declare -xr TEXTDOMAINDIR=${TCAR_SCRIPT_BASEDIR}/Locales

######################################################################
# Module-specific configuration variables.
######################################################################

# Set absolute path to documentation search path. This is the location
# where final documentation formats (e.g., man pages) will be saved
# in.
declare -x TCAR_SCRIPT_DIR_MANUALS=${TCAR_SCRIPT_BASEDIR}/Manuals

######################################################################
# User-related configuration variables.
######################################################################

# Set file path to your preferred text editor.  The editor you specify
# will be use when you need to write commit messages and anything that
# requires text edition.
declare -x  TCAR_USER_EDITOR=/usr/bin/vim

# Set user-specific configuration file used by centos-art.sh script to
# determine where to retrieve user-specific configuration values.
# User-specific configuration files let you customize the way
# centos-art.sh behaves in a multi-user environment. This variable
# must be read-only.
declare -xr TCAR_USER_CONFIG=${HOME}/.${TCAR_SCRIPT_COMMAND}.conf.sh

######################################################################
# Flag-related configuration variables.
######################################################################

# Set filter flag (-f|--filter).  This flag is mainly used to reduce
# the number of files to process and is interpreted as egrep-posix
# regular expression.  By default, when this flag is not provided, all
# paths in the working copy will match, except files inside hidden
# directories like `.svn' and `.git' that will be omitted.
declare -x  TCAR_FLAG_FILTER='[[:alnum:]_/-]+'

# Set verbosity flag (-q|--quiet). This flag controls whether
# centos-art.sh script prints messages or not. By default, all
# messages are suppressed except those directed to standard error.
declare -x  TCAR_FLAG_QUIET='false'

# Set affirmative flag (-y|--yes). This flag controls whether
# centos-art.sh script does or does not pass confirmation request
# points. By default, it doesn't.
declare -x  TCAR_FLAG_YES='false'

# Set debugger flag (-d|--debug). This flag controls whether
# centos-art.sh script does or does not print debugging information.
# The centos-art.sh script prints debug information to standard
# output.
declare -x  TCAR_FLAG_DEBUG='false'
