<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="interval" as="xs:double" select="2.47154"/>
    <xsl:variable name="rectLength" as="xs:double" select="10.94308"/>
    <xsl:variable name="rectInterval" as="xs:double" select="$interval + $rectLength"/>
    <xsl:variable name="meetingCount" as="xs:integer" select="count(//TEI)"/>
    <xsl:variable name="yScale" as="xs:integer" select="35"/>
    <xsl:variable name="maxAng" as="xs:integer" select="max(//TEI/count(descendant::w[not(ancestor::foreign)]))"/>
    <xsl:variable name="yLength" as="xs:integer" select="$yScale * 16"/>
    <xsl:variable name="xLength" as="xs:double" select="$rectInterval * $meetingCount"/>
    <xsl:variable name="authors" as="xs:string+" select="distinct-values(//TEI/descendant::listPerson/descendant::persName[following-sibling::roleName[@role='corresp']])"/>
    <xsl:template match="/">
        <div class="loan-raw">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 640">
                <g transform="translate(50,600)">
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                    <xsl:for-each select="$authors">
                        <xsl:variable name="currentAuthor" select="."/>
                        <xsl:variable name="currentAuthorPos" as="xs:integer" select="position()"/>
                        <xsl:for-each select="$root//TEI">
                            <xsl:variable name="mtPos" select="count(preceding::TEI)"/>
                            <xsl:variable name="meetingAuthor" select="descendant::listPerson/descendant::persName[following-sibling::roleName[@role='corresp']]"/>
                            <xsl:choose>
                                <xsl:when test="$currentAuthor eq $meetingAuthor and $currentAuthorPos eq 1">
                                    <rect x="{$mtPos * $rectInterval}" y="-{$yLength}" height="{$yLength}" width="{$rectInterval}" fill="pink" fill-opacity="0.4"/>
                                </xsl:when>
                                <xsl:when test="$currentAuthor eq $meetingAuthor and $currentAuthorPos eq 2">
                                    <rect x="{$mtPos * $rectInterval}" y="-{$yLength}" height="{$yLength}" width="{$rectInterval}" fill="purple" fill-opacity="0.4"/>
                                </xsl:when>
                                <xsl:when test="$currentAuthor eq $meetingAuthor and $currentAuthorPos eq 3">
                                    <rect x="{$mtPos * $rectInterval}" y="-{$yLength}" height="{$yLength}" width="{$rectInterval}" fill="orange" fill-opacity="0.4"/>
                                </xsl:when>
                                <xsl:when test="$currentAuthor eq $meetingAuthor and $currentAuthorPos eq 4">
                                    <rect x="{$mtPos * $rectInterval}" y="-{$yLength}" height="{$yLength}" width="{$rectInterval}" fill="yellow" fill-opacity="0.4"/>
                                </xsl:when>
                                <xsl:when test="$currentAuthor eq $meetingAuthor and $currentAuthorPos eq 5">
                                    <rect x="{$mtPos * $rectInterval}" y="-{$yLength}" height="{$yLength}" width="{$rectInterval}" fill="gray" fill-opacity="0.4"/>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:for-each>
                    <xsl:apply-templates select="//TEI"/>
                    <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
                    <line x1="0" y1="-{$yScale * 16}" x2="{$xLength}" y2="-{$yScale * 16}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 16 - 5}" text-anchor="middle">16</text>
                    <line x1="0" y1="-{$yScale * 14}" x2="{$xLength}" y2="-{$yScale * 14}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 14 - 5}" text-anchor="middle">14</text>
                    <line x1="0" y1="-{$yScale * 12}" x2="{$xLength}" y2="-{$yScale * 12}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 12 - 5}" text-anchor="middle">12</text>
                    <line x1="0" y1="-{$yScale * 10}" x2="{$xLength}" y2="-{$yScale * 10}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 10 - 5}" text-anchor="middle">10</text>
                    <line x1="0" y1="-{$yScale * 8}" x2="{$xLength}" y2="-{$yScale * 8}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 8 - 5}" text-anchor="middle">8</text>
                    <line x1="0" y1="-{$yScale * 6}" x2="{$xLength}" y2="-{$yScale * 6}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 6 - 5}" text-anchor="middle">6</text>
                    <line x1="0" y1="-{$yScale * 4}" x2="{$xLength}" y2="-{$yScale * 4}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 4 - 5}" text-anchor="middle">4</text>
                    <line x1="0" y1="-{$yScale * 2}" x2="{$xLength}" y2="-{$yScale * 2}" stroke="gray" stroke-dasharray="10,5" stroke-width="1"/>
                    <text x="-20" y="-{$yScale * 2 - 5}" text-anchor="middle">2</text>
                    
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="TEI" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="meetingPos" as="xs:integer" select="count(preceding::TEI)"/>
        <xsl:variable name="angCount" as="xs:integer" select="count(descendant::w[not(ancestor::foreign)][not(ancestor::list[@subtype = 'ballo' or @subtype = 'picnic'])])"/>
        <xsl:variable name="angEventCount" as="xs:integer" select="count(descendant::w[not(ancestor::foreign)][ancestor::list[@subtype = 'ballo' or @subtype = 'picnic']])"/>
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
        <xsl:if test="descendant::foreign">
            <g>
                <text x="{($meetingPos * $rectInterval) + $interval * 4}" y="-{$angCount * $yScale}" text-anchor="middle">*</text>
            </g>
        </xsl:if>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="year" as="xs:string" select="teiHeader/fileDesc/descendant::date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="lastMeeting" select="descendant::TEI[last()]"/>
        <xsl:variable name="lastMeetingPos" as="xs:integer" select="$lastMeeting/count(preceding::TEI) + 1"/>
        <g>
            <line x1="{($lastMeetingPos * $rectInterval) + $interval div 2}" y1="0" x2="{($lastMeetingPos * $rectInterval)}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
            <text x="{(count(preceding::TEI) * $rectInterval) + ((count(descendant::TEI) div 2) * $rectInterval)}" y="20" text-anchor="middle"><xsl:value-of select="$year"/></text>
        </g>
    </xsl:template>
</xsl:stylesheet>
