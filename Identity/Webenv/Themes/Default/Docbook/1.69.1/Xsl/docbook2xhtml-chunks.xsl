<!-- 
$Id$ 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

    <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets/xhtml/chunk.xsl" />

    <!--
    Add your customization below this comment. For more information
    about how to customize this section, read installed documentation
    at: /usr/share/doc/docbook-style-xsl-1.69.1/doc/html/index.html
    -->

    <xsl:import href="=STYLE_XHTML_COMMON=" />

    <!-- 
    Inside references, don't print toc and use title as page division.
    -->
    <xsl:param name="generate.toc">
    appendix  toc,title
    article/appendix  nop
    article   toc,title
    book      toc,title,figure,table,example,equation
    chapter   toc,title
    part      toc,title
    preface   toc,title
    qandadiv  toc
    qandaset  toc
    reference title
    sect1     toc
    sect2     toc
    sect3     toc
    sect4     toc
    sect5     toc
    section   toc
    set       toc,title
    </xsl:param>

</xsl:stylesheet>
