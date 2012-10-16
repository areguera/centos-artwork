# -*- coding: iso-8859-1 -*-
"""
    MoinMoin - Modern Theme

    Created for the CentOS Project Wiki. This is a
    modification of the MoinMoin's modern default
    wiki theme, and a continuation of previous
    modern-CentOS theme.

    @copyright: 2008 by The CentOS ArtWork SIG.
    @license: GNU GPL, see COPYING for details.  
"""

from MoinMoin.theme import ThemeBase
from MoinMoin import wikiutil

class Theme(ThemeBase):

    name = "Modern"

    def header(self, d):
        """
        Assemble page header
        
        @param d: parameter dictionary
        @rtype: string
        @return: page header html
        """

        html = [

            # Header
            u'<div id="wrap">',
            u'<div id="header">',
            self.logo(),
            u'<div id="userlinks">',
            self.searchform(d),
            self.username(d),
            self.trail(d),
            u'</div>',
	        self.navibar(d),
    	    u'<div class="pageline"><hr style="display:none;" /></div>',
     	    self.editbar(d),
            u'</div>',

            # Page
            self.msg(d),
            self.startPage(),
            ]
        return u'\n'.join(html)

    def editorheader(self, d):
        """
        Assemble page header for editor
        
        @param d: parameter dictionary
        @rtype: string
        @return: page header html
        """

        html = [
            # Custom html above header
            #self.emit_custom_html(self.cfg.page_header1),

            # Header
            u'<div id="wrap">',
            u'<div id="header">',
            self.logo(),
            u'<div id="userlinks">',
            self.searchform(d),
            self.username(d),
            self.trail(d),
            u'</div>',
    	    u'<div class="pageline"><hr style="display:none;"></div>',
            u'</div>',

            # Custom html below header (not recomended!)
            # self.emit_custom_html(self.cfg.page_header2),
            
            # Page
            self.msg(d),
            u'<div id="editortitle">',
	        self.title(d),
            u'</div>',
            ]
        return u'\n'.join(html)

    def footer(self, d, **keywords):
        """ Assemble wiki footer
        
        @param d: parameter dictionary
        @keyword ...:...
        @rtype: unicode
        @return: page footer html
        """
        page = d['page']
        html = [
            # End of page
            self.pageinfo(page),
            self.endPage(),

            # Pre footer custom html (not recommended!)
            # self.emit_custom_html(self.cfg.page_footer1),

            # Footer
	        u'<div id="footer">',
            self.editbar(d),
    	    u'<div class="pageline"><hr style="display:none;"></div>',
            self.navibar(d),
            self.credits(d),
            #self.showversion(d, **keywords),
            u'</div>',
            u'</div>',
            
            # Post footer custom html
            # self.emit_custom_html(self.cfg.page_footer2),
            ]
        return u'\n'.join(html)

    def errormsg(self, d): 
    	"""Assemble HTML code for CentOS Identification
        
        @rtype: unicode
        @return: CentOS Global Identification
        """
        html = [
            u'<div id="errormsg">',
	        u'<img src="/error/include/img/wiki.png" alt="Wiki" />',
    	    u'<div class="userlinks">',
    	    self.username(d),
	        self.searchform(d),
    	    u'</div>',
            u'<h1>Wiki</h1>',
            self.navibar(d),
            self.editbar(d),
            self.interwiki(d),
            self.trail(d),
            self.title(d),
            u'</div>',
            ]
        return u'\n'.join(html)

    def credits(self, d):
        """Assemble HTML code for the credits.
        
        @rtype: unicode
        @return: Creative Common Reference
        """

        html = u'''
        <div id="credits">
        <div id="cc-image">
            <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">
            <img alt="Creative Commons License" style="border-width:0" src="http://creativecommons.org/images/public/somerights20.png" />
            </a>
        </div>

        <div id="cc-text">
        This wiki is licensed under a <em> <a rel="license"
        href="http://creativecommons.org/licenses/by-sa/3.0/">Creative
        Commons Attribution-Share Alike 3.0 Unported
        License</a></em>.
        </div>

</div>
''' % d
        return html

    def searchform(self, d):
        """
        assemble HTML code for the search forms
        
        @param d: parameter dictionary
        @rtype: unicode
        @return: search form html
        """
        _ = self.request.getText
        form = self.request.form
        updates = {
            'search_label' : _('Search:'),
            'search_value': wikiutil.escape(form.get('value', [''])[0], 1),
            'search_full_label' : _('Text', formatted=False),
            'search_title_label' : _('Titles', formatted=False),
            }
        d.update(updates)

        html = u'''
<div id="searchform">
<form method="get" action="">

    <input type="hidden" name="action" value="fullsearch">
    <input type="hidden" name="context" value="180">
    <label for="searchinput">%(search_label)s</label>
    <input id="searchinput" type="text" name="value" value="%(search_value)s" size="20"
    onfocus="searchFocus(this)" onblur="searchBlur(this)"
    onkeyup="searchChange(this)" onchange="searchChange(this)" alt="Search">
    <input id="fullsearch" name="fullsearch" type="submit"
    value="%(search_full_label)s" alt="Search Full Text">
    <input id="titlesearch" name="titlesearch" type="submit"
    value="%(search_title_label)s" alt="Search Titles">
</form>
</div>

<script type="text/javascript">
<!--// Initialize search form
var f = document.getElementById('searchform');
f.getElementsByTagName('label')[0].style.display = 'none';
var e = document.getElementById('searchinput');
searchChange(e);
searchBlur(e);
//-->
</script>
''' % d
        return html

# The following code make the navibar visible to users with
# write access right ONLY!.

    def shouldShowEditbar(self, page):
        """ Hide the edit bar if you can't edit """
        if self.request.user.may.write(page.page_name):
            return ThemeBase.shouldShowEditbar(self, page)
        return False

# The follwing code is just to use class instead of id in
# the navibar element. It is not recommended by CCS v2.1
# standard the use of two equals id elements on the same
# page.

    def navibar(self, d):
        """ Assemble the navibar

        @param d: parameter dictionary
        @rtype: unicode
        @return: navibar html
        """
        request = self.request
        found = {} # pages we found. prevent duplicates
        items = [] # navibar items
        item = u'<li class="%s">%s</li>'
        current = d['page_name']

        # Process config navi_bar
        if request.cfg.navi_bar:
            for text in request.cfg.navi_bar:
                pagename, link = self.splitNavilink(text)
                if pagename == current:
                    cls = 'wikilink current'
                else:
                    cls = 'wikilink'
                items.append(item % (cls, link))
                found[pagename] = 1

        # Add user links to wiki links, eliminating duplicates.
        userlinks = request.user.getQuickLinks()
        for text in userlinks:
            # Split text without localization, user knows what he wants
            pagename, link = self.splitNavilink(text, localize=0)
            if not pagename in found:
                if pagename == current:
                    cls = 'userlink current'
                else:
                    cls = 'userlink'
                items.append(item % (cls, link))
                found[pagename] = 1

        # Add current page at end
        if not current in found:
            title = d['page'].split_title(request)
            title = self.shortenPagename(title)
            link = d['page'].link_to(request, title)
            cls = 'current'
            items.append(item % (cls, link))

        # Assemble html
        items = u''.join(items)
        html = u'''
<ul class="navibar">
%s
</ul>
''' % items
        return html

def execute(request):
    """ Generate and return a theme object
        
    @param request: the request object
    @rtype: MoinTheme
    @return: Theme object
    """
    return Theme(request)
