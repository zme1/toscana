<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="lemmas" as="node()+" select="//w[not(ancestor::foreign)]/@lemma"/>
    <xsl:variable name="distinctLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
    <xsl:variable name="graphLemmas" as="xs:string+">
        <xsl:for-each select="$distinctLemmas">
            <xsl:if test="count($root/descendant::w[not(ancestor::foreign) and @lemma = current()]) ge 4">
                <xsl:value-of select="current()"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    
    <!-- The above XSLT variables are used to identify salient loanwords and compile them into a
    single string of values. -->
    
    <xsl:variable name="xLength" as="xs:integer" select="900"/>
    <xsl:variable name="yLength" as="xs:integer" select="600"/>
    <xsl:variable name="xInterval" as="xs:double" select="$xLength div count(/teiCorpus/teiCorpus)"/>
    <xsl:variable name="yInterval" as="xs:double" select="$yLength div count($graphLemmas)"/>
    
    <!-- The above XSLT variables are used to generate a table with incremental markings and axes. -->
    
    
    <xsl:template match="/">
        <div class="lemma-circle">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 680">
                <g transform="translate(120,650)">
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                    <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
                    <xsl:for-each select="$graphLemmas">
                        <xsl:variable name="lemmaPos" select="position()"/>
                        <text x="-10" y="-{$lemmaPos * $yInterval}" text-anchor="end"><xsl:value-of select="."/></text>
                        <line x1="0" y1="-{$lemmaPos * $yInterval}" x2="{$xLength}" y2="-{$lemmaPos * $yInterval}" stroke="gray" stroke-dasharray="5,10"/>
                    </xsl:for-each>
                    
                    <!-- The above <xsl:for-each> plots all the graph lemmas along the y-axis and generates
                    a dashed line along the x-axis. -->
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <xsl:variable name="currentYear" select="current()"/>
        <xsl:variable name="yearPos" select="position()"/>
        <xsl:variable name="year" as="xs:string" select="teiHeader/fileDesc/descendant::date/@when"/>
        <text x="{$yearPos * $xInterval}" y="15" text-anchor="middle" fill="black"><xsl:value-of select="$year"/></text>
        <line x1="{$yearPos * $xInterval}" y1="0" x2="{$yearPos * $xInterval}" y2="-{$yLength}" stroke="gray" stroke-dasharray="5,10"/>
        <xsl:for-each select="$graphLemmas">
            <xsl:variable name="lemmaPos" select="position()"/>
            <xsl:if test="$currentYear/descendant::w[not(ancestor::foreign) and @lemma eq current()]">
                <circle cx="{$yearPos * $xInterval}" cy="-{$lemmaPos * $yInterval}" r="{math:sqrt((count($currentYear/descendant::w[not(ancestor::foreign) and @lemma eq current()]) * 50) * math:pi() )}" fill="blue" fill-opacity=".7" stroke="black"/>
                <text x="{$yearPos * $xInterval}" y="-{$lemmaPos * $yInterval - 7}" text-anchor="middle" fill="black"><xsl:value-of select="count($currentYear/descendant::w[not(ancestor::foreign) and @lemma eq current()])"/></text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>