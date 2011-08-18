#!/bin/sed 
#
# repository.sed -- This file provide Spanish transformations for
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
s!<blockquote><p><strong>Nota</strong>!<blockquote class="blue icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/note.png" alt="Info" /><h2>Nota</h2><p>!g

s!<blockquote><p><strong>Advertencia</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/warning.png" alt="Advertencia" /><h2>Advertencia</h2><p>!g

s!<blockquote><p><strong>Importante</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/star.png" alt="Importante" /><h2>Importante</h2><p>!g

s!<blockquote><p><strong>Idea</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/tip.png" alt="Idea" /><h2>Idea</h2><p>!g

s!<blockquote><p><strong>Precaución</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/caution.png" alt="Precaución" /><h2>Precaución</h2><p>!g

s!<blockquote><p><strong>Convensión</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/ruler.png" alt="Convensión" /><h2>Convensión</h2><p>!g

s!<blockquote><p><strong>Redirección</strong>!<blockquote class="blue icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/redirect.png" alt="Redirección" /><h2>Redirección</h2><p>!g
