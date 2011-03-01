#!/bin/bash
#
# renameFiles.sh -- Rename files names, inside svn repository,
# massively.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
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
# $Id$
# ----------------------------------------------------------------------


if [ ! $# = 4 ];then
   cli_printMessage "`gettext "Syntax: ./update-filenames.sh <PATH> <FILTER> <PATTERN> <VALUE>"`"
   exit;
fi

ROOTDIR="$1"
FILTER="$2"
PATTERN="$3"
VALUE="$4"

for FILE in `find $ROOTDIR -regex $FILTER`;do
   DIR=`dirname $FILE`
   FILE=`basename $FILE`
   svn mv $DIR/$FILE $DIR/`echo $FILE | sed -r "s!$PATTERN!$VALUE!"`
done
