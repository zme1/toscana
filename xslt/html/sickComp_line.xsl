<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="dotInterval" as="xs:integer" select="90"/>
    <xsl:variable name="xLength" select="$dotInterval * 12 + 20"/>
    <xsl:variable name="yScale" select="1"/>
    <xsl:variable name="maxComp"
        select="max(/teiCorpus/teiCorpus/sum(descendant::seg[@subtype = 'sick']/num/@value/number()))"/>
    <xsl:variable name="yLength" select="$maxComp * $yScale + 20"/>
    <!-- 
        Single month/meeting with the most money distributed to members
        max(//TEI[descendant::seg[@subtype='sick']]/sum(descendant::seg[@subtype='sick']/num/@value/number())) 
    -->
    <!-- Entire year with the most money distributed to members
        max(/teiCorpus/teiCorpus/sum(descendant::seg[@subtype='sick']/num/@value/number()))
    -->
    <xsl:template match="/">
        <div class="sickCompContainer">
            <div class="sickCompSvg">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1250 650">
                    <g transform="translate(70,600)">
                        <xsl:apply-templates select="teiCorpus/teiCorpus"/>
                        <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="1"/>
                        <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="1"
                        />
                    </g>
                </svg>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" xmlns="http://www.w3.org/2000/svg">
        <line x1="0" y1="0" x2="{$dotInterval}" y2="-{TEI[1]/sum(descendant::seg[@subtype = 'sick']/num/@value)}" stroke="blue" stroke-width="1"/>
        <xsl:apply-templates select="TEI"/>
    </xsl:template>
    <xsl:template match="TEI" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="compValue" select="sum(descendant::seg[@subtype = 'sick']/num/@value)"/>
        <xsl:variable name="runningTotal" select="sum(preceding-sibling::TEI/sum(descendant::seg[@subtype = 'sick']/num/@value))"/>
        <xsl:variable name="xPos"
            select="(teiHeader/descendant::date/number(tokenize(@when, '-')[2])) * $dotInterval"/>
        <xsl:variable name="yPos" select="($runningTotal + $compValue) * $yScale"/>
        <circle cx="{$xPos}" cy="-{$yPos}" r="4" fill="blue"/>
        <xsl:if test="following-sibling::TEI[not(teiHeader/descendant::date[@when = '1920-12-30'])]">
            <line x1="{$xPos}" y1="-{$yPos}"
                x2="{following-sibling::TEI[1]/(teiHeader/descendant::date/number(tokenize(@when, '-')[2])) * $dotInterval}"
                y2="-{($runningTotal + $compValue + following-sibling::TEI[1]/sum(descendant::seg[@subtype='sick']/num/@value)) * $yScale}"
                stroke="blue" stroke-width="1"/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
