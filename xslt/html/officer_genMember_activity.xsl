<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    <!-- This visualization will use a stacked bar graph to compare the relative activity among that year's administrators and general members.
    The graph will look at the names referenced in the minutes that are not nested within any sort of list (which does not direcltly imply
    presence at the meeting) or <seg> elements of @subtype value "sick", which explicates absence. Constraining the graph to only specific
    elements and their nested contents would miss a wealth of shorthand discussion in the minutes that is not directly marked up, and which
    may include more general member activity than the proposals would. -->

    <xsl:variable name="minutesColl" select="../../tei/meetingMinutes/*[starts-with(., '1')]"/>
    <xsl:variable name="barWidth" as="xs:integer" select="140"/>
    <xsl:variable name="barInterval" as="xs:integer" select="5"/>
    <xsl:variable name="yrLength" as="xs:integer" select="$barWidth + $barInterval"/>
    <xsl:variable name="yScale" as="xs:integer" select="10"/>
    <xsl:variable name="barCount" select="count($minutesColl)"/>
    <xsl:variable name="xLength" select="($yrLength * 7) + 20"/>
    <xsl:variable name="yLength" select="$yScale * 65"/>
    <xsl:variable name="yOnePercent" select="$yLength div 100"/>
    <xsl:template match="/">
        <svg width="2000" height="750">
            <g transform="translate(100,700)">
                <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"/>
            </g>
        </svg>
        <xsl:for-each select="$minutesColl/parent::teiCorpus">
            <xsl:variable name="year" select="child::TEI//date/tokenize(@when, '-')[1]/number()"/>
            <xsl:variable name="position" select="$year - 1919"/>
            <rect x="{$position * $yrLength}" y="-200" width="{$barWidth}" height="200"/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
