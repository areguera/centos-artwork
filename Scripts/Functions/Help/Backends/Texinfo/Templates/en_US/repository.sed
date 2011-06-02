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
s!<blockquote><p><strong>Note</strong>!<blockquote class="blue icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/icon-admonition-info.png" alt="Info" /><h3>Note</h3><p>!g

s!<blockquote><p><strong>Warning</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/icon-admonition-alert.png" alt="Warning" /><h3>Warning</h3><p>!g

s!<blockquote><p><strong>Important</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/icon-admonition-star.png" alt="Important" /><h3>Important</h3><p>!g

s!<blockquote><p><strong>Tip</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/icon-admonition-idea.png" alt="Tip" /><h3>Tip</h3><p>!g

s!<blockquote><p><strong>Caution</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/icon-admonition-attention.png" alt="Caution" /><h3>Caution</h3><p>!g

s!<blockquote><p><strong>Convention</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/icon-admonition-ruler.png" alt="Convention" /><h3>Convention</h3><p>!g

s!<blockquote><p><strong>Redirection</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/icon-admonition-redirect.png" alt="Redirection" /><h3>Redirection</h3><p>!g
