<?xml version='1.0'?>
<!-- 
$Id$ 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version='1.0'
		xmlns="http://www.w3.org/TR/xhtml1/transitional"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		exclude-result-prefixes="#default">

    <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets/fo/docbook.xsl"/>

<!-- Admonitions -->
<xsl:param name="admon.graphics" select="0"></xsl:param>

<!-- Callouts -->

<!-- ToC/LoT/Index Generation -->
<xsl:param name="toc.section.depth">3</xsl:param>

<!-- Processor Extensions -->
<xsl:param name="passivetex.extensions" select="1"></xsl:param>

<!-- Stylesheet Extensions -->

<!-- Automatic Labelling -->
<xsl:param name="section.autolabel" select="1"></xsl:param>


<!-- Meta/*Info -->
<xsl:param name="make.year.ranges" select="1"></xsl:param>

<!-- Reference Pages -->

<xsl:param name="paper.type" select="'A4'"/>
<xsl:param name="double.sided" select="1"></xsl:param>
<xsl:param name="header.column.widths" select="'1 0 1'"/>
<xsl:param name="footer.column.widths" select="'1 1 1'"/>
<xsl:param name="header.rule" select="1"/>
<xsl:param name="page.margin.top">15mm</xsl:param>
<xsl:param name="region.before.extent">10mm</xsl:param>
<xsl:param name="body.margin.top">15mm</xsl:param>
<xsl:param name="body.margin.bottom">15mm</xsl:param>
<xsl:param name="region.after.extent">10mm</xsl:param>
<xsl:param name="page.margin.bottom">15mm</xsl:param>
<xsl:param name="page.margin.outer">30mm</xsl:param>
<xsl:param name="page.margin.inner">30mm</xsl:param>
<xsl:param name="title.margin.left">0pt</xsl:param>
<xsl:param name="title.color">#204c8d</xsl:param>
<xsl:param name="body.font.family">sans-serif</xsl:param>

<!-- Tables -->

<!-- Linking -->

<!-- QAndASet -->

<!-- Bibliography -->

<!-- Miscellaneous -->

<!-- Pagination and General Styles -->

<!-- Font Families -->

<xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.2"/>
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="hyphenate">false</xsl:attribute>
	<xsl:attribute name="space-before.optimum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
	<xsl:attribute name="space-before.minimum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
	<xsl:attribute name="space-before.maximum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.level1.properties">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.6"/>
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level2.properties">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.4"/>
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level3.properties">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.3"/>
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level4.properties">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.2"/>
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level5.properties">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.1"/>
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level6.properties">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master"/>
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.properties">
	<xsl:attribute name="font-family">
		<xsl:value-of select="$title.font.family"/>
	</xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
	<!-- font size is calculated dynamically by section.heading template -->
	<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
	<xsl:attribute name="space-before.optimum">1.0em</xsl:attribute>
	<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
	<xsl:attribute name="text-align">left</xsl:attribute>
	<xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left"/></xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="book.titlepage.recto.style">
	<xsl:attribute name="font-family">
		<xsl:value-of select="$title.fontset"/>
	</xsl:attribute>
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
	<xsl:attribute name="font-size">12pt</xsl:attribute>
	<xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="component.title.properties">
	<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	<xsl:attribute name="space-before.optimum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
	<xsl:attribute name="space-before.minimum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
	<xsl:attribute name="space-before.maximum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
	<xsl:attribute name="hyphenate">false</xsl:attribute>
	<xsl:attribute name="color">
		<xsl:choose>
			<xsl:when test="not(parent::chapter | parent::article | parent::appendix)"><xsl:value-of select="$title.color"/></xsl:when>
		</xsl:choose>
	</xsl:attribute>
	<xsl:attribute name="text-align">
		<xsl:choose>
			<xsl:when test="((parent::article | parent::articleinfo) and not(ancestor::book) and not(self::bibliography))				 or (parent::slides | parent::slidesinfo)">center</xsl:when>
			<xsl:otherwise>left</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>
	<xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left"/></xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="chapter.titlepage.recto.style">
	<xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
	<xsl:attribute name="background-color">white</xsl:attribute>
	<xsl:attribute name="font-size">
		<xsl:choose>
			<xsl:when test="$l10n.gentext.language = 'ja-JP'">
				<xsl:value-of select="$body.font.master * 1.7"/>
				<xsl:text>pt</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>24pt</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
	<xsl:attribute name="text-align">left</xsl:attribute>
	<!--xsl:attribute name="wrap-option">no-wrap</xsl:attribute-->
	<xsl:attribute name="padding-left">1em</xsl:attribute>
	<xsl:attribute name="padding-right">1em</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="preface.titlepage.recto.style">
	<xsl:attribute name="font-family">
		<xsl:value-of select="$title.fontset"/>
	</xsl:attribute>
	<xsl:attribute name="color">#a70000</xsl:attribute>
	<xsl:attribute name="font-size">12pt</xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="part.titlepage.recto.style">
  <xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>

<!-- Lists -->

<xsl:param name="variablelist.as.blocks">1</xsl:param>

<!-- Cross References -->

<xsl:attribute-set name="xref.properties">
  <xsl:attribute name="font-style">italic</xsl:attribute>
  <xsl:attribute name="color">
	<xsl:choose>
		<xsl:when test="ancestor::note or ancestor::caution or ancestor::important or ancestor::warning or ancestor::tip">
			<xsl:text>#aee6ff</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>#0066cc</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:attribute>
</xsl:attribute-set>

<!-- Property Sets -->

<!-- Profiling -->

<!-- Localization -->

<!-- Graphics -->

<!-- Glossary -->


</xsl:stylesheet>
