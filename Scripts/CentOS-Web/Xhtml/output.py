#!/usr/bin/python
#
# Xhtml -- This module encapsulates XHTML construction needed by The
# CentOS Web application.
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

import os
import cgi
import cgitb; cgitb.enable()

qs = cgi.parse_qs(os.environ['QUERY_STRING'])
copyright = '2009-2011 The CentOS Project. All rights reserved.'
language = 'en'

def tag(name, attributes, indentation=[8,1], content="", has_child=0):
    """Returns XHTML tag definition.

    Arguments:

    name: The XHTML tag's name. Notice that this function doesn't
        verify nor validate the XHTML tags you provide. It is up to
        you write them correctly considering the XHTML standard
        definition.

    attributes: The XHTML tag's attribute. Notice that this function
        doesn't verify the attributes assignation to tags. You need to
        know what attributes are considered valid to the tag you are
        creating in order to build a well-formed XHTML document. Such
        verification can be achived inside firefox browser through the
        `firebug' plugin.

    indentation: The XHTML tag's indentation (Optional). This argument
        is a list of two numerical values. The first value in the list
        represents the amount of horizontal spaces between the
        beginning of line and the opening tag.  The second value in
        the list represents the amount of vertical spaces (new lines)
        between tags.

    content: The XHTML tag's content (Optional). This argument
        provides the information the tag encloses. When this argument
        is empty, tag is rendered without content.

    has_child: The XHTML tag has a child? (Optional). This argument is
        specifies whether a tag has another tag inside (1) or not (0).
        When a tag has not a child tag, indentation is applied between
        the tag content and the closing tag provoking an unecessary
        spaces to be shown. Such kind of problems are prevented by
        setting this option to `0'. On the other hand, when a tag has
        a child tag inside, using the value `1' will keep the closing
        tag indentation aligned with the opening one.

    This function encapsulates the construction of XHTML tags.  Use
    this function wherever you need to create XHTML tags. It helps to
    standardize tag constructions and their final output and, this
    way, produce consistent XHTML documents.

    """
    if indentation[0] > 0:
        h_indent = ' '*indentation[0]
    else:
        h_indent = ''

    if indentation[1] > 0: 
        v_indent = "\n"*indentation[1]
    else:
        v_indent = ''
    
    output = v_indent + h_indent + '<' + str(name)
    if len(attributes) > 0:
        for k, v in attributes.iteritems():
            output = output + ' ' + str(k) + '="' + str(v) + '"'
    if content == '':
        output = output + ' />'
    else:
        output = output + '>'
        output = output + str(content)
        if has_child == 1:
            output = output + h_indent + '</' + str(name) + '>'
        else:
            output = output + '</' + str(name) + '>'
    output = output + v_indent

    return output


def page_preamble():
    """Define XHTML preamble.

    Use this section to set the content-type required by CGI
    definition, the document type and the head section required by
    XHTML standard.

    """
    output = '<?xml version="1.0"?>' + "\n"
    output = output + '<!DOCTYPE html' + "\n"
    output = output + ' '*4 + 'PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"' + "\n"
    output = output + ' '*4 + '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' + "\n"

    return output


def page_logo():
    """Print XHTML code of page logo.

    The page logo is displayed on the top-left corner of the page. We
    use this area to show The CentOS Logo, the main visual
    representation of The CentOS Project. In order to print the page
    logo correctly, the image related must be 78 pixels of height.
    """
    attrs = []
    attrs.append({'id': 'logo'})
    attrs.append({'title': 'Community Enterprise Operating System', 'href': '/centos-web/'})
    attrs.append({'src': '/centos-web-pub/Images/centos-logo.png', 'alt': 'CentOS'})

    return tag('div', attrs[0], [8,1], tag('a', attrs[1], [12,1], tag('img', attrs[2], [0,0], '', 0), 0), 1)


