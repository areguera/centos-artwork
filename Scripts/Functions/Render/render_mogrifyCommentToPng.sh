#!/bin/bash
#
# render_mogrifyCommentToPng.sh -- This function provides
# post-rendition to write a commentary in PNG images produced as
# result of centos-art.sh base-rendition action. The commentary is
# written in the image datastream and can be seen using the command
# `identify -verbose file.png'.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function render_mogrifyCommentToPng {

    # Define commentary you want to write on PNG images.
    local COMMENT="`gettext "Created in CentOS Artwork Repository"` (https://projects.centos.org/svn/artwork/)."

    # Check base file existence.
    cli_checkFiles ${FILE}.png 'f'

    # Write commentary to PNG image.
    mogrify -comment "$COMMENT" ${FILE}.png

}
