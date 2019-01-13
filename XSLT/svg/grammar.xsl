<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tos="http://toscana.newtfire.org"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="yLength" as="xs:integer" select="500"/>
    <xsl:variable name="angCount" as="xs:integer" select="count(//w[not(ancestor::foreign)])"/>
    <xsl:variable name="xLength" as="xs:double" select="$angCount * 6.5789"/>
    <xsl:template match="/">
        <div class="grammar">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 640">
                <g transform="translate(120,550)">
                    <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
                    <!-- Graph borders -->
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength}" x2="{$xLength}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength}" y1="0" x2="{$xLength}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                    
                    <!-- X-axis milestones -->
                    <line x1="{$xLength * .1}" y1="0" x2="{$xLength * .1}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .2}" y1="0" x2="{$xLength * .2}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .3}" y1="0" x2="{$xLength * .3}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .4}" y1="0" x2="{$xLength * .4}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .5}" y1="0" x2="{$xLength * .5}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .6}" y1="0" x2="{$xLength * .6}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .7}" y1="0" x2="{$xLength * .7}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .8}" y1="0" x2="{$xLength * .8}" y2="-10" stroke="black" stroke-width="1"/>
                    <line x1="{$xLength * .9}" y1="0" x2="{$xLength * .9}" y2="-10" stroke="black" stroke-width="1"/>
                    
                    <!-- Y-axis milestones -->
                    <line x1="0" y1="-{$yLength * .1}" x2="10" y2="-{$yLength * .1}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .2}" x2="10" y2="-{$yLength * .2}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .3}" x2="10" y2="-{$yLength * .3}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .4}" x2="10" y2="-{$yLength * .4}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .5}" x2="10" y2="-{$yLength * .5}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .6}" x2="10" y2="-{$yLength * .6}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .7}" x2="10" y2="-{$yLength * .7}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .8}" x2="10" y2="-{$yLength * .8}" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .9}" x2="10" y2="-{$yLength * .9}" stroke="black" stroke-width="1"/>
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="totalCount" as="xs:integer" select="count(descendant::w[not(ancestor::foreign)])"/>
        <xsl:variable name="grammaticalCount" as="xs:integer" select="count(descendant::w[not(ancestor::foreign) and @tos:accordo='y'])"/>
        <xsl:variable name="ungrammaticalCount" as="xs:integer" select="count(descendant::w[not(ancestor::foreign) and @tos:accordo='n'])"/>
        <xsl:variable name="naCount" as="xs:integer" select="count(descendant::w[not(ancestor::foreign) and @tos:accordo='na'])"/>
        <xsl:variable name="precedingCount" as="xs:integer" select="count(preceding-sibling::teiCorpus/descendant::w[not(ancestor::foreign)])"/>
        <rect x="{$precedingCount div $angCount * 100}" y="-{$grammaticalCount div $totalCount * 100}" height="{$grammaticalCount div $totalCount * 100}" width="{$totalCount div $angCount * 100}" fill="green" stroke="black"/>
    </xsl:template>
</xsl:stylesheet>