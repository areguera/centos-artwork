# Copyright (C) 2011 The CentOS Project
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
"""Support page construction.

The page construction is an XHTML document consisting of several
independent components that, when put together, provide organization
to content. Each of these components is set as a method of Layout
class that can be instantiated later from application specific modules.

When you create a new application package, you need to create a page
module for it and instantiate the Layout class provided here inside
it.  Later, the following functions must be created: page_content(),
page_navibar() and main(). These functions are used to define the
content and navigation bar of your application. Both application
content and application navigation are logically organized using
variables passed through the URL.

Application
===========

URL variable: app

This variable contains the application id. It is a unique numerical
value that starts at 0 and increments one for each new application
that might be added. The application identified by number 0 is the one
used as default when no other application is provided.  The
application identified by number 0 is added to database the first time
it is created as part of the initial configuration process.

Application is the highest level of organization inside
`webenv.cgi' script. Inside applications, there is content in form
of pages and entries. Content can be grouped by categories.

Pages
=====

URL variable: page

This variable contains the page id. It is a unique numerical value
that starts at 0 and increments in one for each new page added to the
application. In contrast to applications, the page identified by
number 0 is not used as default page when no other page is provided.
This configuration is specific to each application and can be
customized inside each application individually, using string values
instead of numerical values when passing values to page variable.

Generally, when a page variable isn't passed through the URL, the
application module uses the `content_list()' method from Layout class
to display a list of all available content entries while links to
content pages are displayed in the application navigation bar so users
can access them.  The unique numerical value of content pages is
specific to each application, so there is one page 0 for each
application available. No page is added to database the first time the
database is created as part of the initial configuration process.

Pages contain similar information to that described by contents with
few exceptions. Pages, in contrast to entries, can differentiate the
page title from the page name. The page title goes in the page content
itself and describes what the page is about with a phrase. On the
other hand, the page name is generaly one word describing the page
content and is used as link on the application navigation bar.  When
no page name is explicitly provided, the first word of page title is
used instead.
    
Pages are always accessible inside the same application while contents
aren't.  Pages are permanently visible and linkend from each
application specific navigation bar.  This kind of pages can be
managed by editors or administrators and can be marked as `draft' to
put it on a special state where it is possible for administrator,
editors and authors to work on it, but impossible for others to read
it until the page be marked as `published' by either the page author
or any members of editor's or administrator's groups.

Pages can be converted to entires and the oposite. When convertion
occurs, unused information looses its meaning and is kept for
informative purpose, specially in situations when it might be needed
to realize a convertion back into the former state. Notice that in
order to realize such a back and forth convertion it is required that
both pages and entires share the same definition structure.  In fact,
that they be the same thing, but able to differentiate themselves
either as page or entry (e.g., through a `type' field.).

Pages content is under version control. When a page (or entry) is
changed, a verification is performed to determine whether the
information entered in edition matches the last record in the page
history table. When both the information coming from edition and the
last record in the page history table are the same (e.g., no change
happened) the edition action is cancelled and a message is printed out
to notify the action.  Otherwise, when the information entered in
edition differs from the last record in the page history table, the
information comming from edition passes to be the last record in the
page history table.  In case, a page be reverted to a revision
different to that one being currently the active page, the reverted
revision becomes the active page (e.g., by changing a `status' field
from `false' to `true' in the history table).

Categories
==========

Categories exists to organize contents. When an entry is created it is
automatically linked to a category. Categories are managed by
administrators and editors only. Categories can be nested one another
and provide another way of finding information inside the web
environment.  Categories are specific to each web application, just as
contents and pages are. The `Unknown' category is created when the
categories table is created for first time, as part of the initial
configuration process so if no explicit category assignation is set by
the user, a default value (the `Unknown' category in this case) is
used to satisfy the connection between contents and categories.

Referential integrity
=====================

Referential integrity is not handle in the logic layer provided by
this module, but set inside the database system used to store the
information handled by this module. The most we do about it here, is
to display a confirmation message before committing such actions, so
you can be aware of them.

"""

import cgi
import cgitb; cgitb.enable()
from Apps import xhtml

