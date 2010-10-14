#!/bin/bash
#
# cli_getRepoName.sh -- This function sets naming convenction. Inside
# CentOS Artowrk Repository, regular files are written in lower case
# and directories are written in lower case but with the first letter
# in upper case. Use this function to sanitate the name of regular
# files and directories you work with.
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
# $Id: cli_getRepoName.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function cli_getRepoName {

   local ID="$1"
   local NAME="$2"

   case $ID in

      F | f | File | file )
      NAME=$(echo $NAME \
         | tr -s ' ' '_' \
         | tr '[:upper:]' '[:lower:]')
      ;;

      D | d | Dir | dir | Directory | directory )
      NAME=$(echo $NAME \
         | tr -s ' ' '_' \
         | tr '[:upper:]' '[:lower:]' \
         | sed -r 's/^([[:alpha:]])/\u\1/')
      ;;

   esac

   echo $NAME

}
