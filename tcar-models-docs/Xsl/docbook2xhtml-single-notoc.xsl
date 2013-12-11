<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

    <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets/xhtml/docbook.xsl" />

    <!--
    Add your customization below this comment. For more information
    about how to customize this section, read installed documentation
    at: /usr/share/doc/docbook-style-xsl-1.69.1/doc/html/index.html
    -->

    <xsl:param name="html.stylesheet"></xsl:param>
    <xsl:param name="admon.graphics.path">Images/</xsl:param>
    <xsl:param name="callout.graphics.path" select="'Images/'"></xsl:param>

    <!-- 
    Don't print toc 
    -->
    <xsl:param name="generate.toc">
    article   nop
    book      nop
    refentry  nop
    set       nop
    </xsl:param>

</xsl:stylesheet>
