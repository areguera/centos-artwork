#!/usr/bin/python
#
# centos-web.cgi -- This script is an effort to organize The CentOS
# Project information in XHTML format for its publication on the
# Internet. The script is organized in a package named `Apps' which,
# in turn, is subdivided in other packages (e.g., `Home', `Sponsors',
# etc.) to cover each web application the organization demands.
#
# Notice that some of the web applications demanded (e.g., Wiki,
# Lists, Forums, Bugs, etc.) are not included in this script, but
# linked to their own locations. Moreover, in order to provide
# accessability among all different web applications, they need to be
# redesigned to share one unique visual style and one unique top-level
# navigation bar so the current web application can be remarked.
#
# Copyright (C) 2011 Alain Reguera Delgado
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
# ------------------------------------------------------------------
# $Id$
# ------------------------------------------------------------------

import cgi
import cgitb; cgitb.enable()

def main():

    qs = cgi.parse()

    if 'app' in qs:
        app = qs['app'][0].lower()
    else:
        app = 'home'

    if app == 'home':
        from Apps.Home import page
    elif app == 'sponsors':
        from Apps.Sponsors import page
    
    print 'Content-type: text/html' + "\n"
    print page.main()

if __name__ == '__main__': main()
