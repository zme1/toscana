<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tos="http://toscana.newtfire.org"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="maxAngCount" as="xs:integer"
        select="max(/teiCorpus/teiCorpus/count(descendant::w[not(ancestor::foreign) and @tos:orth = 'eng']))"/>
    <xsl:variable name="yLength" as="xs:integer" select="265"/>
    <xsl:variable name="yScale" as="xs:double" select="$yLength div $maxAngCount"/>
    <xsl:variable name="xLength" as="xs:integer" select="1000"/>
    <xsl:variable name="yearLength" as="xs:double" select="$xLength div count(/teiCorpus/teiCorpus)"/>
    <xsl:variable name="rectLength" as="xs:double" select="$yearLength * .8"/>
    <xsl:variable name="rectInterval" as="xs:double" select="$yearLength * .1"/>
    <xsl:template match="/">
        <div class="grammar">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 640">
                <g transform="translate(120,290)">
                    
                    <!-- Graph labels -->
                    
                    <rect x="0" y="{$yLength + 15}" height="25" width="25" stroke="white" fill="#CE4B29"/>
                    <text x="32" y="{$yLength + 35}" fill="white" text-anchor="start">Loanwords used in event-based discussion</text>
                    <rect x="0" y="{$yLength + 45}" height="25" width="25" stroke="white" fill="#3E6E63"/>
                    <text x="32" y="{$yLength + 65}" fill="white" text-anchor="start">Loanwords used in any other context</text>
                    
                    <text x="-50" y="-{$yLength div 2 - 15}"
                        transform="rotate(270,-60,-{$yLength div 2})" text-anchor="middle"
                        fill="white" font-size="20px">English orthography</text>
                    <text x="-50" y="{$yLength div 2 + 15}" fill="white"
                        transform="rotate(270,-60,{$yLength div 2})" text-anchor="middle"
                        font-size="20px">Italian orthography</text>
                    <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
                    
                    <text x="-15" y="-{$yScale * 32 - 5}" fill="white" text-anchor="middle">32</text>
                    <line x1="0" y1="-{$yScale * 28}" x2="{$xLength}" y2="-{$yScale * 28}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <line x1="0" y1="-{$yScale * 24}" x2="{$xLength}" y2="-{$yScale * 24}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="-{$yScale * 24 - 5}" fill="white" text-anchor="middle">24</text>
                    <line x1="0" y1="-{$yScale * 20}" x2="{$xLength}" y2="-{$yScale * 20}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <line x1="0" y1="-{$yScale * 16}" x2="{$xLength}" y2="-{$yScale * 16}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="-{$yScale * 16 - 5}" fill="white" text-anchor="middle">16</text>
                    <line x1="0" y1="-{$yScale * 12}" x2="{$xLength}" y2="-{$yScale * 12}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <line x1="0" y1="-{$yScale * 8}" x2="{$xLength}" y2="-{$yScale * 8}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="-{$yScale * 8 - 5}" fill="white" text-anchor="middle">8</text>
                    <line x1="0" y1="-{$yScale * 4}" x2="{$xLength}" y2="-{$yScale * 4}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="5" fill="white" text-anchor="middle">0</text>
                    <line x1="0" y1="{$yScale * 4}" x2="{$xLength}" y2="{$yScale * 4}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="{$yScale * 8 + 5}" fill="white" text-anchor="middle">8</text>
                    <line x1="0" y1="{$yScale * 8}" x2="{$xLength}" y2="{$yScale * 8}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <line x1="0" y1="{$yScale * 12}" x2="{$xLength}" y2="{$yScale * 12}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <line x1="0" y1="{$yScale * 16}" x2="{$xLength}" y2="{$yScale * 16}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="{$yScale * 16 + 5}" fill="white" text-anchor="middle">16</text>
                    <line x1="0" y1="{$yScale * 20}" x2="{$xLength}" y2="{$yScale * 20}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <line x1="0" y1="{$yScale * 24}" x2="{$xLength}" y2="{$yScale * 24}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="{$yScale * 24 + 5}" fill="white" text-anchor="middle">24</text>
                    <line x1="0" y1="{$yScale * 28}" x2="{$xLength}" y2="{$yScale * 28}"
                        stroke="white" stroke-dasharray="5,8" stroke-width="1"/>
                    <text x="-15" y="{$yScale * 32 + 5}" fill="white" text-anchor="middle">32</text>
                    
                    <!-- Top half of the graph -->
                    
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="white" stroke-width="1.5"/>
                    <line x1="0" y1="-{$yLength}" x2="{$xLength}" y2="-{$yLength}" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength}" y1="0" x2="{$xLength}" y2="-{$yLength}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="white" stroke-width="1"/>
                    
                    <!-- Bottom half of the graph -->
                    
                    <line x1="0" y1="{$yLength}" x2="{$xLength}" y2="{$yLength}" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength}" y1="0" x2="{$xLength}" y2="{$yLength}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="{$yLength}" stroke="white" stroke-width="1"/>
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="year" as="xs:string"
            select="teiHeader/fileDesc/descendant::date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="position" as="xs:integer" select="position() - 1"/>
        <xsl:variable name="engMeeting" as="xs:integer"
            select="count(descendant::w[@tos:orth = 'eng' and ancestor::list[@subtype = 'ballo' or @subtype = 'picnic'] and not(ancestor::foreign)])"/>
        <xsl:variable name="itMeeting" as="xs:integer"
            select="count(descendant::w[@tos:orth = 'it' and ancestor::list[@subtype = 'ballo' or @subtype = 'picnic'] and not(ancestor::foreign)])"/>
        <xsl:variable name="eng" as="xs:integer"
            select="count(descendant::w[@tos:orth = 'eng' and not(ancestor::list[@subtype = 'ballo' or @subtype = 'picnic']) and not(ancestor::foreign)])"/>
        <xsl:variable name="it" as="xs:integer"
            select="count(descendant::w[@tos:orth = 'it' and not(ancestor::list[@subtype = 'ballo' or @subtype = 'picnic']) and not(ancestor::foreign)])"/>
        <g>
            <rect x="{$position * $yearLength + $rectInterval}"
                y="-{($yScale * $eng) + ($yScale * $engMeeting)}" height="{$yScale * $eng}"
                width="{$rectLength}" stroke="white" fill="#3E6E63"/>
            <rect x="{$position * $yearLength + $rectInterval}" y="-{$yScale * $engMeeting}"
                height="{$yScale * $engMeeting}" width="{$rectLength}" stroke="white" fill="#CE4B29"/>
            <rect x="{$position * $yearLength + $rectInterval}" y="0"
                height="{$yScale * $itMeeting}" width="{$rectLength}" stroke="white" fill="#CE4B29"/>
            <rect x="{$position * $yearLength + $rectInterval}" y="{$yScale * $itMeeting}"
                height="{$yScale * $it}" width="{$rectLength}" stroke="white" fill="#3E6E63"/>
            <text x="{($position * $yearLength) + $rectInterval + ($rectLength div 2)}" y="{$yScale * ($it + $itMeeting) + 15}" fill="white" text-anchor="middle"><xsl:value-of select="$year"/></text>
        </g>
    </xsl:template>
</xsl:stylesheet>
