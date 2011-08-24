#!/usr/bin/python
#
# Xhtml.output -- This module encapsulates XHTML output code needed by
# web applications.
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

def tag(name, attrs, indent=[8,1], content="", has_child=0):
    """Returns XHTML tag definition.

    Arguments:

    name: The XHTML tag's name. Notice that this function doesn't
        verify nor validate the XHTML tags you provide. It is up to
        you write them correctly considering the XHTML standard
        definition.

    attrs: The XHTML tag's attribute. Notice that this function
        doesn't verify the attributes assignation to tags. You need to
        know what attributes are considered valid to the tag you are
        creating in order to build a well-formed XHTML document. Such
        verification can be achived inside firefox browser through the
        `firebug' plugin.

    indent: The XHTML tag's indentation (Optional). This argument is a
        list of two numerical values. The first value in the list
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
    if indent[0] > 0:
        h_indent = ' '*indent[0]
    else:
        h_indent = ''

    if indent[1] > 0: 
        v_indent = "\n"*indent[1]
    else:
        v_indent = ''
    
    output = v_indent + h_indent + '<' + str(name)
    if len(attrs) > 0:
        attr_names = attrs.keys()
        attr_names.sort()
        for attr_name in attr_names:
            output += ' ' + str(attr_name) + '="' + str(attrs[attr_name]) + '"'
    if content == '':
        output += ' />'
    else:
        output += '>'
        output += str(content)
        if has_child == 1:
            output += h_indent + '</' + str(name) + '>'
        else:
            output += '</' + str(name) + '>'
    output += v_indent

    return output


def page_preamble():
    """Return XHTML code of page preamble.

    The page preamble sets the document type definition required by
    the XHTML standard.

    """
    output = '<?xml version="1.0"?>' + "\n"
    output += '<!DOCTYPE html' + "\n"
    output += ' '*4 + 'PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"' + "\n"
    output += ' '*4 + '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' + "\n"

    return output


def page_logo():
    """Returns XHTML code of page logo.

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
    """Returns XHTML code of Google advertisement (468x60 pixels).
    
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
    """Returns XHTML code of top-level navigation bar. 
    
    The top-level navigation bar organizes links to the web
    application The CentOS Project makes use of. Links in the
    top-level navigation bar remain always visible, no matter what web
    application you be visiting.

    Notice that web application differe one another and is not
    convenient to point them all to this definition. Instead, a
    specific definition for each web application will be created
    (based on this definition) in order for them to give the
    impression of being connected. In this process, the top-level
    navigation bar is adapted to each web application characteristics
    and the related tab is set as current.

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
    output += page_line({'class': 'page-line white'}, [8,1])

    return output


def page_navibar_tabs(names, attrs, focus="Home"):
    """Returns navigation tabs.

    Arguments:

    names: List of tab names.

    attrs: List of dictionaries for each tab name inside the `names'
        list. Dictionaries inside attrs argument contain the XHTML
        link attributes (e.g., accesskey, title, and href) used by tab
        names so they can be linkable once rendered.

    focus: Name of the tab marked as current. When no value is passed
        to this argument the `Home' value is used as default value.

    """
    navibar_tabs = ''

    for i in range(len(names)):
        content = tag('span', '', [0,0], str(names[i]))
        content = tag('a', attrs[i], [16,1], content)
        if str(names[i]).lower() == focus.lower():
            content = tag('span', {'class': 'current'}, [12,1], content, 1)
        else:
            content = tag('span', '', [12,1], content, 1)
        navibar_tabs += content

    return tag('div', {'class': 'tabs1'}, [8,1], navibar_tabs, 1)


def page_ads_release(image='ads-sample-728x90.png', description='Release Advertisement'):
    """Return last-release advertisement.
    
    The release advertisment is a 728x90 pixels image graphically
    designed to promote the last releases of The CentOS Distribution.
    This image is located on the header space, between the top-level
    links and application specific links. This image changes each time
    a new release is published from The CentOS Project and is only
    visible at home page (i.e., the first time shown when
    `http://www.centos.org/' domain is requested from a web browser).
    
    The place where the release advertisement is displayed on the web
    is an area of high visual impact, so images appearing therein
    should be carefully designed in consequence with it.  The
    frequency and priority of images in the rotation must be connected
    somehow with The CentOS Distribution releasing process.

    Previous to consider the release advertisement as such, it was
    reserved for sponsor advertisements. Nevertheless, sponsor
    advertisements were moved to a page to their own through a link in
    the top-level navegation bar.
    
    """
    attrs = []
    attrs.append({'class': 'ads-release'})
    attrs.append({'title': description, 'href': ''})
    attrs.append({'src': '/centos-web-pub/Images/' + image, 'alt': description})
    output = tag('div', attrs[0], [8,1], tag('a', attrs[1], [12,1], tag('img', attrs[2], [0,0], '', 0), 0), 1)

    return output


def page_userlinks(names=['Login'], attrs=[{'href': '/centos-web/?p=login'}]):
    """Returns user links.

    Arguments:

    names: List of links you want to have.

    attrs: List of dictionaries with link attributes. In order for
        links to be built correctly, both names and attrs lists must
        coincide their indexes.

    The user links are specific to each web application. They are
    shown in the right-top corner of the application navigation bar,
    just over the application navigation tabs.

    """
    userlinks = ''

    for i in range(len(names)):
        content = tag('a', attrs[i], [20,1], str(names[i]), 0)
        if i == len(names) - 1:
            content = tag('span', {'class': 'last'}, [16,1], content, 1)
        else:
            content = tag('span', '', [16,1], content, 1)
        userlinks += content 

    userlinks = tag('div', {'class': 'user'}, [12,1], userlinks, 1)

    return tag('div', {'class': 'links'}, [8,1], userlinks, 1)


