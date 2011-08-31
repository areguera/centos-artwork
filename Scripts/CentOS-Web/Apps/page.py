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
        self.header += self.google()
        self.header += self.navibar()
        self.header += self.releases()
        self.header += self.page_links()
        self.header += self.page_navibar()

        # Define page body. This is the information displayed between
        # the page header and page footer.
        self.body = 'None'

        # Define page footer. This is the information displayed
        # between the page bottom and the page content, the last
        # information displayed in the page.
        self.footer = self.credits()


    def logo(self):
        """Returns The CentOS Logo.

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


    def google(self):
        """Returns Google advertisements (468x60 pixels)."""
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


    def navibar(self):
        """Returns top-level navigation bar. 
    
        The top-level navigation bar organizes links to main web
        applications The CentOS Project makes use of. Links to these
        web applications stay always visible, no matter what web
        application you be visiting (e.g., Wiki, Lists, Forums,
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

        The navigation tabs are the smaller components a navigation
        bar like "top-level navigation bar" and "application
        navigation bar" are made of.

        names: List containing link names of tabs.

        attrs: List containing a dictionary for each tab link name
            inside the `names' list. Dictionaries inside attrs
            argument contain the link attributes (e.g., accesskey,
            title, and href) used by link names so they can be
            linkable once rendered.
    
        focus: Name of the link marked as current.
    
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


    def releases(self, names=['6.0'], attrs=[{'href': '/centos-web/p=releases&id=6.0'}]):
        """Returns The CentOS Distribution last releases.

        This method introduces the `releases' method by providing
        links to it.

        names: List containing release numbers in the form M.N, where M
            means major release and N minor release.

        attrs: List containing a dictionary for each release number
            provided in `names' argument. These dictionaries provide
            the link attributes required by release numbers in order
            for them to be transformed into valid links once the page
            be rendered.
        
        """
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
        rsslink = self.tag_a({'href': '/centos-web/' + self.qs_args({'rss':'releases'}), 'title': 'RSS'}, [20,1], rsslink)
        rsslink = self.tag_span({'class': 'rss'}, [16,1], rsslink, 1)
        rsslink = self.tag_div({'class': 'right'}, [12, 1], rsslink, 1)

        return self.tag_div({'id': 'last-releases'}, [8,1], releases + rsslink, 1)


    def user_links_logs(self):
        """Return links related to user's logs.
        
        This function introduces the `logs' module. The `logs' module
        registers all user's activity, from login to logout. This link
        must be display/accessible only after a user has successfully
        login.

        """
        last_visit = self.tag_a({'href': '/centos-web/' + self.qs_args({'app':'', 'p':'logs'})}, [0,0], 'Logs')
        return self.tag_div({'class': 'logs'}, [12, 1], last_visit, 1)


    def user_links_session(self):
        """Returns links related to user's session.
        
        This function introduces the `session' module. The `session'
        module provides state to user interactions so their action can
        be registered individually.

        """
        names = []
        attrs = []
        session = ''

        names.append('Lost your password?')
        attrs.append({'href': '/centos-web/' + self.qs_args({'app':'', 'p':'lostpwd'})})
        names.append('Register')
        attrs.append({'href': '/centos-web/' + self.qs_args({'app':'', 'p':'register'})})
        names.append('Login')
        attrs.append({'href': '/centos-web/' + self.qs_args({'app':'', 'p':'login'})})

        for i in range(len(names)):
            output = self.tag_a(attrs[i], [20,1], str(names[i]), 0)
            if i == len(names) - 1:
                output = self.tag_span({'class': 'last'}, [16,1], output, 1)
            else:
                output = self.tag_span('', [16,1], output, 1)
            session += output

        return self.tag_div({'class': 'session'}, [12,1], session, 1)


    def user_links_trails(self, names=['None'], attrs=[{'href': '/centos-web/'}]):
        """Returns page trails (a.k.a. breadcrumbs).
    
        The page breadcrumbs record the last pages the user visited
        inside the current web application. Notice that page
        breadcrumbs are user-specific information, so it isn't
        possible to implement them until a way to manage user sessions
        be implemeneted inside `centos-web.cgi' script. Until then,
        keep the tag construction commented and return an empty value.

        names: List with trail link names.

        attrs: Dictionary with trail link attributes.

        """
        links = ''

        for i in range(len(names)):
            if i == len(names) - 1:
                content = self.tag_span({'class':'last'}, [16,1], self.tag_a(attrs[i], [20, 1], names[i]), 1)
            else:
                content = self.tag_span('', [16,1], self.tag_a(attrs[i], [20, 1], names[i], 0), 1)
            links += content

        return self.tag_div({'class': 'trail'}, [12,1], links, 1)


    def user_links(self):
        """Returns user related links.

        The user links are specific to each web application. They are
        shown over the application navigation bar.

        """
        userlinks = self.user_links_logs()
        userlinks += self.user_links_session()
        userlinks += self.user_links_trails()

        return self.tag_div({'class': 'userlinks'}, [8,1], userlinks, 1)


    def page_navibar(self, names=['Welcome'], attrs=[{'href':'/centos-web/?p=welcome'}], focus='Welcome'):
        """Returns navigation bar for application main pages.
       
        names: List containing link names.

        attrs: List containing one dictionary for each link name in
            `names' argument. Dictionaries here contain the link
            attributes needed to make linkable tabs once the page is
            rendered.

        """
        navibar_app = self.navibar_tabs(names, attrs, focus)
        navibar_app += self.separator({'class': 'page-line white'}, [8,1])

        return navibar_app
 

    def separator(self, attrs={'class': 'page-line'}, indent=[16,1]):
        """Returns separator.

        The separator construction is mainly used to clear both sides
        inside the page, specially when floating elements are around.
        
        attrs: Dictionary containing hr's div attributes.
        
        indent: List containing hr's div indentation values.
        
        """
        line = self.tag_hr({'style': 'display:none;'}, [0,0])
        line = self.tag_div(attrs, indent, line)

        return line


    def license(self):
        """Retruns license link."""
        license = 'Creative Commons Attribution-Share Alike 3.0 Unported License'
        license = self.tag_a({'href': 'http://creativecommons.org/licenses/by-sa/3.0/'}, [0,0], license) + '.'

        return license


    def metadata(self):
        """Returns metadata."""
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


    def qs_args(self, names={}):
        """Returns query string arguments.

        The query string arguments are used to build links dynamically
        and, this way, to create a browsable and logically organized
        web environment.  Such a construction generally needs to
        retrive some of the values previously passed to the query
        string and add new ones to it.

        names: A dictionary containing the variable name and value
            pair used to build a new query string. 
            
        When a variable is provied without a value, then its value is
        retrived from the current query string. If a value isn't found
        there neither, then the variable is removed from the new query
        string.

        When a variable is provided with its value, then its value is
        used to build the new query string.

        """
        output = ''
        names_keys = names.keys()
        names_keys.sort()
        for key in names_keys:
            if names[key] == '':
                if key in self.qs:
                    names[key] = self.qs[key][0]
                else:
                    continue
            if output == '':
                output = '?'
            else:
                output += '&'
            output += key + '=' + str(names[key])

        return output


    def search(self, size=20):
        """Returns search form.

        The search form redirects the search up to the search page. Is
        there, in the search page, where the search occurs.
        
        size: A number discribe how large the search text box is.

        """
        input = self.tag_input({'type':'text', 'value':'', 'size':size}, [24,1])

        action = self.tag_dt({}, [20,1], 'Search', 1)
        action += self.tag_dd({}, [20,1], input)
        output = self.tag_dl({'class':'search'}, [16,1], action, 1)
        return self.tag_form({'action':'/centos-web/' + self.qs_args({'app':'', 'p':'search'}), 'method':'post', 'title':'Search'}, [12,1], output, 1)
        

    def content_row(self, attrs, id, title, email, commit_date, update_date, category, comments, abstract):
        """Return row of content.

        The row of content is used to build the list of content and is
        made of the following information:

            attrs: (Required) A dictionary discribing the rows style.
                This is useful to alternate the row background colors.

            id: (Required) A unique numerical value referring the
                content identification. This is the value used on
                administrative tasks like updating and deleting.
        
            title: (Required) A few words phrase describing the
                content, up to 255 characters.
            
            author_email: (Required) A string referring the user email
                address, up to 255 characters. The user email address
                is used as id inside The CentOS User LDAP server,
                where user specific information (e.g., surname,
                lastname, office, phone, etc.) are stored in. This is
                the field that connects the user with the content
                he/she produces.
            
            commit_date: (Required). A string referring the date and
                time the author_email published the article for time.

            update_date: (Optional) A string representing the date and
                time the author_email updated/revised the article for
                last time.

            comments: (Required) A number representing the number of
                comments the content has received since its
                publication.

            category: (Required) A string refering the category name
                the author_email wrote the article for.

            abstract: (Optional) One or two paragraphs describing the
                article content. This information is used to build the
                page metadata information. When this value is not
                provided no abstract information is displayed in the
                page, but the <meta name="description".../> is built
                using article's first 255 characters.

        The article's content itself is not displayed in the content
        list view, but in the detailed view of content.

        """
        email = self.tag_a({'href':'mailto:' + email}, [0,0], email)
        title = self.tag_a({'href':'/centos-web/' + self.qs_args({'app':'', 'p':'', 'id':id})}, [0,0], title)
        title = self.tag_h3({'class': 'title'}, [20,1], title, 0)
        info = self.tag_span({'class':'author'}, [24,1], 'Written by ' + email)
        if update_date != commit_date:
            info += self.tag_span({'class':'date'}, [24,1], update_date)
        else:
            info += self.tag_span({'class':'date'}, [24,1], commit_date)
        if comments == 1:
            comments = self.tag_a({'href': self.qs_args({'app':'', 'p':'details', 'id':id}) + '#comments'}, [0,0], str(comments) + ' comment')
        elif comments > 1:
            comments = self.tag_a({'href': self.qs_args({'app':'', 'p':'', 'id':id}) + '#comments'}, [0,0], str(comments) + ' comments')
        else:
            comments = 'No comments'
        info += self.tag_span({'class':'comments'}, [24,1], comments)
        info = self.tag_div({'class': 'info'}, [20,1], info, 1)
        abstract = self.tag_p({'class': 'abstract'}, [20,1], abstract)

        return self.tag_div(attrs, [16,1], title + info + abstract, 1)


    def content_list(self, category='None.'):
        """Returns list of content.
        
        The list of content is used to explore the content available
        inside specific pages of specific web applications. The
        information is displayed through paginated rows of content
        that can be filtered to reduce the search results based on
        patterns.  By default, the list of content displays 15 rows,
        but this value can be changed in user's preferences.

        """
        output = ''
        count = 0
        rows = []
        rows.append((1, 'Introduction to CentOS Web Environment',
                    'al@centos.org',
                    'Tue Aug 30 12:33:11 CDT 2011',
                    'Tue Aug 30 12:33:11 CDT 2011',
                    'articles',
                    0,
                    'This is the abstrac paragrah of content. '*10))
        rows.append((2, 'Creating New Applications',
                    'al@centos.org',
                    'Tue Aug 30 12:33:11 CDT 2011',
                    'Tue Aug 30 12:33:11 CDT 2011',
                    'articles',
                    1,
                    'This is the abstrac paragrah of content. '*5))
        rows.append((3, 'Texinfo Documentation Backend',
                    'al@centos.org',
                    'Tue Aug 30 12:33:11 CDT 2011',
                    'Tue Aug 30 12:33:11 CDT 2011',
                    'articles',
                    5,
                    'This is the abstrac paragrah of content. '*8))

        for row in rows:
            if count == 0:
                attrs = {'class': 'dark row'}
                count += 1
            else:
                attrs = {'class': 'light row'}
                count = 0
            output += self.content_row(attrs, *row)

        content_list = self.tag_div({'id':'content-list'}, [12,1], output, 1)
        
        return content_list


    def content_list_2cols(self, category='None'):
        """Return list of content in two columns.
        
        The left column is for listing content and the right column to
        list related actions (e.g., search, categories, archives,
        etc.).

        """
        list = self.content_list()

        actions = self.search(15) + self.categories() + self.archives()
        actions = self.tag_div({'id':'content-actions'}, [8,1], actions, 1)

        return actions  + list


    def categories(self):
        """Returns list of categories.
        
        """
        categories = ['Articles', 'Erratas', 'Events']
        dt = self.tag_dt({}, [12,1], 'Categories')
        dd = ''
        for id in range(len(categories)):
            a = self.tag_a({'href': self.qs_args({'app':'', 'p':'categories', 'id':id})}, [16,1], categories[id] + ' (0)') 
            dd += self.tag_dd({}, [12,1], a, 1)

        return self.tag_dl({},[8,1], dt + dd, 1)


    def archives(self):
        """Returns archives."""
        archives = {}
        archives['2011'] = ['January', 'February', 'March', 'April', 'May']
        archives['2010'] = ['January', 'February']

        dt = self.tag_dt({}, [12,1], 'Archives')
        year_dl = ''
        year_dd = ''

        for key in archives.keys():
            year_dt = self.tag_dt({},[12,1], key, 1)
            for id in range(len(archives[key])):
                a = self.tag_a({'href': self.qs_args({'app':'',
                'p':'archives', 'year': key, 'month': id + 1})},
                [16,1], archives[key][id] + ' (0)')
                year_dd += self.tag_dd({}, [12,1], a)
            year_dl += self.tag_dl({'class':'year'}, [12,1], year_dt + year_dd, 1)
            year_dd = ''

        return self.tag_dl({},[8,1], dt + year_dl, 1)


    def page_top(self):
        """Returns page top anchor."""
        return self.tag_a({'name':'top'}, [0,1])


    def page_header(self):
        """Returns page header.
        
        The page_header is common to all application modules and 
        """
        return self.tag_div({'id': 'page-header'}, [4,1], self.header, 1)


    def page_body(self):
        """Returns page body.
        
        The page_body is specific to each application module and is
        there where it must be constructed. The construction itself
        takes place through the page_content() function which does
        a return through an instantiated `content_' prefixed method.
        The `content_' prefixed method used depends on the kind of
        content you want to print out (e.g., `content_list()' for a
        content list, `content_detail()' for a detailed view of
        content, etc.). Later, the `body' variable instantiated
        from this class is reset in the `main()' function with the value
        returned from `page_content()' so the desired content layout
        can be printed out. 
        
        """
        return self.tag_div({'id':'page-body'}, [4,1], self.body, 1)


    def page_links(self):
        """Returns page links."""
        page_links = self.user_links()
        return self.tag_div({'id': 'pagelinks'}, [8,1], page_links, 1)

    
    def page_footer(self):
        """Retruns page footer."""
        return self.tag_div({'id': 'page-footer'}, [4,1], self.credits(), 1)


    def page_wrap(self):
        """Returns page wrap."""
        return self.tag_div({'id': 'wrap'}, [0,1], self.page_header() + self.page_body() + self.page_footer(), 1)


    def admonition(self, title='Note', subtitle="", content=""):
        """Returns page admonition.
        
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
        html = self.doctype()
        html += self.tag_html({'xmlns': 'http://www.w3.org/1999/xhtml', 'dir': 'ltr', 
                         'lang': str(self.language), 'xml:lang': str(self.language)}, [0,1], 
                         self.metadata() + self.page_top() + self.page_wrap())

        return html
