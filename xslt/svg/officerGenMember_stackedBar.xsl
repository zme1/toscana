<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xpath-default-namespace="http://toscana.newtfire.org" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="xLength" as="xs:integer" select="900"/>
    <xsl:variable name="yLength" as="xs:integer" select="550"/>
    <xsl:variable name="yScale" as="xs:double" select="$yLength div 100"/>
    <xsl:variable name="barInt" as="xs:integer" select="20"/>
    <xsl:variable name="xScale" as="xs:double" select="0.46"/>
    <xsl:template match="/">
        <svg height="100%" width="100%">
            <g transform="translate(50,600)">
                <xsl:apply-templates select="//year"/>
                <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                <line x1="0" y1="0" x2="" y2="-{$yLength}" stroke="black" stroke-width="1"/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="year">
        <xsl:variable name="position" select="position()"/>
        <xsl:variable name="officerCount" as="xs:double" select="sum(officers/officer)"/>
        <xsl:variable name="totalCount" as="xs:integer" select="total"/>
        <xsl:variable name="genMemberCount" as="xs:double" select="$totalCount - $officerCount"/>
        <xsl:variable name="precedingWidth" as="xs:double"
            select="sum(preceding-sibling::year/total) * $xScale"/>
        <rect x="{$precedingWidth + ($barInt * $position)}" y="-{($officerCount div $totalCount * 100) * $yScale}"
            height="{($officerCount div $totalCount * 100) * $yScale}" width="{$totalCount * $xScale}" fill="blue"/>
        <rect x="{$precedingWidth + ($barInt * $position)}" y="-{$yLength}" height="{($genMemberCount div $totalCount * 100) * $yScale}" width="{$totalCount * $xScale}" fill="red"/>
    </xsl:template>
</xsl:stylesheet>
