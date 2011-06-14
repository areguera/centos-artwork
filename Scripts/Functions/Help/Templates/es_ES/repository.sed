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
s!<blockquote><p><strong>Nota</strong>!<blockquote class="blue icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/note.png" alt="Info" /><h3>Nota</h3><p>!g

s!<blockquote><p><strong>Advertencia</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/warning.png" alt="Advertencia" /><h3>Advertencia</h3><p>!g

s!<blockquote><p><strong>Importante</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/star.png" alt="Importante" /><h3>Importante</h3><p>!g

s!<blockquote><p><strong>Idea</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/tip.png" alt="Idea" /><h3>Idea</h3><p>!g

s!<blockquote><p><strong>Precaución</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/caution.png" alt="Precaución" /><h3>Precaución</h3><p>!g

s!<blockquote><p><strong>Convensión</strong>!<blockquote class="orange icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/ruler.png" alt="Convensión" /><h3>Convensión</h3><p>!g

s!<blockquote><p><strong>Redirección</strong>!<blockquote class="blue icon"><img src="/home/centos/artwork/trunk/Identity/Images/Webenv/redirect.png" alt="Redirección" /><h3>Redirección</h3><p>!g
