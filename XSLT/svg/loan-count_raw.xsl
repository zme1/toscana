<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- zme: rectangle interval: 4.47154
    rectangle length: 8.94308-->
    <xsl:variable name="interval" as="xs:double" select="2.47154"/>
    <xsl:variable name="rectLength" as="xs:double" select="10.94308"/>
    <xsl:variable name="rectInterval" as="xs:double" select="$interval + $rectLength"/>
    <xsl:variable name="meetingCount" as="xs:integer" select="count(//TEI)"/>
    <xsl:variable name="yScale" as="xs:integer" select="10"/>
    <xsl:variable name="maxAng" as="xs:integer" select="max(//TEI/count(descendant::w))"/>
    <xsl:variable name="yLength" as="xs:integer" select="$maxAng * $yScale + 20"/>
    <xsl:variable name="xLength" as="xs:double" select="$rectInterval * $meetingCount"/>
    <xsl:template match="/">
        <div class="loan-raw">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 640">
                <g transform="translate(50,600)">
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                    <xsl:apply-templates select="//TEI"/>
                    <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="TEI" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="meetingPos" as="xs:integer" select="count(preceding::TEI)"/>
        <xsl:variable name="angCount" as="xs:integer" select="count(descendant::w)"/>
        <xsl:choose>
            <xsl:when test="descendant::list[@subtype = 'ballo' or @subtype = 'picnic']">
                <g>
                    <rect x="{($meetingPos * $rectInterval) + $interval}"
                        y="-{$angCount * $yScale}" height="{$angCount * $yScale}" width="{$rectLength}" fill="blue"/>
                </g>
            </xsl:when>
            <xsl:when test="$angCount eq 0">
                <rect x="{$meetingPos * $rectInterval + $interval}" y="-10" height="10" width="{$rectLength}" fill="green"/>
            </xsl:when>
            <xsl:otherwise>
                <g>
                    <rect x="{$meetingPos * $rectInterval + $interval}" y="-{$angCount * $yScale}" height="{$angCount * $yScale}" width="{$rectLength}" fill="red"/>
                </g>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="lastMeeting" select="descendant::TEI[last()]"/>
        <xsl:variable name="lastMeetingPos" as="xs:integer" select="$lastMeeting/count(preceding::TEI) + 1"/>
        <g>
            <line x1="{($lastMeetingPos * $rectInterval) + $interval div 2}" y1="0" x2="{($lastMeetingPos * $rectInterval)}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
        </g>
    </xsl:template>
</xsl:stylesheet>
