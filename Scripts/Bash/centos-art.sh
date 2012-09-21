#!/bin/bash
#
# centos-art.sh -- The CentOS Artwork Repository automation tool.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

# Initialize absolute path to the working copy.
if [[ ! $TCAR_WORKDIR ]] || [[ $TCAR_WORKDIR == "" ]];then
    TCAR_WORKDIR=${HOME}/artwork
fi

# Initialize script-specific configuration variables.
declare -xr BRAND="centos"
declare -xr CLI_NAME="${BRAND}-art"
declare -xr CLI_VERSION='0.0.3'
declare -xr CLI_LANG_LC=$(echo ${LANG} | cut -d'.' -f1)
declare -xr CLI_LANG_LL=$(echo ${CLI_LANG_LC} | cut -d'_' -f1)
declare -xr CLI_LANG_CC=$(echo ${CLI_LANG_LC} | cut -d'_' -f2)
declare -xr CLI_BASEDIR="${TCAR_WORKDIR}/trunk/Scripts/Bash"
declare -xr CLI_FUNCDIR="${CLI_BASEDIR}/Functions"

# Initialize internazionalization through GNU gettext.
. gettext.sh
declare -xr TEXTDOMAIN=${CLI_NAME}.sh
declare -xr TEXTDOMAINDIR=${TCAR_WORKDIR}/trunk/Locales/Scripts/Bash

# Initialize absolute path to temporal directory.
declare -xr TMPDIR="$(mktemp -p /tmp -d ${CLI_NAME}.sh-XXXXXX)"

# Initialize domain-specific information.
declare -xr DOMAINNAME="${BRAND}.org"
declare -xr DOMAINNAME_LISTS="lists.${DOMAINNAME}"
declare -xr DOMAINNAME_HOME="www.${DOMAINNAME}"
declare -xr DOMAINNAME_PROJECTS="projects.${DOMAINNAME}"
declare -xr DOMAINNAME_FORUMS="forums.${DOMAINNAME}"
declare -xr DOMAINNAME_BUGS="bugs.${DOMAINNAME}"
declare -xr DOMAINNAME_PLANET="planet.${DOMAINNAME}"
declare -xr DOMAINNAME_WIKI="wiki.${DOMAINNAME}"
declare -xr DOMAINNAME_MIRRORS="mirrors.${DOMAINNAME}"
declare -xr DOMAINNAME_DOCS="docs.${DOMAINNAME}"

# Initialize mail-specific information.
declare -xr MAILINGLIST_DOCS="${BRAND}-docs@${DOMAINNAME}"
declare -xr MAILINGLIST_L10N="${BRAND}-l10n@${DOMAINNAME}"
declare -xr MAILINGLIST_DEVEL="${BRAND}-devel@${DOMAINNAME}"

# Initialize command-line interface.
if [[ -x ${CLI_FUNCDIR}/Commons/cli.sh ]];then
    . ${CLI_FUNCDIR}/Commons/cli.sh; export -f 'cli'; cli "$@"
fi

# End script execution correctly.
exit 0
