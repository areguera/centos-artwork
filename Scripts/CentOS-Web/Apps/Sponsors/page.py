#!/usr/bin/python
#
# Apps.Home.page -- This module intantiates Apps.xhtml module to
# create the xhtml output of home web applications.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

from Apps import page

app = page.Layout()


def page_navibar_tabs():
    """Returns application's main pages.
    
    The application's main pages are organized as tabs in the
    application navigation bar. There is one tab for each main page
    inside the application.
    
    """
    names = ['Hardware', 'Hosting', 'Others']
    attrs = []

    for i in names:
        if 'app' in app.qs.keys():
            attrs.append({'href': '/centos-web/?app=' + app.qs['app'][0].lower() + '&p=' + i.lower()})
        else:
            attrs.append({'href': '/centos-web/?p=' + i.lower()})

    if 'p' in app.qs.keys():
        focus = app.qs['p'][0]
    else:
        focus = names[0]

    return app.navibar_app(names, attrs, focus)


def page_content():
    """Returns page content.
    
    The page content to show is determined from the query string,
    specifically from the value of `p' variable.
    
    """
    if 'p' in app.qs.keys():
        p = app.qs['p'][0].lower()
    else:
        p = 'hardware'

    if p == 'hardware':
        output = app.tag_h1({'class': 'title'}, [12, 1], 'Hardware Sponsors' )
    elif p == 'hosting':
        output = app.tag_h1({'class': 'title'}, [12, 1], 'Hosting Sponsors' )
    elif p == 'others':
        output = app.tag_h1({'class': 'title'}, [12, 1], 'Other Sponsors' )
    else:
        output = app.tag_p('', [12, 1], 'Page empty.')

    return app.content(output)

def main():
    """Returns final output."""

    # Define application name. This value is used as reference to
    # determine which application to load and what tab in the
    # navigation bar to focus.
    app.name = 'Sponsors'

    # Define application title. This value is dislayed on the
    # browser's title bar. Notice that we concatenated the page class
    # default value here.
    app.title += ' :: Sponsors'

    page_header = app.logo()
    page_header += app.ads_google()
    page_header += app.navibar_top()
    page_header += app.appslinks()
    page_header += page_navibar_tabs()
    page_header = app.tag_div({'id': 'page-header'}, [4,1], page_header, 1)

    page_body = page_content() + app.separator(indent=[12,1])
    page_body = app.tag_div({'id':'content'}, [8,1], page_body, 1)
    page_body = app.tag_div({'id':'page-body'}, [4,1], page_body, 1)

    page_footer = app.tag_div({'id': 'page-footer'}, [4,1], app.credits(), 1)
    
    top = app.tag_a({'name':'top'}, [0,1], '')
    wrap = app.tag_div({'id': 'wrap'}, [0,1], page_header + page_body + page_footer, 1)
    body = app.tag_body('', [0,1], wrap)

    html = app.preamble()
    html += app.tag_html({'xmlns': 'http://www.w3.org/1999/xhtml', 'dir': 'ltr', 
                     'lang': str(app.language), 'xml:lang':
                     str(app.language)}, [0,1], app.metadata() +  body)

    return html
