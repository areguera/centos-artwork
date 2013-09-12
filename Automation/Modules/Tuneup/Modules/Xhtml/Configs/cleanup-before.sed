#!/bin/sed
######################################################################
#
#   cleanup-before.sed -- This file is read by xhtml_setCleanUp
#   function to convert special tags into HTML comments before cleanup
#   process.  Once the file has been cleaned up, the special tags are
#   converted back to their original form (see: cleanup-after.sed).
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2013 The CentOS Project
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

# Remove HTML preable, if any. It will be added later by xmllint,
# based on its own interpretation of the document.
/<?xml/d
/<!DOCTYPE/,/>{1}/d

# Convert Mailman-specific tags into comments. These tags are found in
# Mailman's templates and should not be touched in any way because
# they are used to display dynamic content at Mailman's run time.
s/<((mm|MM)-[[:alnum:]_-]+)>/<!-- \1 -->/g
s/(%\([[:alnum:]_-]+\)[[:alpha:]])/<!-- \1 -->/g