def page_navibar_app(names=['Welcome'], attrs=[{'href':'/centos-web/?p=welcome'}]):
    """Returns application's navigation bar."""
    if 'p' in qs:
        focus = qs['p'][0]
    else:
        focus = names[0]

    navibar_app = page_navibar_tabs(names, attrs, focus)
    navibar_app += page_line({'class': 'page-line white'}, [8,1])

    return navibar_app
 

def page_breadcrumbs():
    """Returns page breadcrumbs.
    
    The page breadcrumbs record the last pages visited inside the
    current web application.

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

    for i in range(len(names)):
        if i == len(names) - 1:
            content = tag('span', {'class':'last'}, [16,1], tag('a', attrs[i], [20, 1], names[i]), 1)
        else:
            content = tag('span', '', [16,1], tag('a', attrs[i], [20, 1], names[i], 0), 1)
        links = links + content

    return tag('div', {'class': 'trail'}, [12,1], links, 1)


def page_line(attrs={'class': 'page-line'}, indent=[8,1]):
    """Returns a division line."""
    page_line = tag('hr', {'style': 'display:none;'}, [0,0])
    page_line = tag('div', attrs, indent, page_line)

    return page_line


def page_title(title='The CentOS Project'):
    """Returns page title."""
    title = 'The CentOS Project'
    if 'app' in qs.keys():
        title += ' :: ' + qs['app'][0].capitalize()
    return title


def page_language(language='en'):
    """Returns page language."""
    return language


def page_keywords(keywords):
    """Returns page keywords."""
    return keywords


def page_description(description):
    """Returns page description."""
    return description


def page_copyright(copyright_year, copyright_holder):
    """Returns page copyright."""
    return copyright_year + copyright_holder 


def page_license():
    """Retruns link to page license."""
    license = 'Creative Commons Attribution-Share Alike 3.0 Unported License.'
    license = tag('a', {'href': 'http://creativecommons.org/licenses/by-sa/3.0/'}, [0,0], license)
    return license


def page_metadata():
    """Returns page metadata."""
    metadata = tag('meta', {'http-equiv': 'content-type', 'content': 'text/html; charset=UTF-8'}, [4,1])
    metadata += tag('meta', {'http-equiv': 'content-style-type', 'content': 'text/css'}, [4,0])
    metadata += tag('meta', {'http-equiv': 'content-language', 'content': str(page_language())}, [4,1])
    metadata += tag('meta', {'name': 'keywords', 'content': str(page_keywords())}, [4,0])
    metadata += tag('meta', {'name': 'description', 'content': str(page_description())}, [4,1])
    metadata += tag('meta', {'name': 'copyright', 'content': 'Copyright © ' + str(page_copyright())}, [4,0])
    metadata += tag('title', '', [4,1], page_title())
    metadata += tag('link', {'href': '/centos-web-pub/stylesheet.css', 'rel': 'stylesheet', 'type': 'text/css', 
                            'media': 'screen projection'}, [4,1])

    return tag('head', '', [0,1], metadata)

def page_credits():
    """Returns page credits."""
    copyright = tag('p', {'class': 'copyright'}, [12,1], 'Copyright &copy; ' + str(page_copyright()))
    license = tag('p', {'class': 'license'}, [12,1], 'This website is licensed under a ' + str(page_license()))
    credits = tag('img', {'src': '/centos-web-pub/Images/top.png', 'alt': 'Top'}, [0,0])
    credits = tag('a', {'title': 'Top', 'href': '#top'}, [16,1], credits)
    credits = tag('div', {'class': 'top'}, [12,1], credits, 1)
    credits = str(credits) + str(copyright) + str(license) 
    credits = tag('div', {'class': 'credits'}, [8,1], credits, 1)

    return credits


def page_content():
    """Returns page content."""
    content = tag('h1', {'class': 'title'}, [12, 1], page_title())
    content += tag('p', '', [12, 1], 'No content found for this page.')
    return content


def page():
    """Returns page final output."""
    page_header = page_logo()
    page_header += page_ads_google()
    page_header += page_navibar_top()
    if not 'app' in qs:
        page_header += page_ads_release()
        page_header += page_userlinks()
        page_header += page_navibar_app()
    page_header = tag('div', {'id': 'page-header'}, [4,1], page_header, 1)

    page_body = page_content() + page_line(indent=[12,1])
    page_body = tag('div', {'id':'content'}, [8,1], page_body, 1)
    page_body = tag('div', {'id':'page-body'}, [4,1], page_body, 1)

    page_footer = page_line(indent=[4,1])
    page_footer += tag('div', {'id': 'page-footer'}, [4,1], page_credits(), 1)
    
    top = tag('a', {'name':'top'}, [0,1], '')
    wrap = tag('div', {'id': 'wrap'}, [0,1], page_header + page_body + page_footer)
    body = tag('body', '', [0,1], top + wrap)

    html = page_preamble()
    html += tag('html', {'xmlns': 'http://www.w3.org/1999/xhtml', 'dir': 'ltr', 
                         'lang': str(page_language()), 'xml:lang':
                         str(page_language())}, [0,1], page_metadata() +  body)

    return html


def main():
    """The Xhtml code of a complete page."""
    print 'Content-type: text/html' + "\n"
    print page()
