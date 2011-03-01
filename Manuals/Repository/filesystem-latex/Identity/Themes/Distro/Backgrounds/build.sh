#!/bin/bash
#
# Build Background tables for LaTeX documents.
#
# Copyright (C) 2009 Alain Reguera Delgado
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
# USA
#
#--------------------------------------
# $Id:$
#--------------------------------------

# Load dependencies.
. ~/artwork/trunk/Scripts/Bash/loadFunctions.sh

# Define the names of your tables.
FILES="table-theme.tex
       table-config.tex"

for FILE in $FILES;do

   # Let know which table we are creating.
   echo $FILE

   # Define what to do with each table you define on FILES.
   case $FILE in

      table-theme.tex )
      # Create table holding theme files.
      ROWS="$(getFiles '/usr/share/backgrounds' 'default.*\.(jpg|png)')"
      ;;

      table-config.tex )
      # Create table holding configuration files.
      ROWS="$(getFiles '/etc/gdm' '\.conf$' '/default\.(jpg|png)')
            $(getFiles '/etc/gconf' '\.(schemas|xml)$' '/default.*\.(jpg|png)')
            $(getFiles '/usr/share/config' 'rc$' 'default.*\.(jpg|png)')"
      ;;

   esac

   # Create table.
   createTable "$ROWS" "" "" > $FILE

done
