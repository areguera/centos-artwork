#!/usr/bin/python
#
# Apps.xhtml -- This module encapsulates XHTML output code needed by
# web applications.
#
# Copyright (C) 2011 The CentOS Project
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

class Page:


    def __init__(self):
        """Initialize page data."""
        self.qs = cgi.parse_qs(os.environ['QUERY_STRING'])
        self.name = 'Home'
        self.title = 'The CentOS Project'
        self.description = 'Community Enterprise Operating System'
        self.keywords = 'centos, project, community, enterprise, operating system'
        self.copyright = '2009-2011 The CentOS Project. All rights reserved.'
        self.language = 'en'


    def tag(self, name, attrs, indent=[8,1], content="", has_child=0):
        """Returns XHTML tag definition.

        Arguments:

        name: The XHTML tag's name. Notice that this function doesn't
            verify nor validate the XHTML tags you provide. It is up
            to you write them correctly considering the XHTML standard
            definition.

        attrs: The XHTML tag's attribute. Notice that this function
            doesn't verify the attributes assignation to tags. You
            need to know what attributes are considered valid to the
            tag you are creating in order to build a well-formed XHTML
            document. Such verification can be achived inside firefox
            browser through the `firebug' plugin.

        indent: The XHTML tag's indentation (Optional). This argument
            is a list of two numerical values. The first value in the
            list represents the amount of horizontal spaces between
            the beginning of line and the opening tag.  The second
            value in the list represents the amount of vertical spaces
            (new lines) between tags.

        content: The XHTML tag's content (Optional). This argument
            provides the information the tag encloses. When this
            argument is empty, tag is rendered without content.

        has_child: The XHTML tag has a child? (Optional). This
            argument is specifies whether a tag has another tag inside
            (1) or not (0).  When a tag has not a child tag,
            indentation is applied between the tag content and the
            closing tag provoking an unecessary spaces to be shown.
            Such kind of problems are prevented by setting this option
            to `0'. On the other hand, when a tag has a child tag
            inside, using the value `1' will keep the closing tag
            indentation aligned with the opening one.

        This function encapsulates the construction of XHTML tags.
        Use this function wherever you need to create XHTML tags. It
        helps to standardize tag constructions and their final output
        and, this way, produce consistent XHTML documents.
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


    def page_preamble(self):
        """Return XHTML code of page preamble.

        The page preamble sets the document type definition required
        by the XHTML standard.

        """
        output = '<?xml version="1.0"?>' + "\n"
        output += '<!DOCTYPE html' + "\n"
        output += ' '*4 + 'PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"' + "\n"
        output += ' '*4 + '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' + "\n"

        return output


    def page_logo(self):
        """Returns XHTML code of page logo.

        The page logo is displayed on the top-left corner of the page.
        We use this area to show The CentOS Logo, the main visual
        representation of The CentOS Project. In order to print the
        page logo correctly, the image related must be 78 pixels of
        height.

        """
        attrs = []
        attrs.append({'id': 'logo'})
        attrs.append({'title': 'Community Enterprise Operating System', 'href': '/centos-web/'})
        attrs.append({'src': '/centos-web-pub/Images/centos-logo.png', 'alt': 'CentOS'})

        return self.tag('div', attrs[0], [8,1], self.tag('a', attrs[1], [12,1], self.tag('img', attrs[2], [0,0], '', 0), 0), 1)


    def page_ads_google(self):
        """Returns XHTML code of Google advertisement (468x60 pixels)."""
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


    def page_navibar_top(self):
        """Returns XHTML code of top-level navigation bar. 
    
        The top-level navigation bar organizes links to the web
        application The CentOS Project makes use of. Links in the
        top-level navigation bar remain always visible, no matter what
        web application you be visiting.

        Notice that web application differe one another and is not
        convenient to point them all to this definition. Instead, a
        specific definition for each web application will be created
        (based on this definition) in order for them to give the
        impression of being connected. In this process, the top-level
        navigation bar is adapted to each web application
        characteristics and the related tab is set as current.

        """
        names = ['Home', 'Wiki', 'Lists', 'Forums', 'Projects', 'Bugs', 'Docs', 'Downloads', 'Sponsors']
        attrs = []
        focus = self.name

        for i in range(len(names)):
            attrs.append({'href': '/centos-web/?app=' + names[i].lower()})

        tabs = self.page_navibar_tabs(names, attrs, focus)
        tabs += self.page_line()

        return tabs


    def page_navibar_tabs(self, names, attrs, focus=''):
        """Returns navigation tabs.

        Arguments:

        names: List of tab names.

        attrs: List of dictionaries for each tab name inside the
            `names' list. Dictionaries inside attrs argument contain
            the XHTML link attributes (e.g., accesskey, title, and
            href) used by tab names so they can be linkable once
            rendered.
    
        focus: Name of the tab marked as current. When no value is
            passed to this argument the `Home' value is used as
            default value.
    
        """
        navibar_tabs = ''

        for i in range(len(names)):
            content = self.tag('span', '', [0,0], str(names[i]))
            content = self.tag('a', attrs[i], [16,1], content)
            if str(names[i]).lower() == focus.lower():
                content = self.tag('span', {'class': 'current'}, [12,1], content, 1)
            else:
                content = self.tag('span', '', [12,1], content, 1)
            navibar_tabs += content

        return self.tag('div', {'class': 'tabs'}, [8,1], navibar_tabs, 1)


    def page_lastreleases(self, names=['6.0'], attrs=[{'href': '/centos-web/?p=releases&id=6.0'}]):
        """Returns last-release information and related RSS link."""
        releases = ''

        title = self.tag('a', {'href': '/centos-web/?p=releases'}, [20,0], 'Last Releases') + ':'
        title = self.tag('span', {'class': 'title'}, [16,1], title, 1)

        for i in range(len(names)):
            link = self.tag('a', attrs[i], [20,1], names[i])
            if i == len(names) - 1:
                span = self.tag('span', {'class': 'last release'}, [16,1], link, 1) 
            else:
                span = self.tag('span', {'class': 'release'}, [16,1], link, 1) 
            releases += span
        releases = self.tag('div', {'class': 'left'}, [12,1], title + releases, 1)

        rsslink = self.tag('span', '', [20,1], 'RSS')
        rsslink = self.tag('a', {'href': '/centos-web/?print=rss', 'title': 'RSS'}, [16,1], rsslink)
        rsslink = self.tag('span', {'class': 'rss'}, [12,1], rsslink)
        rsslink = self.tag('div', {'class': 'right'}, [12, 1], rsslink, 1)

        return self.tag('div', {'id': 'last-releases'}, [8,1], releases + rsslink, 1)


    def page_appslinks(self):
        """Returns application related links."""
        appslinks = self.page_userlinks()
        return self.tag('div', {'id': 'appslinks'}, [8,1], appslinks, 1)


    def page_lastvisit(self):
        last_visit = self.tag('a', '', [16,0], 'Your last visit was at')
        last_visit = self.tag('span', {'class': 'title'}, [12, 1], last_visit, 1)
        last_visit += self.tag('span', {'class': 'datetime'}, [12, 1], '...', 1)
        return self.tag('div', {'class': 'lastvisit'}, [12, 1], last_visit, 1)


    def page_session(self):
        """Returns information related to user's session."""
        names = []
        attrs = []
        session = ''

        names.append('Lost your password?')
        attrs.append({'href': '/centos-web/?p=lostpwd'})
        names.append('Register')
        attrs.append({'href': '/centos-web/?p=register'})
        names.append('Login')
        attrs.append({'href': '/centos-web/?p=login'})

        for i in range(len(names)):
            output = self.tag('a', attrs[i], [20,1], str(names[i]), 0)
            if i == len(names) - 1:
                output = self.tag('span', {'class': 'last'}, [16,1], output, 1)
            else:
                output = self.tag('span', '', [16,1], output, 1)
            session += output

        return self.tag('div', {'class': 'session'}, [12,1], session, 1)


    def page_trail(self, names=['None'], attrs=[{'href': '/centos-web/'}]):
        """Returns page trails (a.k.a. breadcrumbs).
    
        The page breadcrumbs record the last pages visited inside the
        current web application. Notice that page breadcrumbs are
        user-specific information, so it isn't possible to implement
        them until a way to manage user sessions be implemeneted
        inside `centos-web.cgi' script. Until then, keep the tag
        construction commented and return an empty value.

        """
        links = ''

        for i in range(len(names)):
            if i == len(names) - 1:
                content = self.tag('span', {'class':'last'}, [16,1], self.tag('a', attrs[i], [20, 1], names[i]), 1)
            else:
                content = self.tag('span', '', [16,1], self.tag('a', attrs[i], [20, 1], names[i], 0), 1)
            links = links + content

        return self.tag('div', {'class': 'trail'}, [12,1], links, 1)


    def page_userlinks(self):
        """Returns user links.

        Arguments:

        names: List of links you want to have.

        attrs: List of dictionaries with link attributes. In order for
            links to be built correctly, both names and attrs lists
            must coincide their indexes.

        The user links are specific to each web application. They are
        shown in the right-top corner of the application navigation
        bar, just over the application navigation tabs.

        """
        userlinks = self.page_lastvisit()
        userlinks += self.page_session()
        userlinks += self.page_trail()

        return self.tag('div', {'class': 'userlinks'}, [8,1], userlinks, 1)


    def page_navibar_app(self, names=['Welcome'], attrs=[{'href':'/centos-web/?p=welcome'}], focus='Welcome'):
        """Returns application's navigation bar."""

        navibar_app = self.page_navibar_tabs(names, attrs, focus)
        navibar_app += self.page_line({'class': 'page-line white'}, [8,1])

        return navibar_app
 

    def page_line(self, attrs={'class': 'page-line'}, indent=[8,1]):
        """Returns a division line."""
        page_line = self.tag('hr', {'style': 'display:none;'}, [0,0])
        page_line = self.tag('div', attrs, indent, page_line)

        return page_line


    def page_license(self):
        """Retruns link to page license."""
        license = 'Creative Commons Attribution-Share Alike 3.0 Unported License'
        license = self.tag('a', {'href': 'http://creativecommons.org/licenses/by-sa/3.0/'}, [0,0], license) + '.'
        return license


    def page_metadata(self):
        """Returns page metadata."""
        metadata = self.tag('meta', {'http-equiv': 'content-type', 'content': 'text/html; charset=UTF-8'}, [4,1])
        metadata += self.tag('meta', {'http-equiv': 'content-style-type', 'content': 'text/css'}, [4,0])
        metadata += self.tag('meta', {'http-equiv': 'content-language', 'content': str(self.language)}, [4,1])
        metadata += self.tag('meta', {'name': 'keywords', 'content': str(self.keywords)}, [4,0])
        metadata += self.tag('meta', {'name': 'description', 'content': str(self.description)}, [4,1])
        metadata += self.tag('meta', {'name': 'copyright', 'content': 'Copyright © ' + str(self.copyright)}, [4,0])
        metadata += self.tag('title', '', [4,1], self.title)
        metadata += self.tag('link', {'href': '/centos-web-pub/stylesheet.css','rel': 'stylesheet', 'type': 'text/css'}, [4,1])
        metadata += self.tag('link', {'href': '/centos-web-pub/Images/centos-fav.png', 'rel': 'shortcut icon', 'type': 'image/png'}, [4,0])

        return self.tag('head', '', [0,1], metadata)


    def page_content(self, content='Page empty.'):
        """Returns page content."""
        return content


    def page_credits(self):
        """Returns page credits."""
        copyright = self.tag('div', {'class': 'copyright'}, [12,1], 'Copyright &copy; ' + str(self.copyright))
        license = self.tag('div', {'class': 'license'}, [12,1], 'This website is licensed under a ' + str(self.page_license()))
        credits = self.tag('img', {'src': '/centos-web-pub/Images/top.png', 'alt': 'Top'}, [0,0])
        credits = self.tag('a', {'title': 'Top', 'href': '#top'}, [16,1], credits)
        credits = self.tag('div', {'class': 'top'}, [12,1], credits, 1)
        credits = str(credits) + str(copyright) + str(license) 
        credits = self.tag('div', {'class': 'credits'}, [8,1], credits, 1)

        return credits


    def page(self):
        """Returns page final output."""
        page_header = self.page_logo()
        page_header += self.page_ads_google()
        page_header += self.page_navibar_top()
        page_header += self.page_lastreleases()
        page_header += self.page_appslinks()
        page_header += self.page_navibar_app()
        page_header = self.tag('div', {'id': 'page-header'}, [4,1], page_header, 1)

        page_body = self.page_content()
        page_body = self.tag('div', {'id':'content'}, [8,1], page_body, 1)
        page_body = self.tag('div', {'id':'page-body'}, [4,1], page_body, 1)

        page_footer = self.tag('div', {'id': 'page-footer'}, [4,1], self.page_credits(), 1)
    
        top = self.tag('a', {'name':'top'}, [0,1])
        wrap = self.tag('div', {'id': 'wrap'}, [0,1], page_header + page_body + page_footer, 1)
        body = self.tag('body', '', [0,1], top + wrap)

        html = self.page_preamble()
        html += self.tag('html', {'xmlns': 'http://www.w3.org/1999/xhtml', 'dir': 'ltr', 
                         'lang': str(self.language), 'xml:lang':
                         str(self.language)}, [0,1], self.page_metadata() +  body)

        return html


    def main(self):
        """The Xhtml code of a complete page."""
        print 'Content-type: text/html' + "\n"
        print self.page()
