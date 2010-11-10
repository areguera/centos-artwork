# This file standardizes the look and feel of top comments used by
# scripts inside CentOS Artwork Repository. It contains the copyright
# note and the license under which the script is released.  This files
# is used with the regular expression '.*\.sh$' only.
# ---------------------------------------------------
# $Id$
# ---------------------------------------------------
/^# +Copyright .*$/a\
# Copyright (C) =YEAR1=, =YEAR2= =FULLNAME=\
# \
# This program is free software; you can redistribute it and/or\
# modify it under the terms of the GNU General Public License as\
# published by the Free Software Foundation; either version 2 of the\
# License, or (at your option) any later version.\
# \
# This program is distributed in the hope that it will be useful, but\
# WITHOUT ANY WARRANTY; without even the implied warranty of\
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU\
# General Public License for more details.\
#\
# You should have received a copy of the GNU General Public License\
# along with this program; if not, write to the Free Software\
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307\
# USA.\
# \
# ----------------------------------------------------------------------

# Remove previous comments.
/^# +Copyright .*$/,/^# -+$/{
d
}

# Remove more than one space after comments.
s/^# +/# /

# Define first line
1c\
#!/bin/bash
