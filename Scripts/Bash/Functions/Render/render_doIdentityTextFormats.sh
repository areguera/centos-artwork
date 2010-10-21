#!/bin/bash
#
# render_doIdentityTextFormats.sh -- This function give format to
# text files.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# $Id: render_doIdentityTextFormats.sh 56 2010-09-17 11:07:26Z al $
# ----------------------------------------------------------------------

function render_doIdentityTextFormats {

   # Get file path.
   local FILE="$1"

   # Get action to do over text file.
   local OPTIONS=$(render_getConfOption "$2" '2-')

   # Remove some fmt's options. As we are applying fmt's options to a
   # file directly, there are some options like --version and --help
   # that are of little use here.
   OPTIONS=$(echo "$OPTIONS" | sed -r 's!--(version|help)!!g')

   # Define current file format. Use just the first word returned by
   # the command `file' as identifier.
   local FILE_FORMAT=$(file $FILE | cut -d' ' -f2)

   # Do format based on file format.
   case $FILE_FORMAT in

      ASCII | UTF-8 )
      # Apply OPTIONS to plain text files. Doing the same with html
      # (and similar) files can mess up the markup, so apply format
      # options to plain text only.
      cat $FILE | fmt $(echo -n "$OPTIONS") > ${FILE}.fmt
      mv ${FILE}.fmt $FILE
      ;;

   esac

}