def page_ads_google():
    """Returns Google advertisement (468x60 pixels).
    
    """
    output = """
        <div class="ads-google">
            <a title="Google Advertisement" href=""><img src="/centos-web-pub/Images/ads-sample-468x60.png" alt="Google Advertisement" /></a>
            <script type="text/javascript"><!--
                google_ad_client = "pub-6973128787810819";
                google_ad_width = 468;
                google_ad_height = 60;
                google_ad_format = "468x60_as";
                google_ad_type = "text_image";
                google_ad_channel = "";
                google_color_border = "204c8d";
                google_color_bg = "345c97";
                google_color_link = "0000FF";
                google_color_text = "FFFFFF";
                google_color_url = "008000";
                //-->
            </script>
            <script type="text/javascript"
                src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
            </script>
        </div>

        <div class="page-line"><hr style="display:none;" /></div>
    """

    return output


def page_navibar_top():
    """Return The CentOS Project top-level navigation links. 
    
    Use this section to list the web applications you want to be
    always visible no matter where you are inside the CentOS web
    henvironment.  Example of web applications are `Home', `Wiki',
    `Lists', `Forums', `Planet', etc.

    """
    names = []
    attrs = []

    names.append('Home')
    attrs.append({'accesskey': '1', 'title': 'The CentOS Project (Alt+Shift+1)', 'href': '/centos-web/'})
    names.append('Wiki')
    attrs.append({'accesskey': '2', 'title': 'The CentOS Wiki (Alt+Shift+2)', 'href': '/centos-web/?app=wiki'})
    names.append('Lists')
    attrs.append({'accesskey': '3', 'title': 'The CentOS Lists (Alt+Shift+3)', 'href': '/centos-web/?app=lists'})
    names.append('Forums')
    attrs.append({'accesskey': '4', 'title': 'The CentOS Forums (Alt+Shift+4)', 'href': '/centos-web/?app=forums'})
    names.append('Projects')
    attrs.append({'accesskey': '5', 'title': 'The CentOS Projects (Alt+Shift+5)', 'href': '/centos-web/?app=projects'})
    names.append('Bugs')
    attrs.append({'accesskey': '6', 'title': 'The CentOS Bugs (Alt+Shift+6)', 'href': '/centos-web/?app=bugs'})
    names.append('Docs')
    attrs.append({'accesskey': '7', 'title': 'The CentOS Documentation (Alt+Shift+7)', 'href': '/centos-web/?app=docs'})
    names.append('Downloads')
    attrs.append({'accesskey': '8', 'title': 'The CentOS Downloads (Alt+Shift+8)', 'href': '/centos-web/?app=downloads'})
    names.append('Sponsors')
    attrs.append({'accesskey': '9', 'title': 'The CentOS Downloads (Alt+Shift+9)', 'href': '/centos-web/?app=sponsors'})

    if 'app' in qs:
        focus = qs['app'][0]
    else:
        focus = names[0]

    output = page_navibar_tabs(names, attrs, focus)
    output = output + tag('div', {'class': 'page-line white'}, [8,1], tag('hr', {'style': 'display:none;'}, [0,0], '', 0), 0)

    return output


def page_navibar_tabs(names, attrs, focus="Home"):
    """Returns the XHTML code of navigation tabs.

    Argumuents:

    names: List of tab names.

    attrs: List of dictionaries for each tab name inside the `names'
        list. Dictionaries inside attrs argument contain the XHTML
        link attributes (e.g., accesskey, title, and href) used by tab
        names so they can be linkable once rendered.

    focus: Name of the tab marked as current. When no value is passed
        to this argument the `Home' value is used as default value.

    """
    links = ''

    for i in names:
        content = tag('span', '', [0,0], str(i))
        content = tag('a', attrs[names.index(i)], [16,1], content)
        if str(i).lower() == focus.lower():
            content = tag('span', {'class': 'current'}, [12,1], content, 1)
        else:
            content = tag('span', '', [12,1], content, 1)
        links = links + content

    output = tag('div', {'class': 'tabs1'}, [8,1], links, 1)

    return output


