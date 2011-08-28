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
"""
This module (App.xhtml) encapsulates the output code needed by web
applications, using the Extensible HTML version 1.0 DTDs
(/usr/share/sgml/xhtml1/xhtml1-20020801/DTD/) as reference.
"""


class Strict:
    """Implements XHTML strict document type definition."""


    # Core attributes common to most elements.
    coreattrs = ['id',        # document-wide unique id
                 'class',     # space separated list of classes
                 'style',     # associated style info
                 'title'      # advisory title/amplification
                ]
        
    # Internationalization attributes.
    i18n = ['lang',          # language code (backwards compatible)
            'xml:lang',      # language code (as per XML 1.0 spec)
            'dir'            # direction for weak/neutral text
           ]
        
    # Attributes for common UI events.
    events = ['onclick',     # a pointer button was clicked
              'ondblclick',  # a pointer button was double clicked
              'onmousedown', # a pointer button was pressed down
              'onmouseup',   # a pointer button was released
              'onmousemove', # a pointer was moved onto the element
              'onmouseout',  # a pointer was moved away from the element
              'onkeypress',  # a key was pressed and released
              'onkeydown',   # a key was pressed down
              'onkeyup'      # a key was released
             ]
        
    # Attributes for elements that can get the focus.
    focus = ['accesskey',    # accessibility key character
             'tabindex',     # position in tabbing order
             'onfocus',      # the element got the focus
             'onblur'        # the element lost the focus
            ]
        
    # Attributes generic format.
    attrs = coreattrs + i18n + events


    def __init__(self):
        """Initialize class data."""
        pass


    def tag(self, name, attrs, indent=[8,1], content="", has_child=0):
        """Returns generic XHTML tag definition.

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
        and. This function provides a consistent way of producing
        output for XHTML documents.
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


    # ------------------------------------------------------------------ 
    # Document Type Definition
    # ------------------------------------------------------------------ 

    def preamble(self):
        """Return document type definition."""
        output = '<?xml version="1.0"?>' + "\n"
        output += '<!DOCTYPE html' + "\n"
        output += ' '*4 + 'PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"' + "\n"
        output += ' '*4 + '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' + "\n"

        return output


    # ------------------------------------------------------------------ 
    # Document Structure
    # ------------------------------------------------------------------ 

    def tag_html(self, attrs, indent, content, has_child=1):
        """Returns document structure definition.

        <!ELEMENT html (head, body)>
        <!ATTLIST html
            %i18n;
            id          ID             #IMPLIED
            xmlns       %URI;          #FIXED 'http://www.w3.org/1999/xhtml'
            >

        The namespace URI designates the document profile.

        """
        return self.tag('html', attrs, indent, content, has_child=1)


    # ------------------------------------------------------------------
    # Document Head
    # ------------------------------------------------------------------

    def tag_head(self, attrs, indent, content, has_child=1):
        """Returns document head definition.

        <!ENTITY % head.misc "(script|style|meta|link|object)*">

        <!ELEMENT head (%head.misc;,
            ((title, %head.misc;, (base, %head.misc;)?) |
            (base, %head.misc;, (title, %head.misc;))))>
        <!ATTLIST head
            %i18n;
            id          ID             #IMPLIED
            profile     %URI;          #IMPLIED
            >

        Content model is %head.misc; combined with a single title and
        an optional base element in any order.

        """
        return self.tag('head', attrs, indent, content, has_child)


    def tag_title(self, attrs, indent, content, has_child=0):
        """Returns title definition.

        <!ELEMENT title (#PCDATA)>
        <!ATTLIST title 
            %i18n;
            id          ID             #IMPLIED
            >

        The title element is not considered part of the flow of text.
        It should be displayed, for example as the page header or
        window title. Exactly one title is required per document.
        
        """
        return self.tag('title', attrs, indent, content, has_child)


    def tag_base(self, attrs, indent):
        """Returns document base URI.
        
        <!ELEMENT base EMPTY>
        <!ATTLIST base
            href        %URI;          #REQUIRED
            id          ID             #IMPLIED
            >

        """
        return self.tag('base', attrs, indent)


    def tag_meta(self, attrs, indent):
        """Returns generic metainformation.
        
        <!ELEMENT meta EMPTY>
        <!ATTLIST meta
            %i18n;
            id          ID             #IMPLIED
            http-equiv  CDATA          #IMPLIED
            name        CDATA          #IMPLIED
            content     CDATA          #REQUIRED
            scheme      CDATA          #IMPLIED
            >

        """
        return self.tag('meta', attrs, indent)


    def tag_link(self, attrs, indent):
        """Returns relationship values.
        
        <!ELEMENT link EMPTY>
        <!ATTLIST link
            %attrs;
            charset     %Charset;      #IMPLIED
            href        %URI;          #IMPLIED
            hreflang    %LanguageCode; #IMPLIED
            type        %ContentType;  #IMPLIED
            rel         %LinkTypes;    #IMPLIED
            rev         %LinkTypes;    #IMPLIED
            media       %MediaDesc;    #IMPLIED
            >

        Relationship values can be used in principle:

            a) for document specific toolbars/menus when used with the
               link element in document head e.g.  start, contents,
               previous, next, index, end, help.

            b) to link to a separate style sheet (rel="stylesheet").

            c) to make a link to a script (rel="script").

            d) by stylesheets to control how collections of html nodes
               are rendered into printed documents.

            e) to make a link to a printable version of this document
               e.g.  a PostScript or PDF version (rel="alternate"
               media="print").

        """
        return self.tag('link', attrs, indent)


    def tag_style(self, attrs, indent, content, has_child=0):
        """Returns style info.

        <!ELEMENT style (#PCDATA)>
        <!ATTLIST style
            %i18n;
            id          ID             #IMPLIED
            type        %ContentType;  #REQUIRED
            media       %MediaDesc;    #IMPLIED
            title       %Text;         #IMPLIED
            xml:space   (preserve)     #FIXED 'preserve'
            >

        """
        return self.tag('style', attrs, indent, content, has_child)


    def tag_script(self, attrs, indent, content, has_child=0):
        """Returns script statement.
        
        <!-- script statements, which may include CDATA sections -->
        <!ELEMENT script (#PCDATA)>
        <!ATTLIST script
            id          ID             #IMPLIED
            charset     %Charset;      #IMPLIED
            type        %ContentType;  #REQUIRED
            src         %URI;          #IMPLIED
            defer       (defer)        #IMPLIED
            xml:space   (preserve)     #FIXED 'preserve'
            >

        """
        return self.tag('script', attrs, indent, content, has_child)


    def tag_noscript(self, attrs, indent, content, has_child=1):
        """Returns alternate content container for non script-based
        rendering.

        <!ELEMENT noscript %Block;>
        <!ATTLIST noscript
            %attrs;
            >

        """
        return self.tag(self, attrs, indent, content, has_child)


    # ------------------------------------------------------------------
    # Document Body
    # ------------------------------------------------------------------

    def tag_body(self, attrs, indent, content, has_child=1):
        """Returns document body definition.
        
        <!ELEMENT body %Block;>
        <!ATTLIST body
            %attrs;
            onload          %Script;   #IMPLIED
            onunload        %Script;   #IMPLIED
            >

        """
        return self.tag('body', attrs, indent, content, has_child)


    def tag_div(self, attrs, indent, content, has_child=0):
        """Returns generic language/style container.
        
        <!ELEMENT div %Flow;>  <!-- generic language/style container -->
        <!ATTLIST div
            %attrs;
            >

        """
        return self.tag('div', attrs, indent, content, has_child)


    # ------------------------------------------------------------------
    # Paragraphs
    # ------------------------------------------------------------------

    def tag_p(self, attrs, indent, content, has_child=0):
        """Returns paragraph definition.
        
        <!ELEMENT p %Inline;>
        <!ATTLIST p
            %attrs;
            >

        """
        return self.tag('p', attrs, indent, content, has_child)
        

    # ------------------------------------------------------------------
    # Headings
    # ------------------------------------------------------------------
    # There are six levels of headings from h1 (the most important) to
    # h6 (the least important).
    # ------------------------------------------------------------------

    def tag_h1(self, attrs, indent, content, has_child=0):
        """Returns h1 definition.
        
        <!ELEMENT h1  %Inline;>
        <!ATTLIST h1
            %attrs;
            >

        """
        return self.tag('h1', attrs, indent, content, has_child)


    def tag_h2(self, attrs, indent, content, has_child=0):
        """Returns h2 definition.
        
        <!ELEMENT h2  %Inline;>
        <!ATTLIST h2
            %attrs;
            >

        """
        return self.tag('h2', attrs, indent, content, has_child)


    def tag_h3(self, attrs, indent, content, has_child):
        """Returns h3 definition.
        
        <!ELEMENT h3  %Inline;>
        <!ATTLIST h3
            %attrs;
            >

        """
        return self.tag('h3', attrs, indent, content, has_child)


    def tag_h4(self, attrs, indent, content, has_child):
        """Returns h4 definition.
        
        <!ELEMENT h4  %Inline;>
        <!ATTLIST h4
            %attrs;
            >

        """
        return self.tag('h4', attrs, indent, content, has_child)


    def tag_h5(self, attrs, indent, content, has_child=0):
        """Returns h5 definition.
        
        <!ELEMENT h5  %Inline;>
        <!ATTLIST h5
            %attrs;
            >

        """
        return self.tag('h5', attrs, indent, content, has_child)


    def tag_h6(self, attrs, indent, content, has_child=0):
        """Returns h6 definition.
        
        <!ELEMENT h6  %Inline;>
        <!ATTLIST h6
            %attrs;
            >

        """
        return self.tag('h6', attrs, indent, content, has_child)


    # ------------------------------------------------------------------
    # Lists
    # ------------------------------------------------------------------

    def tag_ul(self, attrs, indent, content, has_child=1):
        """Returns unordered list definition.
        
        <!ELEMENT ul (li)+>
        <!ATTLIST ul
            %attrs;
            >

        """
        return self.tag('ul', attrs, indent, content, has_child)


    def tag_ol(self, attrs, indent, content, has_child=1):
        """Returns ordered (numbered) list definition.
       
        <!ELEMENT ol (li)+>
        <!ATTLIST ol
            %attrs;
            >

        """
        return self.tag('ol', attrs, indent, content, has_child)


    def tag_li(self, attrs, indent, content, has_child=0):
        """Returns item definition for both ordered (ol) and unordered
        (ul) lists.
        
        <!ELEMENT li %Flow;>
        <!ATTLIST li
            %attrs;
            >

        """
        return self.tag('li', attrs, indent, content, has_child)


    def tag_dl(self, attrs, indent, content, has_child=1):
        """Returns definition list definition.
        
        <!ELEMENT dl (dt|dd)+>
        <!ATTLIST dl
            %attrs;
            >

        """
        return self.tag('dl', attrs, indent, content, has_child)


    def tag_dt(self, attrs, indent, content, has_child=0):
        """Returns term of definition lists.
        
        <!ELEMENT dt %Inline;>
        <!ATTLIST dt
            %attrs;
            >

        """
        return self.tag('dt', attrs, indent, content, has_child)


    def tag_dd(self, attrs, indent, content, has_child=0):
        """Returns definition of definition lists.
        
        <!ELEMENT dd %Flow;>
        <!ATTLIST dd
            %attrs;
            >

        """
        return self.tag('dd', attrs, indent, content, has_child)


    # ------------------------------------------------------------------
    # Address
    # ------------------------------------------------------------------

    def tag_address(self, attrs, indent, content='', has_child=0):
        """Returns information on author.
        
        <!ELEMENT address %Inline;>
        <!ATTLIST address
            %attrs;
            >

        """
        return self.tag('address', attrs, indent, content)


    # ------------------------------------------------------------------
    # Horizontal Rule
    # ------------------------------------------------------------------

    def tag_hr(self, attrs, indent):
        """Returns horizontal rule.
        
        <!ELEMENT hr EMPTY>
        <!ATTLIST hr
            %attrs;
            >

        """
        return self.tag('hr', attrs, indent)


    # ------------------------------------------------------------------
    # Preformatted text
    # ------------------------------------------------------------------
    
    def tag_pre(self, attrs, indent, content):
        """Returns preformatted text.
        
        <!ELEMENT pre %pre.content;>
        <!ATTLIST pre
            %attrs;
            xml:space (preserve) #FIXED 'preserve'
            >

        content is %Inline; excluding "img|object|big|small|sub|sup"

        """
        return self.tag('pre', attrs, indent, content)


    # ------------------------------------------------------------------
    # Block-line Quotes
    # ------------------------------------------------------------------
    
    def tag_blockquote(self, attrs, indent, content):
        """Returns block-line quote.
        
        <!ELEMENT blockquote %Block;>
        <!ATTLIST blockquote
            %attrs;
            cite        %URI;          #IMPLIED
            >

        """
        return self.tag('blockquote', attrs, indent, content)


    # ------------------------------------------------------------------
    # Inserted/Deleted Text
    # ------------------------------------------------------------------

    def tag_ins(self, attrs, indent, content):
        """Returns inserted text.

        <!ELEMENT ins %Flow;>
        <!ATTLIST ins
            %attrs;
            cite        %URI;          #IMPLIED
            datetime    %Datetime;     #IMPLIED
            >

        Inserted texts are allowed in block and inline content, but
        its inappropriate to include block content within an ins
        element occurring in inline content.

        """
        return self.tag('ins', attrs, indent, content)


    def tag_del(self, attrs, indent, content):
        """Returns deleted text.

        <!ELEMENT del %Flow;>
        <!ATTLIST del
            %attrs;
            cite        %URI;          #IMPLIED
            datetime    %Datetime;     #IMPLIED
            >

        Deleted texts are allowed in block and inline content, but its
        inappropriate to include block content within an ins element
        occurring in inline content.

        """
        return self.tag('ins', attrs, indent, content)


    # ------------------------------------------------------------------
    # The Anchor Element
    # ------------------------------------------------------------------

    def tag_a(self, attrs, indent, content='', has_child=0):
        """Returns the anchor element.

        <!ELEMENT a %a.content;>
        <!ATTLIST a
            %attrs;
            %focus;
            charset     %Charset;      #IMPLIED
            type        %ContentType;  #IMPLIED
            name        NMTOKEN        #IMPLIED
            href        %URI;          #IMPLIED
            hreflang    %LanguageCode; #IMPLIED
            rel         %LinkTypes;    #IMPLIED
            rev         %LinkTypes;    #IMPLIED
            shape       %Shape;        "rect"
            coords      %Coords;       #IMPLIED
            >
        
        content is %Inline; except that anchors shouldn't be nested.
        """
        return self.tag('a', attrs, indent, content, has_child)


    # ------------------------------------------------------------------
    # Inline Elements
    # ------------------------------------------------------------------

    def tag_span(self, attrs, indent, content, has_child=0):
        """Returns span definition.
        
        <!ELEMENT span %Inline;> <!-- generic language/style container -->
        <!ATTLIST span
            %attrs;
            >

        """
        return self.tag('span', attrs, indent, content, has_child)


    def tag_dbo(self, attrs, indent, content, has_child=0):
        """Returns dbo definition.
        
        <!ELEMENT bdo %Inline;>  <!-- I18N BiDi over-ride -->
        <!ATTLIST bdo
            %coreattrs;
            %events;
            lang        %LanguageCode; #IMPLIED
            xml:lang    %LanguageCode; #IMPLIED
            dir         (ltr|rtl)      #REQUIRED
            >

        """
        return self.tag('dbo', attrs, indent, content, has_child)


    def tag_br(self, attrs, indent):
        """Returns break definition.
        
        <!ELEMENT br EMPTY>   <!-- forced line break -->
        <!ATTLIST br
            %coreattrs;
            >

        """
        return self.tag('br', attrs, indent)


    def tag_em(self, attrs, indent, content, has_child=0):
        """Returns emphasis definition.
        
        <!ELEMENT em %Inline;>   <!-- emphasis -->
        <!ATTLIST em %attrs;>

        """
        return self.tag('em', attrs, indent, content, has_child)


    def tag_strong(self, attrs, indent, content, has_child=0):
        """Returns strong emphasis definition.
        
        <!ELEMENT strong %Inline;>   <!-- strong emphasis -->
        <!ATTLIST strong %attrs;>

        """
        return self.tag('strong', attrs, indent, content, has_child)
    

    def tag_dfn(self, attrs, indent, content, has_child=0):
        """Returns definitional definition.
        
        <!ELEMENT dfn %Inline;>   <!-- definitional -->
        <!ATTLIST dfn %attrs;>

        """
        return self.tag('dfn', attrs, indent, content, has_child)


    def tag_code(self, attrs, indent, content, has_child=0):
        """Returns program code definition.
        
        <!ELEMENT code %Inline;>   <!-- program code -->
        <!ATTLIST code %attrs;>

        """
        return self.tag('code', attrs, indent, content, has_child)


    def tag_samp(self, attrs, indent, content, has_child=0):
        """Returns sample definition.
        
        <!ELEMENT samp %Inline;>
        <!ATTLIST samp %attrs;>

        """
        return self.tag('samp', attrs, indent, content, has_child)


    def tag_kbd(self, attrs, indent, content, has_child=0):
        """Returns definition for something user would type.
        
        <!ELEMENT kbd %Inline;>
        <!ATTLIST kbd %attrs;>

        """
        return self.tag('kbd', attrs, indent, content, has_child)


    def tag_var(self, attrs, indent, content, has_child=0):
        """Returns variable definition.
        
        <!ELEMENT var %Inline;>
        <!ATTLIST var %attrs;>

        """
        return self.tag('var', attrs, indent, content, has_child)


    def tag_cite(self, attrs, indent, content, has_child=0):
        """Returns citation definition.
       
        <!ELEMENT cite %Inline;>
        <!ATTLIST cite %attrs;>

        """
        return self.tag('cite', attrs, indent, content, has_child)


    def tag_abbr(self, attrs, indent, content, has_child=0):
        """Returns abbreviation definition.
        
        <!ELEMENT abbr %Inline;>
        <!ATTLIST abbr %attrs;>

        """
        return self.tag('abbr', attrs, indent, content, has_child)


    def tag_acronym(self, attrs, indent, content, has_child=0):
        """Returns the acronym definition.
        
        <!ELEMENT acronym %Inline;>
        <!ATTLIST acronym %attrs;>

        """
        return self.tag('acronym', attrs, indent, content, has_child)


    def tag_q(self, attrs, indent, content, has_child=0):
        """Returns inline quote definition.
        
        <!ELEMENT q %Inline;>
        <!ATTLIST q
            %attrs;
            cite        %URI;          #IMPLIED
            >

        """
        return self.tag('q', attrs, indent, content, has_child)


    def tag_sub(self, attrs, indent, content, has_child=0):
        """Returns subscript definition.
        
        <!ELEMENT sub %Inline;>
        <!ATTLIST sub %attrs;>

        """
        return self.tag('sub', attrs, indent, content, has_child)


    def tag_sup(self, attrs, indent, content, has_child=0):
        """Returns superscript definition.
        
        <!ELEMENT sup %Inline;>
        <!ATTLIST sup %attrs;>

        """
        return self.tag('sup', attrs, indent, content, has_child)


    def tag_tt(self, attrs, indent, content, has_child=0):
        """Returns fixed pitch font definition.
        
        <!ELEMENT tt %Inline;>
        <!ATTLIST tt %attrs;>

        """
        return self.tag('tt', attrs, indent, content, has_child)


    def tag_i(self, attrs, indent, content, has_child=0):
        """Returns italic font definition.
        
        <!ELEMENT i %Inline;>
        <!ATTLIST i %attrs;>

        """
        return self.tag('i', attrs, indent, content, has_child)


    def tag_b(self, attrs, indent, content, has_child=0):
        """Returns bold font definition.
        
        <!ELEMENT b %Inline;>
        <!ATTLIST b %attrs;>

        """
        return self.tag('b', attrs, indent, content, has_child)


    def tag_big(self, attrs, indent, content, has_child=0):
        """Returns bigger font definition.
        
        <!ELEMENT big %Inline;>
        <!ATTLIST big %attrs;>

        """
        return self.tag('big', attrs, indent, content, has_child)


    def tag_small(self, attrs, indent, content, has_child=0):
        """Returns smaller font definition.
        
        <!ELEMENT small %Inline;>
        <!ATTLIST small %attrs;>

        """
        return self.tag('small', attrs, indent, content, has_child)


    # ------------------------------------------------------------------
    # Object
    # ------------------------------------------------------------------

    def tag_object(self, attrs, indent, content, has_child=1):
        """Returns object definition.

        <!ELEMENT object (#PCDATA | param | %block; | form | %inline;
            | %misc;)*>
        <!ATTLIST object
            %attrs;
            declare     (declare)      #IMPLIED
            classid     %URI;          #IMPLIED
            codebase    %URI;          #IMPLIED
            data        %URI;          #IMPLIED
            type        %ContentType;  #IMPLIED
            codetype    %ContentType;  #IMPLIED
            archive     %UriList;      #IMPLIED
            standby     %Text;         #IMPLIED
            height      %Length;       #IMPLIED
            width       %Length;       #IMPLIED
            usemap      %URI;          #IMPLIED
            name        NMTOKEN        #IMPLIED
            tabindex    %Number;
            #IMPLIED
            >

        The object definition is used to embed objects as part of HTML
        pages.  param elements should precede other content.
        Parameters can also be expressed as attribute/value pairs on
        the object element itself when brevity is desired.

        """
        return self.tag('object', attrs, indent, content, has_child)


    def tag_param(self, attrs, indent):
        """Returns param definition.

        <!ELEMENT param EMPTY>
        <!ATTLIST param
            id          ID             #IMPLIED
            name        CDATA          #IMPLIED
            value       CDATA          #IMPLIED
            valuetype   (data|ref|object) "data"
            type        %ContentType;  #IMPLIED
            >
                    
        The param definition is used to supply a named property value.
        In XML it would seem natural to follow RDF and support an
        abbreviated syntax where the param elements are replaced by
        attribute value pairs on the object start tag.

        """
        return self.tag('object', attrs, indent)


    # ------------------------------------------------------------------
    # Images
    # ------------------------------------------------------------------

    def tag_img(self, attrs, indent):
        """Returns image definition.

        <!ELEMENT img EMPTY>
        <!ATTLIST img
        %attrs;
        src         %URI;          #REQUIRED
        alt         %Text;         #REQUIRED
        longdesc    %URI;          #IMPLIED
        height      %Length;       #IMPLIED
        width       %Length;       #IMPLIED
        usemap      %URI;          #IMPLIED
        ismap       (ismap)        #IMPLIED
        >
       
        To avoid accessibility problems for people who aren't able to
        see the image, you should provide a text description using the
        alt and longdesc attributes.  In addition, avoid the use of
        server-side image maps.  Note that in this DTD there is no
        name attribute.  That is only available in the transitional
        and frameset DTD.

        usemap points to a map element which may be in this document
        or an external document, although the latter is not widely
        supported.

        """
        return self.tag('img', attrs, indent)
        

    # ------------------------------------------------------------------
    # Client-side image maps
    # ------------------------------------------------------------------

    def tag_map(self, attrs, indent, content, has_child=1):
        """Returns map definition.

        <!ELEMENT map ((%block; | form | %misc;)+ | area+)>
        <!ATTLIST map
            %i18n;
            %events;
            id          ID             #REQUIRED
            class       CDATA          #IMPLIED
            style       %StyleSheet;   #IMPLIED
            title       %Text;         #IMPLIED
            name        NMTOKEN        #IMPLIED
            >
        
        This can be placed in the same document or grouped in a
        separate document although this isn't yet widely supported.

        """
        return self.tag('map', attrs, indent,  indent, content, has_child)


    def tag_area(self, attrs, indent):
        """Returns area definition.

        <!ELEMENT area EMPTY>
        <!ATTLIST area
            %attrs;
            %focus;
            shape       %Shape;        "rect"
            coords      %Coords;       #IMPLIED
            href        %URI;          #IMPLIED
            nohref      (nohref)       #IMPLIED
            alt         %Text;         #REQUIRED
            >

        This can be placed in the same document or grouped in a
        separate document although this isn't yet widely supported.

        """
        return self.tag('area', attrs, indent)


    # ------------------------------------------------------------------
    # Forms
    # ------------------------------------------------------------------

    def tag_form(self, attrs, indent, content, has_child=1):
        """Returns form definition.

        <!ELEMENT form %form.content;><!-- forms shouldn't be nested -->
        <!ATTLIST form
            %attrs;
            action      %URI;          #REQUIRED
            method      (get|post)     "get"
            enctype     %ContentType;  "application/x-www-form-urlencoded"
            onsubmit    %Script;       #IMPLIED
            onreset     %Script;       #IMPLIED
            accept      %ContentTypes; #IMPLIED
            accept-charset %Charsets;  #IMPLIED
            >

        """
        return self.form('form', attrs, indent, content, has_child)

    
    def tag_label(self, attrs, indent, content, has_child=0):
        """Returns label definition.

        <!ELEMENT label %Inline;>
        <!ATTLIST label
            %attrs;
            for         IDREF          #IMPLIED
            accesskey   %Character;    #IMPLIED
            onfocus     %Script;       #IMPLIED
            onblur      %Script;       #IMPLIED
            >

        Each label must not contain more than ONE field Label elements
        shouldn't be nested.

        """
        return self.tag('label', attrs, indent, content, has_child)


    def tag_input(self, attrs, indent):
        """Returns input definition for form control.

        <!ENTITY % InputType 
            "(text | password | checkbox | radio | submit | reset |
            file | hidden | image | button)"
            >

        <!ELEMENT input EMPTY>     <!-- form control -->
        <!ATTLIST input
            %attrs;
            %focus;
            type        %InputType;    "text"
            name        CDATA          #IMPLIED
            value       CDATA          #IMPLIED
            checked     (checked)      #IMPLIED
            disabled    (disabled)     #IMPLIED
            readonly    (readonly)     #IMPLIED
            size        CDATA          #IMPLIED
            maxlength   %Number;       #IMPLIED
            src         %URI;          #IMPLIED
            alt         CDATA          #IMPLIED
            usemap      %URI;          #IMPLIED
            onselect    %Script;       #IMPLIED
            onchange    %Script;       #IMPLIED
            accept      %ContentTypes; #IMPLIED
            >

        The name attribute is required for all but submit & reset.

        """
        return self.tag('input', attrs, indent)


    def tag_select(self, attrs, indent, content, has_child=0):
        """Returns select definition.
        
        <!ELEMENT select (optgroup|option)+>  <!-- option selector -->
        <!ATTLIST select
            %attrs;
            name        CDATA          #IMPLIED
            size        %Number;       #IMPLIED
            multiple    (multiple)     #IMPLIED
            disabled    (disabled)     #IMPLIED
            tabindex    %Number;       #IMPLIED
            onfocus     %Script;       #IMPLIED
            onblur      %Script;       #IMPLIED
            onchange    %Script;       #IMPLIED
            >

        """
        return self.tag('select', attrs, indent, content, has_child)


    def tag_optgroup(self, attrs, indent, content, has_child=1):
        """Returns option group definition.

        <!ELEMENT optgroup (option)+>   <!-- option group -->
        <!ATTLIST optgroup
            %attrs;
            disabled    (disabled)     #IMPLIED
            label       %Text;         #REQUIRED
            >

        """
        return self.tag('optgroup', attrs, indent, content, has_child)


    def tag_option(self, attrs, indent, content, has_child=0):
        """Returns option definition.
        
        <!ELEMENT option (#PCDATA)>     <!-- selectable choice -->
        <!ATTLIST option
            %attrs;
            selected    (selected)     #IMPLIED
            disabled    (disabled)     #IMPLIED
            label       %Text;         #IMPLIED
            value       CDATA          #IMPLIED
            >

        """
        return self.tag('option', attrs, indent, content, has_child)


    def tag_textarea(self, attrs, indent, content):
        """Returns textarea definition.

        <!ELEMENT textarea (#PCDATA)>     <!-- multi-line text field -->
        <!ATTLIST textarea
            %attrs;
            %focus;
            name        CDATA          #IMPLIED
            rows        %Number;       #REQUIRED
            cols        %Number;       #REQUIRED
            disabled    (disabled)     #IMPLIED
            readonly    (readonly)     #IMPLIED
            onselect    %Script;       #IMPLIED
            onchange    %Script;       #IMPLIED
            >

        """
        return self.textarea('textarea', attrs, indent, content)


    def tag_fieldset(self, attrs, indent, content, has_child=1):
        """Returns fieldset definition.

        <!ELEMENT fieldset (#PCDATA | legend | %block; | form | %inline; | %misc;)*>
        <!ATTLIST fieldset
          %attrs;
          >

        The fieldset element is used to group form fields.  Only one
        legend element should occur in the content and if present
        should only be preceded by whitespace.

        """
        return self.tag('filedset', attrs, indent, content, has_child)


    def tag_legend(self, attrs, indent, content):
        """Retruns legend definition.

        <!ELEMENT legend %Inline;>     <!-- fieldset label -->
        <!ATTLIST legend
            %attrs;
            accesskey   %Character;    #IMPLIED
            >

        """
        return self.tag('legend', attrs, indent, content)


    def tag_button(self, attrs, indent, content):
        """Returns button definition.
        
        <!ELEMENT button %button.content;>  <!-- push button -->
        <!ATTLIST button
            %attrs;
            %focus;
            name        CDATA          #IMPLIED
            value       CDATA          #IMPLIED
            type        (button|submit|reset) "submit"
            disabled    (disabled)     #IMPLIED
            >

        content is %Flow; excluding a, form and form controls.

        """
        return self.tag('button', attrs, indent, content)


    def tag_table(self, attrs, indent, content, has_child=1):
        """Returns table definition.

        <!ENTITY % TFrame "(void|above|below|hsides|lhs|rhs|vsides|box|border)">

        <!ENTITY % TRules "(none | groups | rows | cols | all)">
                      
        <!ENTITY % cellhalign 
            "align (left|center|right|justify|char) #IMPLIED
            char       %Character;    #IMPLIED
            charoff    %Length;       #IMPLIED"
            >

        <!ELEMENT table
            (caption?, (col*|colgroup*), thead?, tfoot?,
            (tbody+|tr+))>
        <!ATTLIST table
            %attrs;
            summary     %Text;         #IMPLIED
            width       %Length;       #IMPLIED
            border      %Pixels;       #IMPLIED
            frame       %TFrame;       #IMPLIED
            rules       %TRules;       #IMPLIED
            cellspacing %Length;       #IMPLIED
            cellpadding %Length;       #IMPLIED
            >

        Derived from IETF HTML table standard, see [RFC1942]

        The border attribute sets the thickness of the frame around
        the table. The default units are screen pixels.  The frame
        attribute specifies which parts of the frame around the table
        should be rendered. The values are not the same as CALS to
        avoid a name clash with the valign attribute.  The rules
        attribute defines which rules to draw between cells: If rules
        is absent then assume: "none" if border is absent or
        border="0" otherwise "all".  Horizontal alignment attributes
        for cell contents: 
            char        alignment char, e.g. char=':'
            charoff     offset for alignment char

        """
        return self.tag('table', attrs, indent, content, has_child)


    def tag_caption(self, attrs, indent, content):
        """Returns caption definition.
        
        <!ELEMENT caption  %Inline;>
        <!ATTLIST caption
            %attrs;
            >

        """
        return self.tag('caption', attrs, indent, content)


    def tag_thead(self, attrs, indent, content, has_child=1):
        """Returns thead definition.
        
        <!ELEMENT thead    (tr)+>
        <!ATTLIST thead
            %attrs;
            %cellhalign;
            %cellvalign;
            >

        Use thead to duplicate headers when breaking table across page
        boundaries, or for static headers when tbody sections are
        rendered in scrolling panel.

        """
        return self.tag('thead', attrs, indent, content, has_child)


    def tag_tbody(self, attrs, indent, content, has_child=1):
        """Returns tbody definition.
        
        <!ELEMENT tbody    (tr)+>
        <!ATTLIST tbody
            %attrs;
            %cellhalign;
            %cellvalign;
            >
        
        Use tbody to duplicate footers when breaking table across page
        boundaries, or for static footers when tbody sections are
        rendered in scrolling panel.

        """
        return self.tag('tbody', attrs, indent, content, has_child)


    def tag_tbody(self, attrs, indent, content, has_child=1):
        """Returns tbody definition.
        
        <!ELEMENT tbody    (tr)+>
        <!ATTLIST tbody
            %attrs;
            %cellhalign;
            %cellvalign;
            >
        
        Use multiple tbody sections when rules are needed between
        groups of table rows.

        """
        return self.tag('tbody', attrs, indent, content, has_child)


    def tag_colgroup(self, attrs, indent, content, has_child=1):
        """Returns colgroup definition.
        
        <!ELEMENT colgroup (col)*>
        <!ATTLIST colgroup
            %attrs;
            span        %Number;       "1"
            width       %MultiLength;  #IMPLIED
            %cellhalign;
            %cellvalign;
            >

        colgroup groups a set of col elements. It allows you to group
        several semantically related columns together.

        """
        return self.tag('colgroup', attrs, indent, content, has_child)


    def tag_col(self, attrs, indent):
        """Returns col definition.

        <!ELEMENT col      EMPTY>
        <!ATTLIST col
            %attrs;
            span        %Number;       "1"
            width       %MultiLength;  #IMPLIED
            %cellhalign;
            %cellvalign;
            >

        col elements define the alignment properties for cells in one
        or more columns.  The width attribute specifies the width of
        the columns, e.g.

            width=64        width in screen pixels
            width=0.5*      relative width of 0.5

        The span attribute causes the attributes of one col element to
        apply to more than one column.

        """
        return self.tag('col', attrs, indent)


    def tag_tr(self, attrs, indent, content, has_child=1):
        """Returns table row definition.
        
        <!ELEMENT tr       (th|td)+>
        <!ATTLIST tr
            %attrs;
            %cellhalign;
            %cellvalign;
            >

        """
        return self.tag('tr', attrs, indent, content, has_child)


    def tag_th(self, attrs, indent, content, has_child):
        """Returns table header definition.
        
        <!ENTITY % Scope "(row|col|rowgroup|colgroup)">

        <!ELEMENT th       %Flow;>
        <!ATTLIST th
            %attrs;
            abbr        %Text;         #IMPLIED
            axis        CDATA          #IMPLIED
            headers     IDREFS         #IMPLIED
            scope       %Scope;        #IMPLIED
            rowspan     %Number;       "1"
            colspan     %Number;       "1"
            %cellhalign;
            %cellvalign;
            >

        Scope is simpler than headers attribute for common tables.  th
        is for headers, td for data and for cells acting as both.

        """
        return self.tab('th', attrs, indent, content, has_child)


    def tag_td(self, attrs, indent, content, has_child=1):
        """Returns table data definition.

        <!ELEMENT td       %Flow;>
        <!ATTLIST td
            %attrs;
            abbr        %Text;         #IMPLIED
            axis        CDATA          #IMPLIED
            headers     IDREFS         #IMPLIED
            scope       %Scope;        #IMPLIED
            rowspan     %Number;       "1"
            colspan     %Number;       "1"
            %cellhalign;
            %cellvalign;
            >

        """
        return self.tag('td', attrs, indent, content, has_child)
