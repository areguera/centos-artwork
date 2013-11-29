#!/bin/bash
######################################################################
#
#   cleanup.sh -- This script creates copies of Mailman's template
#   files cleans them up using xmllint, sed and tidy programs.
#   Mailman's template files control only one part of Mailman's
#   presentation. The rest is inside the source code (e.g., look at
#   htmlformat.py at HTMLFORMAT.py). This script takes care of the
#   first face of the customization only.
#
#   USAGE
#   ./CustomizationTools/cleanup.sh FILE.html ...
#
# Copyright (C) 2013 The CentOS Artwork SIG
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
########################################################################

echo "Customizing files ..."
sed -i -r -f CustomizationTools/cleanup-all.sed $(find templates -name '*.html')