def page_ads_release():
    """Return XHTML code of last-release advertisement.
    
    The release advertisment is a 728x90 pixels image graphically
    designed to promote the last releases of The CentOS Distribution.
    This image is located on the header space, between the top-level
    links and application specific links. This image changes each time
    a new release is published from The CentOS Project.  
    
    The place where the release advertisement is displayed on the web
    is an area of high visual impact, so images appearing therein
    should be carefully designed in consequence with it.  Likewise,
    the frequency and priority of images in the rotation must be
    controlled and somehow syncronized with the releasing process of
    The CentOS Distribution.

    Previous to consider the release advertisement as such, it was
    reserved for sponsor advertisements. Nevertheless, sponsor
    advertisements were moved to a page for its own through a link in
    the top-level navegation bar.
    
    """
    attrs = []
    attrs.append({'class': 'ads-release'})
    attrs.append({'title': 'Release Advertisement', 'href': ''})
    attrs.append({'src': '/centos-web-pub/Images/ads-sample-728x90.png', 'alt': 'Release Advertisement'})
    output = tag('div', attrs[0], [8,1], tag('a', attrs[1], [12,1], tag('img', attrs[2], [0,0], '', 0), 0), 1)

    return output


def page_userlinks():
    """Return XHTML code of user's links.

    """
    links = ''
    names = []
    attrs = []

    names.append('Lost your password?')
    attrs.append({'href': '/centos-web/?p=lostpwd'})
    names.append('Register')
    attrs.append({'href': '/centos-web/?p=register'})
    names.append('Login')
    attrs.append({'href': '/centos-web/?p=login'})

    for i in names:
        content = tag('a', attrs[names.index(i)], [20,1], str(i), 0)
        if str(i) == names[len(names) -1]:
            content = tag('span', {'class': 'last'}, [16,1], content, 1)
        else:
            content = tag('span', '', [16,1], content, 1)
        links = links + content

    content = tag('div', {'class': 'user'}, [12,1], links, 1)
    output = tag('div', {'class': 'links'}, [8,1], content, 1)

    return output


def page_navibar_app():
    """Returns navigation bar with application links.

    """
    names = []
    attrs = [] 

    names.append('Erratas')
    attrs.append({'accesskey': 'e', 'title': 'The CentOS News (Alt+Shift+E)', 'href': '/centos-web/?p=erratas'})
    names.append('Articles')
    attrs.append({'accesskey': 'a', 'title': 'The CentOS Articles (Alt+Shift+A)', 'href': '/centos-web/?p=articles'})
    names.append('Events')
    attrs.append({'accesskey': 'v', 'title': 'The CentOS Events (Alt+Shift+V)', 'href': '/centos-web/?p=events'})
    
    if 'p' in qs:
        focus = qs['p'][0]
    else:
        focus = names[0]

    output = page_userlinks()
    output = output + page_navibar_tabs(names, attrs, focus)
    output = output + tag('div', {'class': 'page-line white'}, [4,1], tag('hr', {'style': 'display:none;'}, [0,0], '', 0), 0)

    return output


def page_header():
    """Returns XHTML code of page header."""

    content = page_logo()
    content = content + page_ads_google()
    content = content + page_navibar_top()
    if not 'app' in qs:
        content = content + page_ads_release()
        content = content + page_navibar_app()

    return tag('div', {'id': 'page-header'}, [4,1], content, 1)
    

def page_body_breadcrumbs():
    """Application specific links for breadcrumbs sutff. 
    
    Use this section if your application supports breadcrumbs.

    """
    links = ''
    names = []
    attrs = []

    names.append('Pagination')
    attrs.append({'href': ''})
    names.append('Lists')
    attrs.append({'href': ''})
    names.append('Headings')
    attrs.append({'href': ''})
    names.append('Links')
    attrs.append({'href': ''})

    for i in names:
        if names.index(i) == len(names) - 1:
            content = tag('span', {'class':'last'}, [16,1], tag('a', attrs[names.index(i)], [20, 1], i), 1)
        else:
            content = tag('span', '', [16,1], tag('a', attrs[names.index(i)], [20, 1], i, 0), 1)
        links = links + content

    return tag('div', {'class': 'trail'}, [12,1], links, 1)


