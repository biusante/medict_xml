<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:variable name="littre1873" select="document('../xml/medict37020d.xml')"/>
  <xsl:key name="id" match="tei:entry" use="@xml:id"/>


  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="tei:dictScrap">
    <xsl:variable name="id" select="ancestor-or-self::tei:entry/@xml:id"/>
    <xsl:variable name="scrap">
      <xsl:for-each select="$littre1873">
        <xsl:copy-of select="key('id', $id)/tei:dictScrap"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$scrap != ''">
        <xsl:copy-of select="$scrap"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  

  <xsl:template match="tei:entryOLD">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="found">
      <xsl:for-each select="$littre1873">
        <xsl:copy-of select="key('id', $id)"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:if test="$found = ''">
        <xsl:attribute name="corresp">
          <xsl:variable name="corresp">
            <xsl:value-of select="@corresp"/>
            <xsl:text> medict37020d.xml</xsl:text>
          </xsl:variable>
          <xsl:value-of select="normalize-space($corresp)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
</xsl:transform>
