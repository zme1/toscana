<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="xLength" as="xs:integer" select="900"/>
    <xsl:variable name="yLength" as="xs:integer" select="550"/>
    <xsl:variable name="xScale" as="xs:double" select="0.5"/>
    <xsl:variable name="yScale" as="xs:double" select="$yLength div 100"/>
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" height="100%" width="100%">
            <g transform="translate(50,600)">
                <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"/>
            </g>
        </svg>
        <xsl:for-each select="year">
            <xsl:apply-templates select="act"/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="act">
        
    </xsl:template>
</xsl:stylesheet>