def page_body():
    """Start page body definitions.
    """
    content = page_body_breadcrumbs()

    content = content + tag('h1', {'class': 'title'}, [12,1], 'My first CGI script')
    content = content + tag('p', '', [12,1], 'This is the first paragraph.')

    content = content + tag('div', {'class': 'page-line'}, [8,1], tag('hr', {'style': 'display:none;'}, [0,0]))
    content = tag('div', {'id':'content'}, [8,1], content, 1)

    output = tag('div', {'id':'page-body'}, [4,1], content, 1)

    return output


def page_footer():
    """Returns XHTML code of page's footer.
    """
    attrs = []
    attrs.append({'title': 'Top', 'href': '#top'})
    attrs.append({'src': '/centos-web-pub/Images/top.png', 'alt': 'Top'})
    attrs.append({'href': 'http://creativecommons.org/licenses/by-sa/3.0/'})

    license = tag('a', attrs[2], [0,0], 'Creative Commons Attribution-Share Alike 3.0 Unported License.')

    credits = tag('div', {'class': 'copyright'}, [12,1], 'Copyright &copy; ' + str(copyright))
    credits = credits + tag('div', {'class': 'license'}, [12,1], 'This website is licensed under a ' + str(license))

    content = tag('img', attrs[1], [0,0])
    content = tag('a', attrs[0], [12,1], content)
    content = tag('div', {'class': 'top'}, [8,1], content, 1)
    content = content + tag('div', {'class': 'credits'}, [8,1], credits, 1)

    output = tag('div', {'class': 'page-line'}, [4,1], tag('hr', {'style': 'display:none;'}, [0,0]))
    output = output + tag('div', {'id': 'page-footer'}, [4,1], content, 1)

    return output


def page_wrap(title, keywords, description):
    """Returns the XHTML code that wraps the whole page.
    """
    attrs = []

    attrs.append({'xmlns': 'http://www.w3.org/1999/xhtml', 'dir': 'ltr', 'lang': str(language), 'xml:lang': str(language)})
    
    content = tag('meta http-equiv="content-type" content="text/html; charset=UTF-8"', '', [4,1])
    content = content + tag('meta http-equiv="content-style-type" content="text/css"', '', [4,0])
    content = content + tag('meta http-equiv="content-language" content="' + str(language) + '"', '', [4,1])
    content = content + tag('meta name="keywords" content="' + str(keywords) + '"', '', [4,0])
    content = content + tag('meta name="description" content="' + str(description) + '"', '', [4,1])
    content = content + tag('meta name="copyright" content="Copyright © ' + str(copyright) + '"', '', [4,0])
    content = content + tag('title', '', [4,1], str(title))
    content = content + tag('link href="/centos-web-pub/stylesheet.css" rel="stylesheet" type="text/css" media="screen projection"', '', [4,1])
    head = tag('head', '', [0,1], content)

    top = tag('a', {'name':'top'}, [0,1], '')

    content = page_header()
    content = content + page_body()
    content = content + page_footer()
    wrap = tag('div', {'id': 'wrap'}, [0,1], content)

    body = tag('body', '', [0,1], top + wrap)

    output = page_preamble()
    output = output + tag('html', attrs[0], [0,1], head + body)

    return output


def page():
    """The Xhtml code of a complete page."""

    title       = 'The CentOS Project'
    keywords    = 'centos, project, community, enterprise, operating system'
    if 'app' in qs:
        title = title + ' :: ' + str(qs['app'][0]).capitalize()
    description = title

    print 'Content-type: text/html' + "\n"
    print page_wrap(title, keywords, description)