qs = cgi.parse()


def qs_args( names={}):
    """Returns query string arguments.

    The query string arguments are used to build links dynamically
    and, this way, to create a browsable and logically organized web
    environment.  Such a construction generally needs to retrive some
    of the values previously passed to the query string and add new
    ones to it.

    names: A dictionary containing the variable name and value pair
        used to build a new query string. 
            
    When a variable is provied without a value, then its value is
    retrived from the current query string. If a value isn't found
    there neither, then the variable is removed from the new query
    string.

    When a variable is provided with its value, then its value is used
    to build the new query string.

    """
    output = ''

    names_keys = names.keys()
    names_keys.sort()
    for key in names_keys:
        if names[key] == '':
            if key in qs:
                names[key] = qs[key][0]
            else:
                continue
        if output == '':
            output = '?'
        else:
            output += '&amp;'
        output += key + '=' + str(names[key])

    return '/webenv/' + output


class Layout(xhtml.Strict):
    """The Page Layout.
    
    The page layout is made by combining XHTML tags in specific ways.
    These specific combinations make the page components which in turn
    can be also combined. Some of these components can be reused and
    others don't. The goal of this class is to define what such
    components are and describe them well in order to understand how
    to use them from application modules when building XHTML documents
    dynamically.

    The page layout is initialized with a functional layout that can
    be used as reference inside application modules, to create
    variations of it. Generally, inside application packages, this
    class is instantiated in a module named `page', variables are
    reset and functions created in order to satisfy that application
    needs. When you need to output one of the page components then you
    use this class instantiated methods. When the method you need
    doesn't exist in this class, then it is a good time for it to be
    created, here ;). 

    Notice that most methods defined in this class make direct use of
    methods defined by Strict class inside the `xhtml' module. The
    Strict class inside xhtml module is inherited inside this class so
    all the methods there are also available here. Methods which
    doesn't make a direct use of Strict methods are dependencies of
    those which do make direct use of Strict methods.

    """


    def __init__(self):
        """Initialize page data."""
        self.name = 'Home'
        self.title = 'The CentOS Project'
        self.description = 'Community Enterprise Operating System'
        self.keywords = 'centos, project, community, enterprise, operating system'
        self.copyright = '2009-2011 The CentOS Project. All rights reserved.'
        self.language = 'en'

        # Define page header. This is the information displayed
        # between the page top and the page content.
        self.header = self.logo()
        self.header += self.google_ad()
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
        attrs.append({'title': 'Community Enterprise Operating System', 'href': '/webenv/'})
        attrs.append({'src': '/public/Images/centos-logo.png', 'alt': 'CentOS'})

        return self.tag_div(attrs[0], [8,1], self.tag_a(attrs[1], [12,1], self.tag_img(attrs[2], [0,0]), 0), 1)


    def google_ad_example(self):
        """Returns Google advertisement for offline testings."""
        title = 'Google Advertisement'
        url = '/public/Images/ads-sample-468x60.png'
        image = self.tag_img({'src': url, 'alt': title}, [0,0])
        link = self.tag_a({'href': url, 'title': title}, [12,1], image)
        output = self.tag_div({'class':'google-ad'}, [8,1], link, 1)
        output += self.separator({'class':'page-line'}, [8,1])

        return output


    def google_ad(self):
        """Returns Google advertisement for online using."""

        properties = {}
        properties['google_ad_client']    = 'pub-6973128787810819'
        properties['google_ad_width']     = '468'
        properties['google_ad_height']    = '60'
        properties['google_ad_format']    = '468x60_as'
        properties['google_ad_type']      = 'text_image'
        properties['google_ad_channel']   = ''
        properties['google_color_border'] = '204c8d'
        properties['google_color_bg']     = '345c97'
        properties['google_color_link']   = '0000FF'
        properties['google_color_text']   = 'FFFFFF'
        properties['google_color_url']    = '008000'

        attrs = {}
        attrs['type'] = "text/javascript"

        output = '<!--\n'
        for key, value in properties.iteritems():
            output += ' '*16 + key + '="' + value + '";\n'
        output += ' '*16 + '//-->\n'

        properties = self.tag_script(attrs, [12,1], output, 1)

        attrs['src'] = "http://pagead2.googlesyndication.com/pagead/show_ads.js"

        source = self.tag_script(attrs, [12,1], ' ', 0)

        output = self.tag_div({'class':'google-ad'}, [8,1], properties + source, 1)
        output += self.separator({'class':'page-line'}, [8,1])

        return output


    def navibar(self):
        """Returns webenv navigation bar. 
    
        The webenv navigation bar organizes links to main web
        applications The CentOS Project makes use of. Links to these
        web applications stay always visible, no matter what web
        application the user be visiting (e.g., Wiki, Lists, Forums,
        Projects, Bugs, Docs, Downloads and Sponsors.).  Notice that
        some of these web applications are out of `webenv.cgi'
        scope and they need to code their own webenv navigation bars
        in a way that coincide the one set by `webenv.cgi'.

        """
        names = ['Home', 'Wiki', 'Lists', 'Forums', 'Projects', 'Bugs', 'Docs', 'Downloads', 'Sponsors']
        attrs = []
        focus = self.name

        for i in range(len(names)):
            if names[i].lower() == 'home':
                attrs.append({'href': '/webenv/'})
            else:
                attrs.append({'href': '/webenv/?app=' + names[i].lower()})

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
            output = self.tag_span('', [0,0], str(names[i]))
            output = self.tag_a(attrs[i], [16,1], output)
            if str(names[i]).lower() == focus.lower():
                output = self.tag_span({'class': 'current'}, [12,1], output, 1)
            else:
                output = self.tag_span('', [12,1], output, 1)
            navibar_tabs += output

        return self.tag_div({'class': 'tabs'}, [8,1], navibar_tabs, 1)


    def releases(self):
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

        names = []
        names.append('6.0')

        attrs = []
        attrs.append({'href': qs_args({'p':'releases', 'id': 6.0})})

        
        title = self.tag_a({'href': qs_args({'p':'releases'})}, [0,0], 'Last Releases') + ':'
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
        rsslink = self.tag_a({'href': qs_args({'rss':'releases'}), 'title': 'RSS'}, [20,1], rsslink)
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
        last_visit = self.tag_a({'href': qs_args({'app':'', 'p':'logs'})}, [0,0], 'Logs')
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
        attrs.append({'href': qs_args({'app':'', 'p':'lostpwd'})})
        names.append('Register')
        attrs.append({'href': qs_args({'app':'', 'p':'register'})})
        names.append('Login')
        attrs.append({'href': qs_args({'app':'', 'p':'login'})})

        for i in range(len(names)):
            output = self.tag_a(attrs[i], [20,1], str(names[i]), 0)
            if i == len(names) - 1:
                output = self.tag_span({'class': 'last'}, [16,1], output, 1)
            else:
                output = self.tag_span('', [16,1], output, 1)
            session += output

        return self.tag_div({'class': 'session'}, [12,1], session, 1)


    def user_links_trails(self, names=['None'], attrs=[{'href': '/webenv/'}]):
        """Returns page trails (a.k.a. breadcrumbs).
    
        The page breadcrumbs record the last pages the user visited
        inside the current web application. Notice that page
        breadcrumbs are user-specific information, so it isn't
        possible to implement them until a way to manage user sessions
        be implemeneted inside `webenv.cgi' script. Until then,
        keep the tag construction commented and return an empty value.

        names: List with trail link names.

        attrs: Dictionary with trail link attributes.

        """
        links = ''

        for i in range(len(names)):
            if i == len(names) - 1:
                output = self.tag_span({'class':'last'}, [16,1], self.tag_a(attrs[i], [20, 1], names[i]), 1)
            else:
                output = self.tag_span('', [16,1], self.tag_a(attrs[i], [20, 1], names[i], 0), 1)
            links += output

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


    def page_navibar(self, names=['Welcome'], attrs=[{'href':'/webenv/?p=welcome'}], focus='Welcome'):
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
        metadata += self.tag_link({'href': '/public/stylesheet.css','rel': 'stylesheet', 'type': 'text/css'}, [4,0])
        metadata += self.tag_link({'href': '/public/centos-fav.png', 'rel': 'shortcut icon', 'type': 'image/png'}, [4,1])

        return self.tag_head('', [0,1], metadata)




    def searchform(self, size=15):
        """Returns search form.

        The search form redirects user from the current page onto the
        search page, where the keywords previously introduced in the
        input field are processed then.
        
        size: A number discribing how large the search box is.

        """
        input = self.tag_input({'type':'text', 'value':'', 'size':size}, [0,0])

        action = self.tag_dt({}, [20,1], 'Search')
        action += self.tag_dd({}, [20,1], input)
        action = self.tag_dl({'class':'search'}, [16,1], action, 1)

        return self.tag_form({'action': qs_args({'app':'', 'p':'search'}), 
                              'method':'post', 'title':'Search'},
                              [12,1], action, 1)
        

    def content_resumen(self, attrs, id, title, user_id, commit_date,
                        update_date, category_id, comments, abstract):
        """Returns content resumen.

        The content resumen is used to build the list of contents,
        output by `content_list()' method. The content resumen intends
        to be concise and informative so the user can grab a general
        idea about the related content and what it is about.

        attrs: A dictionary discribing the rows style.  This is useful
            to alternate the row background colors.

        id: A unique numerical value referring the content
            identification. This is the value used on administrative
            tasks like updating and deleting.
        
        title: A few words phrase describing the content, up to 255
            characters.
            
        author_id: A string referring the user email address, as
            specified by RFC2822. The user email address is used as id
            inside The CentOS User LDAP server, where user specific
            information (e.g., surname, lastname, office, phone, etc.)
            are stored in. This is the field that bonds the user with
            the content he/she produces.
            
        commit_date: A string referring the timestamp the content
            arrived to database for time.

        update_date: A string representing the timestamp the content
            was updated/revised for last time.

        category_id: A number refering the category id the content is
            attached to.

        abstract: One paragraphs describing the content.  This
            information is used to build the page metadata
            information. When this value is not provided no abstract
            information is displayed in the page, but the <meta
            name="description".../> is built using article's first 255
            characters.

        comments: A number representing how many comments the content
            has received since it is in the database.

        The content itself is not displayed in the resumen, but in
        `content_details()'.

        """
        title = self.tag_a({'href': qs_args({'app':'', 'p':'entry', 'id':id})}, [0,0], title)
        title = self.tag_h3({'class': 'title'}, [20,1], title, 0)
        info = self.content_info(id, user_id, commit_date,
                                 update_date, category_id, comments,
                                 abstract)
        return self.tag_div(attrs, [16,1], title + info, 1)


    def pagination(self):
        """Return content pagination."""
        previous = self.tag_a({'href':''}, [0,0], 'Previous')
        previous = self.tag_span({'class':'previous'}, [20,1], previous)
        next = self.tag_a({'href':''}, [0,0], 'Next')
        next = self.tag_span({'class':'next'}, [20,1], next)
        separator = self.separator({'class':'page-line'}, [20,1])
        return self.tag_div({'class':'pagination'}, [16,1], previous +
                            next + separator, 1)


    def content_info(self, content_id, user_id, commit_date,
                     update_date, category_id, comments, abstract):
        """Return content information.

        The content information provides a reduced view of content so
        people can make themselves an idea of what the content talks
        about. The content information displays content's title,
        author, timestamp, related category, number of comments and an
        abstract of the whole content.

        """
        categories = []
        categories.append('Unknown')
        categories.append('Erratas')
        categories.append('Articles')
        categories.append('Events')

        if category_id <= len(categories):
            category_name = categories[category_id].capitalize()
        else:
            category_id = 0
            category_name = categories[category_id].capitalize()

        category_name = self.tag_a({'href': qs_args({'app':'', 'p':'categories', 'id':category_id})}, [0,0], category_name)
        category_name = self.tag_span({'class':'category'}, [24,1], category_name) 

        users = {}
        users['al@centos.org'] = 'Alain Reguera Delgado'
        users['ana@centos.org'] = 'Ana Tamara Reguera Gattorno'
        users['alina@centos.org'] = 'Alina Reguera Gattorno'

        if user_id in users.keys():
            user_name = self.tag_a({'href':'mailto:' + user_id}, [0,0], users[user_id])
            user_name = self.tag_span({'class':'author'}, [24,1], 'Written by ' + user_name)

        if update_date != commit_date:
            date = self.tag_span({'class':'date'}, [24,1], update_date)
        else:
            date = self.tag_span({'class':'date'}, [24,1], commit_date)

            
        comments_attrs = {'href': qs_args({'app':'', 'p':'entry', 'id':content_id}) + '#comments'}
        if comments == 1:
            comments = self.tag_a(comments_attrs, [0,0], str(comments) + ' comment')
        elif comments > 1:
            comments = self.tag_a(comments_attrs, [0,0], str(comments) + ' comments')
        else:
            comments = 'No comments'
        comments = self.tag_span({'class':'comment'}, [24,1], comments)

        abstract = self.tag_p({'class':'abstract'}, [24,1], abstract)

        return self.tag_div({'class': 'info'}, [20,1], user_name + date + category_name + comments + abstract, 1)


    def content_list(self):
        """Return list of content.
        
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
        rows.append([0, 'Introduction to CentOS Web Environment',
                    'al@centos.org',
                    '2011-8-30 12:33:11', 
                    '2011-8-30 12:33:11', 
                    0,
                    0,
                    'This is the abstract paragrah of content. '*10])
        rows.append([1, 'Creating New Applications',
                    'al@centos.org',
                    '2011-8-30 12:33:11', 
                    '2011-8-30 12:33:11', 
                    2,
                    1,
                    'This is the abstract paragrah of content. '*5])
        rows.append([2, 'Texinfo Documentation Backend',
                    'al@centos.org',
                    '2011-8-30 12:33:11', 
                    '2011-8-30 12:33:11', 
                    1,
                    5,
                    'This is the abstract paragrah of content. '*8])

        for row in rows:
            if count == 0:
                attrs = {'class': 'dark row'}
                count += 1
            else:
                attrs = {'class': 'light row'}
                count = 0
            output += self.content_resumen(attrs, *row)

        list = output + self.pagination() + self.separator()
        list = self.tag_div({'id':'content-list'}, [12,1], list, 1)
        actions = self.searchform() + self.categories() + self.archives()
        actions = self.tag_div({'id':'content-actions'}, [8,1], actions, 1)

        return actions + list


    def content_details(self):
        """Return content details.
        
        The content detail is shown for contents and pages.
        """
        output = ''
        rows = []
        rows.append([0, 'Introduction to CentOS Web Environment',
                    'al@centos.org',
                    '2011-8-30 12:33:11', 
                    '2011-8-30 12:33:11', 
                    0,
                    0,
                    'This is the abstract paragrah of content. '*10,
                    'This is the first paragraph of content'*10 + "\n"
                    'This is the second paragraph of content'*20 +
                    "\n" + 'This is the third paragraph of content.'*10 + "\n"])
        rows.append([1, 'Creating New Applications',
                    'al@centos.org',
                    '2011-8-30 12:33:11', 
                    '2011-8-30 12:33:11', 
                    2,
                    1,
                    'This is the abstract paragrah of content. '*5,
                    "This is the first paragraph of content\n\
                    This is the second paragraph of content.\n\
                    This is the third paragraph of content."])
        rows.append([2, 'Texinfo Documentation Backend',
                    'al@centos.org',
                    '2011-8-30 12:33:11', 
                    '2011-8-30 12:33:11', 
                    1,
                    5,
                    'This is the abstract paragrah of content. '*8,
                    "This is the first paragraph of content.\n\
                    This is the second paragraph of content.\n\
                    This is the third paragraph of content."])

        if 'id' in qs:
            id = int(qs['id'][0])
            title = rows[id][1]
            email = rows[id][2]
            commit_date = rows[id][3]
            update_date = rows[id][4]
            category = rows[id][5]
            comments = rows[id][6]
            abstract = self.tag_p({}, [0,0], rows[id][7])

            output = self.tag_h1({'class':'title'}, [12,1], title)
            output += self.content_info(id, email, commit_date, update_date, category, comments, abstract)
            output += self.tag_p({}, [20,1], rows[id][8])
            output += self.comments()

        return self.tag_div({'id':'content-details'}, [12,1], output, 1)


    def comments(self):
        """Returns content specific list of comments.

        """
        output = self.tag_a({'name':'comments'}, [0,0], 'Comments')
        output = self.tag_h2({'class':'title comments'}, [12,1], output, 0) 

        return output


    def categories(self):
        """Returns list of categories.
        
        """
        categories = ['Unknown', 'Articles', 'Erratas', 'Events']
        dt = self.tag_dt({}, [16,1], 'Categories')
        dd = ''
        for id in range(len(categories)):
            category_attrs = {'href': qs_args({'app':'', 'p':'categories', 'id':id})}
            a = self.tag_a(category_attrs, [0,0], categories[id] + ' (0)') 
            dd += self.tag_dd({}, [16,1], a)

        return self.tag_dl({},[12,1], dt + dd, 1)


    def archives(self):
        """Returns archives."""
        archives = {}
        archives['2011'] = ['January', 'February', 'March', 'April', 'May']
        archives['2010'] = ['January', 'February']

        dt = self.tag_dt({}, [16,1], 'Archives')
        year_dl = ''
        year_dd = ''

        for key in archives.keys():
            year_dt = self.tag_dt({},[20,1], key)
            for id in range(len(archives[key])):
                a = self.tag_a({'href': qs_args({'app':'', 'p':'archives', 'year': key, 'month': id + 1})}, [0,0], archives[key][id] + ' (0)')
                year_dd += self.tag_dd({}, [20,1], a)
            year_dl += self.tag_dl({'class':'year'}, [16,1], year_dt + year_dd, 1)
            year_dd = ''

        return self.tag_dl({},[12,1], dt + year_dl, 1)


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
        takes place through the `page_content()' function which does a
        return through an instantiated `content_' prefixed method.
        The `content_' prefixed method used depends on the kind of
        content you want to print out (e.g., `content_list()' for a
        content list, `detail()' for a detailed view of content,
        etc.). Later, the `body' variable instantiated from this class
        is reset in the `main()' function with the value returned from
        `page_content()' so the desired content layout can be printed
        out. 
        
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


    def admonition(self, title='Note', subtitle="", body=""):
        """Returns page admonition.
        
        title: Admonition's title.

        subtitle: Admonition's subtitle. The value of this argument is
            concatenated on the right side of title using a colon (:)
            as separator. Notice that this value is expanded inside
            the <h3> tag and there is no need to introduce extra tags
            here.

        body: Admonition's body. The values passed through this
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

        if body != '':
            body = str(body)

        admonitions = ['Note', 'Tip', 'Important', 'Caution', 'Warning', 'Redirected', 'Success', 'Error']
        
        if title in admonitions:
            attrs = {'class': 'admonition ' + title.lower()}
            image = self.tag_img({'src': '/public/Images/' + title.lower() + '.png', 'alt': title}, [16,1])
            title = self.tag_h3({'class': 'title'}, [16,1], title + subtitle, 0)
            output = image + title + body + self.separator()
        else:
            attrs = {'class': 'admonition unknown'}
            title = self.tag_h3({'class': 'title'}, [16,1], title + subtitle, 1)
            output = title + body
        
        return self.tag_div(attrs, [12,1], output, 1)


    def credits(self):
        """Returns page credits."""
        copyright = self.tag_p({'class': 'copyright'}, [12,1], 'Copyright &copy; ' + str(self.copyright))
        license = self.tag_p({'class': 'license'}, [12,1], 'This website is licensed under a ' + str(self.license()))
        credits = self.tag_img({'src': '/public/Images/top.png', 'alt': 'Top'}, [0,0])
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
