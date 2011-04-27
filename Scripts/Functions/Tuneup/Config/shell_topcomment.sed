#!/bin/sed
#
# shell_topcomment.sed -- This file standardizes the top comment
# inside centos-art.sh scripts.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------
/^# +Copyright .*$/a\
# Copyright (C) 2009, 2010, =COPYRIGHT_YEAR= =COPYRIGHT_HOLDER=\
#\
# This program is free software; you can redistribute it and/or modify\
# it under the terms of the GNU General Public License as published by\
# the Free Software Foundation; either version 2 of the License, or (at\
# your option) any later version.\
#\
# This program is distributed in the hope that it will be useful, but\
# WITHOUT ANY WARRANTY; without even the implied warranty of\
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU\
# General Public License for more details.\
#\
# You should have received a copy of the GNU General Public License\
# along with this program; if not, write to the Free Software\
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.\
#\
# ----------------------------------------------------------------------

# Remove previous copyright notice, just to be sure the one above be
# used always.
/^# +Copyright .*$/,/^# -{70}$/{
d
}

# Remove more than one space after comments.
s/^# +/# /

# Define script first line.
1c\
#!/bin/bash
