<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    <!-- A COUNT OF ALL ACCEPTED APPLICANTS ANY GIVEN YEAR BEFORE THE MONTH OF JULY -->
    <!-- count(//TEI/descendant::date[@when/number(tokenize(., '\-')[2]) le 6]/ancestor::TEI//list[@type='applicants']/descendant::item[not(persName[@role='rejected'])]) -->

    <!-- A COUNT OF ALL ACCEPTED APPLICANTS IN A FULL CALENDAR YEAR -->
    <!-- count(//TEI//list[@type='applicants']/descendant::item[not(persName[@role='rejected'])]) -->

    <xsl:variable name="minuteColl" select="collection('../../TEI/meetingMinutes')/*"/>
    
    <!-- Variables that access specific XML files in the repository files -->
    <xsl:variable name="barWidth" as="xs:integer" select="70"/>
    <xsl:variable name="barInterval" as="xs:integer" select="5"/>
    <xsl:variable name="yrLength" as="xs:integer" select="($barWidth * 2) + ($barInterval * 2)"/>
    <xsl:variable name="yScale" as="xs:integer" select="10"/>
    <xsl:variable name="barCount" select="count($minuteColl) * 2"/>
    <xsl:variable name="xLength" select="($yrLength * 7) + 20"/>
    <xsl:variable name="yLength" select="$yScale * 65 + 20"/>
    <xsl:template match="/">
        <svg width="2000" height="7500">
            <g transform="translate(100,700)">
                <xsl:for-each select="$minuteColl//TEI/ancestor::teiCorpus">
                    <xsl:variable name="dateNum" select="descendant::TEI[1]/descendant::date/@when/number(tokenize(., '\-')[1])"/>
                    <xsl:variable name="accettati" select="count(//list[@type='applicants']//item[not(role='rejected')])"/>
                    <xsl:variable name="cancellati" select="count(//list[@type='cancellati']//item)"/>
                    <rect x="{($barInterval) + ($yrLength * ($dateNum - 1919))}" y="-{$accettati * $yScale}" height="{$accettati * $yScale}" width="{$barWidth}" style="fill:blue"/>
                    <rect x="{$yrLength * ($dateNum - 1919) + $barWidth + $barInterval}" y="-{$cancellati * $yScale}" height="{$cancellati * $yScale}" width="{$barWidth}" style="fill:red"/>
                </xsl:for-each> 
                <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke-width="1" stroke="black"/>
                <line x1="0" y1="0" x2="{0}" y2="-{$yLength}" stroke-width="1" stroke="black"/>
                <!-- Axis lines -->
                <line x1="0" y1="-{$yScale * 65}" x2="{$xLength}" y2="-{$yScale * 65}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 65 - 5}" text-anchor="middle">65</text>
                <line x1="0" y1="-{$yScale * 60}" x2="{$xLength}" y2="-{$yScale * 60}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 60 - 5}" text-anchor="middle">60</text>
                <line x1="0" y1="-{$yScale * 55}" x2="{$xLength}" y2="-{$yScale * 55}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 55 - 5}" text-anchor="middle">55</text>
                <line x1="0" y1="-{$yScale * 50}" x2="{$xLength}" y2="-{$yScale * 50}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 50 - 5}" text-anchor="middle">50</text>
                <line x1="0" y1="-{$yScale * 45}" x2="{$xLength}" y2="-{$yScale * 45}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 45 - 5}" text-anchor="middle">45</text>
                <line x1="0" y1="-{$yScale * 40}" x2="{$xLength}" y2="-{$yScale * 40}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 40 - 5}" text-anchor="middle">40</text>
                <line x1="0" y1="-{$yScale * 35}" x2="{$xLength}" y2="-{$yScale * 35}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 35 - 5}" text-anchor="middle">35</text>
                <line x1="0" y1="-{$yScale * 30}" x2="{$xLength}" y2="-{$yScale * 30}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 30 - 5}" text-anchor="middle">30</text>
                <line x1="0" y1="-{$yScale * 25}" x2="{$xLength}" y2="-{$yScale * 25}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 25 - 5}" text-anchor="middle">25</text>
                <line x1="0" y1="-{$yScale * 20}" x2="{$xLength}" y2="-{$yScale * 20}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 20 - 5}" text-anchor="middle">20</text>
                <line x1="0" y1="-{$yScale * 15}" x2="{$xLength}" y2="-{$yScale * 15}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 15 - 5}" text-anchor="middle">15</text>
                <line x1="0" y1="-{$yScale * 10}" x2="{$xLength}" y2="-{$yScale * 10}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 10 - 5}" text-anchor="middle">10</text>
                <line x1="0" y1="-{$yScale * 5}" x2="{$xLength}" y2="-{$yScale * 5}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$yScale * 5 - 5}" text-anchor="middle">5</text>
                
                <!-- Y AXIS MARKINGS -->
                
                <text x="{$barWidth + $barInterval}" y="20" text-anchor="middle">1919</text>
                <line x1="{$yrLength}" y1="0" x2="{$yrLength}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <text x="{$yrLength + ($barWidth + $barInterval)}" y="20" text-anchor="middle">1920</text>
                <line x1="{$yrLength * 2}" y1="0" x2="{$yrLength * 2}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <text x="{($yrLength * 2)  + ($barWidth + $barInterval)}" y="20" text-anchor="middle">1921</text>
                <line x1="{$yrLength * 3}" y1="0" x2="{$yrLength * 3}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <text x="{($yrLength * 3) + ($barWidth + $barInterval)}" y="20" text-anchor="middle">1922</text>
                <line x1="{$yrLength * 4}" y1="0" x2="{$yrLength * 4}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <text x="{($yrLength * 4) + ($barWidth + $barInterval)}" y="20" text-anchor="middle">1923</text>
                <line x1="{$yrLength * 5}" y1="0" x2="{$yrLength * 5}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <text x="{($yrLength * 5) + ($barWidth + $barInterval)}" y="20" text-anchor="middle">1924</text>
                <line x1="{$yrLength * 6}" y1="0" x2="{$yrLength * 6}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <text x="{($yrLength * 6) + ($barWidth + $barInterval)}" y="20" text-anchor="middle">1925</text>
                <line x1="{$yrLength * 7}" y1="0" x2="{$yrLength * 7}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <!-- X AXIS MARKINGS -->
            </g>
        </svg>

    </xsl:template>
</xsl:stylesheet>
