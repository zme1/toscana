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
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <xsl:variable name="currentYear" select="current()"/>
        <xsl:variable name="yearPos" select="position()"/>
        <xsl:variable name="year" as="xs:string" select="teiHeader/fileDesc/descendant::date/@when"/>
        <xsl:for-each select="$distinctLemmas">
            <xsl:variable name="lemmaPos" select="position()"/>
            <xsl:if test="$currentYear/descendant::w[not(ancestor::foreign) and @lemma eq current()]">
                <circle cx="" cy="" r="{math:sqrt(count(.)* math:pi() )}" fill=""/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>