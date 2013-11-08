<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

    <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets/xhtml/docbook.xsl" />

    <!--
    Add your customization below this comment. For more information
    about how to customize this section, read installed documentation
    at: /usr/share/doc/docbook-style-xsl-1.69.1/doc/html/index.html
    -->

    <xsl:param name="html.stylesheet">Css/stylesheet.css</xsl:param>
    <xsl:param name="section.autolabel" select="1"></xsl:param>
    <xsl:param name="section.label.includes.component.label" select="1"></xsl:param>
    <xsl:param name="admon.graphics" select="1"></xsl:param>
    <xsl:param name="admon.graphics.path">Images/</xsl:param>
    <xsl:param name="callout.graphics.path" select="'Images/'"></xsl:param>

</xsl:stylesheet>
