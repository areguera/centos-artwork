#!/bin/sed 
#
# repository.sed -- This file provide English transformations for
# texi2html outupt, based on The CentOS Project CSS definitions.
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

# Quotations.
s!<blockquote><p><strong>Note</strong>!<blockquote class="blue icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/note.png" alt="Info" /><h2>Note</h2><p>!g

s!<blockquote><p><strong>Warning</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/warning.png" alt="Warning" /><h2>Warning</h2><p>!g

s!<blockquote><p><strong>Important</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/important.png" alt="Important" /><h2>Important</h2><p>!g

s!<blockquote><p><strong>Tip</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/tip.png" alt="Tip" /><h2>Tip</h2><p>!g

s!<blockquote><p><strong>Caution</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/caution.png" alt="Caution" /><h2>Caution</h2><p>!g

s!<blockquote><p><strong>Convention</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/ruler.png" alt="Convention" /><h2>Convention</h2><p>!g

s!<blockquote><p><strong>Redirection</strong>!<blockquote class="blue icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/redirect.png" alt="Redirection" /><h2>Redirection</h2><p>!g
