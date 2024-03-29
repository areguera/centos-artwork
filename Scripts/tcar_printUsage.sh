#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Describe options and most frequently used commands related to tcar
# script.
function tcar_printUsage {

   tcar_printMessage "`gettext "Usage"`: tcar [--version] [--help] <command> [--filter=<regex>]" --as-stdout-line=5
   tcar_printMessage ":      [--debug] [--yes] [--quiet]" --as-stdout-line=5
   echo

   tcar_printMessage "`gettext "The most commonly used tcar commands are:"`" --as-stdout-line
   tcar_printMessage "    prepare: `gettext "..."`" --as-stdout-line
   tcar_printMessage "    render: `gettext "..."`" --as-stdout-line
   tcar_printMessage "    locale: `gettext "..."`" --as-stdout-line
   tcar_printMessage "    tuneup: `gettext "..."`" --as-stdout-line
   tcar_printMessage "    hello: `gettext "..."`" --as-stdout-line
   echo

   tcar_printMessage "`gettext "See 'tcar help <command>' for more information on a specific command."`" --as-stdout-line

   exit 0

}
