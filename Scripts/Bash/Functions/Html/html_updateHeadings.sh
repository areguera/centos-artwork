#!/bin/bash
#
# html_updateHeadings.sh -- This function transforms html headings to
# create the page table of content headings as reference. Multiple
# heading levels are supported using nested lists. Use this function
# over html files inside the repository to standardize their headings. 
#
#   - This function looks for <div class="toc">...</div> specification
#     inside your page and, if present, replace the content inside
#     with the link list o headinds. 
#
#   - If <div class="toc">...</div> specification is present on the
#     page it is updated with headings links. Otherwise only heading
#     links are created. 
#
#   - If <div class="toc">...</div> specification is malformed (e.g.,
#     you forgot the closing tag), this function will look the next
#     closing div in your html code and replace everything in-between
#     with the table of content.
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
# $Id$
# ----------------------------------------------------------------------

function html_updateHeadings {

}
