<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="dotInterval" as="xs:double" select="13.4146"/>
    <xsl:variable name="meetingCount" as="xs:integer" select="count(//TEI)"/>
    <xsl:variable name="yScale" as="xs:integer" select="10"/>
    <xsl:variable name="maxAng" as="xs:integer" select="max(//TEI/count(descendant::w))"/>
    <xsl:variable name="yLength" as="xs:integer" select="$maxAng * $yScale + 20"/>
    <xsl:variable name="xLength" as="xs:double" select="($dotInterval * $meetingCount) + 20"/>
    <xsl:template match="/">
        <div class="loan-raw">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 640">
                <g transform="translate(50,600)">
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                    <text x="100" y="30" text-align="center">hi</text>
                    <xsl:apply-templates select="//TEI"/>
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="TEI" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="preMeetingCount" as="xs:integer" select="count(preceding::TEI)"/>
        <xsl:variable name="angCount" as="xs:integer" select="count(descendant::w)"/>
        <xsl:choose>
            <xsl:when test="descendant::list[@subtype = 'ballo' or @subtype = 'picnic']">
                <g>
                    <rect x="{$preMeetingCount * $dotInterval + $dotInterval - 7}"
                        y="-{$angCount * $yScale + 7}" height="7" width="7"/>
                </g>
            </xsl:when>
            <xsl:otherwise>
                <g>
                    <circle cx="{$preMeetingCount * $dotInterval + $dotInterval}"
                        cy="-{$angCount * $yScale}" r="3"/>
                </g>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
