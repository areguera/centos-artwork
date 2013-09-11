#!/bin/sed
######################################################################
#
#   cleanup-after.sed -- This file is read by xhtml_setCleanUp
#   function to convert special tags into HTML comments after cleanup
#   process.  
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

# Convert Mailman-specific tags back into their original form (see:
# cleanup-before.sed).
s/<!-- ((mm|MM)-[[:alnum:]_-]+) -->/<\1>/g
s/%3C!--%20((mm|MM)-[[:alnum:]_-]+)%20--%3E/<\1>/g
s/&lt;!-- ((mm|MM)[[:alnum:]_-]+) --&gt;/<\1>/g

s/<!-- (%\([[:alnum:]_-]+\)[[:alpha:]]) -->/\1/g
s/%3C!--%20(%\([[:alnum:]_-]+\)[[:alpha:]])%20--%3E/\1/g
s/&lt;!-- (%\([[:alnum:]_-]+\)[[:alpha:]]) --&gt;/\1/g
