#!/usr/bin/python
#
# Apps.page -- This module encapsulates the page layout of web
# applications.
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

import cgi
import cgitb; cgitb.enable()

from Apps import xhtml

class Layout(xhtml.Strict):
    """Xhtml page modeling."""


    def __init__(self):
        """Initialize page data."""
        self.qs = cgi.parse()
        self.name = 'Home'
        self.title = 'The CentOS Project'
        self.description = 'Community Enterprise Operating System'
        self.keywords = 'centos, project, community, enterprise, operating system'
        self.copyright = '2009-2011 The CentOS Project. All rights reserved.'
        self.language = 'en'

        # Define page header. This is the information displayed
        # between the page top and the page content.
        self.header = self.logo()
        self.header += self.ads_google()
        self.header += self.navibar_top()
        self.header += self.lastreleases()
        self.header += self.appslinks()
        self.header += self.navibar_app()

        # Define page body. This is the information displayed between
        # the page header and page footer.
        self.body = self.content()

        # Define page footer. This is the information displayed
        # between the page bottom and the page content, the last
        # information displayed in the page.
        self.footer = self.credits()

    def logo(self):
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

        return self.tag_div(attrs[0], [8,1], self.tag_a(attrs[1], [12,1], self.tag_img(attrs[2], [0,0]), 0), 1)


    def ads_google(self):
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


    def navibar_top(self):
        """Returns applications top-level navigation bar. 
    
        The top-level navigation bar organizes links to the web
        application The CentOS Project makes use of. Links in the
        top-level navigation bar remain always visible, no matter what
        web application you be visiting (e.g., Wiki, Lists, Forums,
        Projects, Bugs, Docs, Downloads and Sponsors.).

        """
        names = ['Home', 'Wiki', 'Lists', 'Forums', 'Projects', 'Bugs', 'Docs', 'Downloads', 'Sponsors']
        attrs = []
        focus = self.name

        for i in range(len(names)):
            if names[i].lower() == 'home':
                attrs.append({'href': '/centos-web/'})
            else:
                attrs.append({'href': '/centos-web/?app=' + names[i].lower()})

        tabs = self.navibar_tabs(names, attrs, focus)
        tabs += self.separator()

        return tabs


    def navibar_tabs(self, names, attrs, focus=''):
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
            content = self.tag_span('', [0,0], str(names[i]))
            content = self.tag_a(attrs[i], [16,1], content)
            if str(names[i]).lower() == focus.lower():
                content = self.tag_span({'class': 'current'}, [12,1], content, 1)
            else:
                content = self.tag_span('', [12,1], content, 1)
            navibar_tabs += content

        return self.tag_div({'class': 'tabs'}, [8,1], navibar_tabs, 1)


    def lastreleases(self, names=['6.0'], attrs=[{'href': '/centos-web/?p=releases&id=6.0'}]):
        """Returns last-release information and related RSS link."""
        releases = ''

        title = self.tag_a({'href': '/centos-web/?p=releases'}, [0,0], 'Last Releases') + ':'
        title = self.tag_span({'class': 'title'}, [16,1], title)

        for i in range(len(names)):
            link = self.tag_a(attrs[i], [20,1], names[i])
            if i == len(names) - 1:
                span = self.tag_span({'class': 'last release'}, [16,1], link, 1) 
            else:
                span = self.tag_span({'class': 'release'}, [16,1], link, 1) 
            releases += span
        releases = self.tag_div({'class': 'left'}, [12,1], title + releases, 1)

        rsslink = self.tag_span('', [0,0], 'RSS')
        rsslink = self.tag_a({'href': '/centos-web/?print=rss', 'title': 'RSS'}, [20,1], rsslink)
        rsslink = self.tag_span({'class': 'rss'}, [16,1], rsslink, 1)
        rsslink = self.tag_div({'class': 'right'}, [12, 1], rsslink, 1)

        return self.tag_div({'id': 'last-releases'}, [8,1], releases + rsslink, 1)


    def appslinks(self):
        """Returns application related links."""
        appslinks = self.userlinks()
        return self.tag_div({'id': 'appslinks'}, [8,1], appslinks, 1)


    def lastvisit(self):
        last_visit = self.tag_a({'href': '/centos-web/?p=lastvisit'}, [0,0], 'Your last visit was at')
        last_visit = self.tag_span({'class': 'title'}, [16, 1], last_visit)
        last_visit += self.tag_span({'class': 'datetime'}, [16, 1], '...')
        return self.tag_div({'class': 'lastvisit'}, [12, 1], last_visit, 1)


    def session(self):
        """Returns information related to user's session."""
        names = []
        attrs = []
        session = ''

        if 'app' in self.qs:
            app = 'app=' + self.qs['app'][0].lower() + '&'
        else:
            app = ''

        names.append('Lost your password?')
        attrs.append({'href': '/centos-web/?' + app + 'p=lostpwd'})
        names.append('Register')
        attrs.append({'href': '/centos-web/?' + app + 'p=register'})
        names.append('Login')
        attrs.append({'href': '/centos-web/?' + app + 'p=login'})

        for i in range(len(names)):
            output = self.tag_a(attrs[i], [20,1], str(names[i]), 0)
            if i == len(names) - 1:
                output = self.tag_span({'class': 'last'}, [16,1], output, 1)
            else:
                output = self.tag_span('', [16,1], output, 1)
            session += output

        return self.tag_div({'class': 'session'}, [12,1], session, 1)


    def trail(self, names=['None'], attrs=[{'href': '/centos-web/'}]):
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
                content = self.tag_span({'class':'last'}, [16,1], self.tag_a(attrs[i], [20, 1], names[i]), 1)
            else:
                content = self.tag_span('', [16,1], self.tag_a(attrs[i], [20, 1], names[i], 0), 1)
            links += content

        return self.tag_div({'class': 'trail'}, [12,1], links, 1)


    def userlinks(self):
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
        userlinks = self.lastvisit()
        userlinks += self.session()
        userlinks += self.trail()

        return self.tag_div({'class': 'userlinks'}, [8,1], userlinks, 1)


    def navibar_app(self, names=['Welcome'], attrs=[{'href':'/centos-web/?p=welcome'}], focus='Welcome'):
        """Returns application's navigation bar."""

        navibar_app = self.navibar_tabs(names, attrs, focus)
        navibar_app += self.separator({'class': 'page-line white'}, [8,1])

        return navibar_app
 

    def separator(self, attrs={'class': 'page-line'}, indent=[16,1]):
        """Returns a division line."""
        line = self.tag_hr({'style': 'display:none;'}, [0,0])
        line = self.tag_div(attrs, indent, line)

        return line


    def license(self):
        """Retruns link to page license."""
        license = 'Creative Commons Attribution-Share Alike 3.0 Unported License'
        license = self.tag_a({'href': 'http://creativecommons.org/licenses/by-sa/3.0/'}, [0,0], license) + '.'

        return license


    def metadata(self):
        """Returns page metadata."""
        metadata = self.tag_meta({'http-equiv': 'content-type', 'content': 'text/html; charset=UTF-8'}, [4,1])
        metadata += self.tag_meta({'http-equiv': 'content-style-type', 'content': 'text/css'}, [4,0])
        metadata += self.tag_meta({'http-equiv': 'content-language', 'content': str(self.language)}, [4,1])
        metadata += self.tag_meta({'name': 'keywords', 'content': str(self.keywords)}, [4,0])
        metadata += self.tag_meta({'name': 'description', 'content': str(self.description)}, [4,1])
        metadata += self.tag_meta({'name': 'copyright', 'content': 'Copyright © ' + str(self.copyright)}, [4,0])
        metadata += self.tag_title('', [4,1], self.title)
        metadata += self.tag_link({'href': '/centos-web-pub/stylesheet.css','rel': 'stylesheet', 'type': 'text/css'}, [4,0])
        metadata += self.tag_link({'href': '/centos-web-pub/Images/centos-fav.png', 'rel': 'shortcut icon', 'type': 'image/png'}, [4,1])

        return self.tag_head('', [0,1], metadata)


    def content(self, content='Page empty.'):
        """Returns page content."""
        return content


    def admonition(self, title='Note', subtitle="", content=""):
        """Returns page admonition.
        
        Arguments:

        title: Admonition's title.

        subtitle: Admonition's subtitle. The value of this argument is
            concatenated on the right side of title using a colon (:)
            as separator. Notice that this value is expanded inside
            the <h3> tag and there is no need to introduce extra tags
            here.

        content: Admonition's content. The values passed through this
            arguments needs to be XHTML code returned from
            `self.tag()'. Preferably, paragraphs (p), tables (table),
            lists (ul, ol, dl) and pre-formatted texts (pre).

        """
        if title == '':
            return ''
        else:
            title = str(title.capitalize())

        if subtitle != '':
            subtitle = ': ' + str(subtitle.capitalize())

        if content != '':
            content = str(content)

        admonitions = ['Note', 'Tip', 'Important', 'Caution', 'Warning', 'Redirected', 'Success', 'Error']
        
        if title in admonitions:
            attrs = {'class': 'admonition ' + title.lower()}
            image = self.tag_img({'src': '/centos-web-pub/Images/' + title.lower() + '.png', 'alt': title}, [16,1])
            title = self.tag_h3({'class': 'title'}, [16,1], title + subtitle, 0)
            output = image + title + content + self.separator()
        else:
            attrs = {'class': 'admonition unknown'}
            title = self.tag_h3({'class': 'title'}, [16,1], title + subtitle, 1)
            output = title + content
        
        return self.tag_div(attrs, [12,1], output, 1)


    def credits(self):
        """Returns page credits."""
        copyright = self.tag_p({'class': 'copyright'}, [12,1], 'Copyright &copy; ' + str(self.copyright))
        license = self.tag_p({'class': 'license'}, [12,1], 'This website is licensed under a ' + str(self.license()))
        credits = self.tag_img({'src': '/centos-web-pub/Images/top.png', 'alt': 'Top'}, [0,0])
        credits = self.tag_a({'title': 'Top', 'href': '#top'}, [16,1], credits)
        credits = self.tag_div({'class': 'top'}, [12,1], credits, 1)
        credits = str(credits) + str(copyright) + str(license) 
        credits = self.tag_div({'class': 'credits'}, [8,1], credits, 1)

        return credits


    def page(self):
        """Returns page final output."""
        header = self.tag_div({'id': 'page-header'}, [4,1], self.header, 1)
        top = self.tag_a({'name':'top'}, [0,1])
        body = self.tag_div({'id':'content'}, [8,1], self.body, 1)
        body = self.tag_div({'id':'page-body'}, [4,1], body, 1)
        footer = self.tag_div({'id': 'page-footer'}, [4,1], self.credits(), 1)
        wrap = self.tag_div({'id': 'wrap'}, [0,1], header + body + footer, 1)
        body = self.tag_body('', [0,1], top + wrap)
        html = self.doctype()
        html += self.tag_html({'xmlns': 'http://www.w3.org/1999/xhtml', 'dir': 'ltr', 
                         'lang': str(self.language), 'xml:lang':
                         str(self.language)}, [0,1], self.metadata() +  body)

        return html
