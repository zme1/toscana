<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://toscana.newtfire.org" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="xLength" as="xs:integer" select="1000"/>
    <xsl:variable name="yLength" as="xs:integer" select="550"/>
    <xsl:variable name="yScale" as="xs:double" select="$yLength div 100"/>
    <xsl:variable name="barInt" as="xs:integer" select="20"/>
    <xsl:variable name="xScale" as="xs:double" select="0.51"/>
    <xsl:template match="/">
        <div class="activityStacked">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1400 730">
                <g transform="translate(220,600)">
                    <text x="0" y="-{$yLength + 20}" text-anchor="start" fill="white"
                        font-size="30px" text-decoration="underline">Figure 4</text>
                    <xsl:apply-templates select="//year"/>
                    <line x1="0" y1="-{$yLength}" x2="{$xLength}" y2="-{$yLength}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yScale * 90}" x2="{$xLength}" y2="-{$yScale * 90}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 80}" x2="{$xLength}" y2="-{$yScale * 80}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 70}" x2="{$xLength}" y2="-{$yScale * 70}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 60}" x2="{$xLength}" y2="-{$yScale * 60}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 50}" x2="{$xLength}" y2="-{$yScale * 50}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 40}" x2="{$xLength}" y2="-{$yScale * 40}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 30}" x2="{$xLength}" y2="-{$yScale * 30}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 20}" x2="{$xLength}" y2="-{$yScale * 20}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <line x1="0" y1="-{$yScale * 10}" x2="{$xLength}" y2="-{$yScale * 10}"
                        stroke="white" stroke-width="1" stroke-dasharray="8,4"/>
                    <text x="-60" y="-{$yLength div 2}"
                        transform="rotate(270,-60,-{$yLength div 2})" text-anchor="middle"
                        font-size="30px" fill="white">Percentage of member activity</text>
                    <text x="-20" y="-{$yScale * 80 - 7}" text-anchor="middle" fill="white"
                        >80%</text>
                    <text x="-20" y="-{$yScale * 60 - 7}" text-anchor="middle" fill="white"
                        >60%</text>
                    <text x="-20" y="-{$yScale * 40 - 7}" text-anchor="middle" fill="white"
                        >40%</text>
                    <text x="-20" y="-{$yScale * 20 - 7}" text-anchor="middle" fill="white"
                        >20%</text>
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="white" stroke-width="1"/>
                    <line x1="0" y1="0" x2="" y2="-{$yLength}" stroke="white" stroke-width="1"/>
                    <line x1="20" y1="30" x2="20" y2="60" stroke="white" stroke-width="1"/>
                    <line x1="{20 + $xScale * 100}" y1="30" x2="{20 + $xScale * 100}" y2="60"
                        stroke="white" stroke-width="1"/>
                    <line x1="20" y1="45" x2="{20 + $xScale * 100}" y2="45" stroke="white"
                        stroke-width="2"/>
                    <text x="{20 + $xScale * 50}" y="80" text-anchor="middle" fill="white">100 units
                        of activity</text>
                    <rect x="200" y="40" height="25" width="25" stroke="white" stroke-width="1" fill="#3E6E63"/>
                    <text x="235" y="57" text-anchor="start" fill="white">Officer activity</text>
                    <rect x="200" y="90" height="25" width="25" stroke="white" stroke-width="1" fill="#CE4B29"/>
                    <text x="235" y="107" text-anchor="start" fill="white">General member activity</text>
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="year" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="position" select="position()"/>
        <xsl:variable name="officerCount" as="xs:double" select="sum(officers/officer)"/>
        <xsl:variable name="totalCount" as="xs:integer" select="total"/>
        <xsl:variable name="genMemberCount" as="xs:double" select="$totalCount - $officerCount"/>
        <xsl:variable name="precedingWidth" as="xs:double"
            select="sum(preceding-sibling::year/total) * $xScale"/>
        <rect x="{$precedingWidth + ($barInt * $position)}"
            y="-{($officerCount div $totalCount * 100) * $yScale}"
            height="{($officerCount div $totalCount * 100) * $yScale}"
            width="{$totalCount * $xScale}" stroke="white" fill="#3E6E63"/>
        <text x="{$precedingWidth + ($barInt * $position) + ($totalCount * $xScale div 2)}"
            y="-{($officerCount div $totalCount * 100) * $yScale - 35}" text-anchor="middle"
            fill="white">
            <xsl:value-of select="$officerCount"/>
        </text>
        <rect x="{$precedingWidth + ($barInt * $position)}" y="-{$yLength}"
            height="{($genMemberCount div $totalCount * 100) * $yScale}"
            width="{$totalCount * $xScale}" stroke="white" fill="#CE4B29"/>
        <text x="{$precedingWidth + ($barInt * $position) + ($totalCount * $xScale div 2)}"
            y="-{($officerCount div $totalCount * 100) * $yScale + 25}" text-anchor="middle"
            fill="white">
            <xsl:value-of select="$genMemberCount"/>
        </text>
        <text x="{$precedingWidth + ($barInt * $position) + ($totalCount * $xScale div 2)}" y="20"
            text-anchor="middle" fill="white">
            <xsl:value-of select="@when"/>
        </text>
    </xsl:template>
</xsl:stylesheet>
