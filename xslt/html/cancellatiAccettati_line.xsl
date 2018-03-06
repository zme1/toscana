<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    <!-- A COUNT OF ALL ACCEPTED APPLICANTS ANY GIVEN YEAR BEFORE THE MONTH OF JULY -->
    <!-- count(//TEI/descendant::date[@when/number(tokenize(., '\-')[2]) le 6]/ancestor::TEI//list[@type='applicants']/descendant::item[not(persName[@role='rejected'])]) -->
    <xsl:variable name="minuteColl" select="collection('../../TEI/meetingMinutes')/*"/>
    <!-- Variables that access specific XML files in the repository files -->
    <xsl:variable name="dotSpace" as="xs:integer" select="70"/>
    <xsl:variable name="dotScale" as="xs:integer" select="10"/>
    <xsl:variable name="dotCount" select="count($minuteColl) * 2"/>
    <xsl:variable name="xLength" select="$dotSpace * $dotCount + 20"/>
    <xsl:variable name="yLength" select="$dotScale *60 + 20"/>
    <xsl:template match="/">
        <svg width="1100" height="700">
            <g transform="translate(100,650)">
                <rect x="{$dotSpace * 2}" y="-{$yLength - 20}" width="{$dotSpace * 2}" height="{$yLength - 20}" style="fill:rgb(226,226,226)"/>
                <rect x="{$dotSpace * 6}" y="-{$yLength - 20}" width="{$dotSpace * 2}" height="{$yLength - 20}" style="fill:rgb(226,226,226)"/>
                <rect x="{$dotSpace * 10}" y="-{$yLength - 20}" width="{$dotSpace * 2}" height="{$yLength - 20 }" style="fill:rgb(226,226,226)"/>
                
                <!-- Shaded rectangles behind years 1920, 1922, and 1924 to distinguish calendar years -->
                
                <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black" stroke-width="2"/>
                <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="black" stroke-width="2"/>
                
                <!-- Axis lines -->
                <line x1="0" y1="-{$dotScale * 60}" x2="{$xLength}" y2="-{$dotScale * 60}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 60 - 5}" text-anchor="middle">60</text>
                <line x1="0" y1="-{$dotScale * 55}" x2="{$xLength}" y2="-{$dotScale * 55}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 55 - 5}" text-anchor="middle">55</text>
                <line x1="0" y1="-{$dotScale * 50}" x2="{$xLength}" y2="-{$dotScale * 50}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 50 - 5}" text-anchor="middle">50</text>
                <line x1="0" y1="-{$dotScale * 45}" x2="{$xLength}" y2="-{$dotScale * 45}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 45 - 5}" text-anchor="middle">45</text>
                <line x1="0" y1="-{$dotScale * 40}" x2="{$xLength}" y2="-{$dotScale * 40}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 40 - 5}" text-anchor="middle">40</text>
                <line x1="0" y1="-{$dotScale * 35}" x2="{$xLength}" y2="-{$dotScale * 35}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 35 - 5}" text-anchor="middle">35</text>
                <line x1="0" y1="-{$dotScale * 30}" x2="{$xLength}" y2="-{$dotScale * 30}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 30 - 5}" text-anchor="middle">30</text>
                <line x1="0" y1="-{$dotScale * 25}" x2="{$xLength}" y2="-{$dotScale * 25}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 25 - 5}" text-anchor="middle">25</text>
                <line x1="0" y1="-{$dotScale * 20}" x2="{$xLength}" y2="-{$dotScale * 20}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 20 - 5}" text-anchor="middle">20</text>
                <line x1="0" y1="-{$dotScale * 15}" x2="{$xLength}" y2="-{$dotScale * 15}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 15 - 5}" text-anchor="middle">15</text>
                <line x1="0" y1="-{$dotScale * 10}" x2="{$xLength}" y2="-{$dotScale * 10}" stroke="gray" stroke-width="2" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 10 - 5}" text-anchor="middle">10</text>
                <line x1="0" y1="-{$dotScale * 5}" x2="{$xLength}" y2="-{$dotScale * 5}" stroke="gray" stroke-width="1" stroke-dasharray="10, 5"/>
                <text x="-20" y="-{$dotScale * 5 - 5}" text-anchor="middle">5</text>
                
                <!-- X Axis measurement lines, with text marking axises -->
                
                <text x="{$dotSpace}" y="20" text-anchor="middle">1919</text>
                <line x1="{$dotSpace}" y1="0" x2="{$dotSpace}" y2="-10" stroke="black" stroke-width="1"/>
                <line x1="{$dotSpace * 2}" y1="0" x2="{$dotSpace * 2}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                <line x1="{$dotSpace * 3}" y1="0" x2="{$dotSpace * 3}" y2="-10" stroke="black" stroke-width="1"/>
                <text x="{$dotSpace * 3}" y="20" text-anchor="middle">1920</text>
                <line x1="{$dotSpace * 4}" y1="0" x2="{$dotSpace * 4}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                <line x1="{$dotSpace * 5}" y1="0" x2="{$dotSpace * 5}" y2="-10" stroke="black" stroke-width="1"/>
                <text x="{$dotSpace * 5}" y="20" text-anchor="middle">1921</text>
                <line x1="{$dotSpace * 6}" y1="0" x2="{$dotSpace * 6}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                <line x1="{$dotSpace * 7}" y1="0" x2="{$dotSpace * 7}" y2="-10" stroke="black" stroke-width="1"/>
                <text x="{$dotSpace * 7}" y="20" text-anchor="middle">1922</text>
                <line x1="{$dotSpace * 8}" y1="0" x2="{$dotSpace * 8}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                <line x1="{$dotSpace * 9}" y1="0" x2="{$dotSpace * 9}" y2="-10" stroke="black" stroke-width="1"/>
                <text x="{$dotSpace * 9}" y="20" text-anchor="middle">1923</text>
                <line x1="{$dotSpace * 10}" y1="0" x2="{$dotSpace * 10}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                <line x1="{$dotSpace * 11}" y1="0" x2="{$dotSpace * 11}" y2="-10" stroke="black" stroke-width="1"/>
                <text x="{$dotSpace * 11}" y="20" text-anchor="middle">1924</text>
                <line x1="{$dotSpace * 12}" y1="0" x2="{$dotSpace * 12}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                <line x1="{$dotSpace * 13}" y1="0" x2="{$dotSpace * 13}" y2="-10" stroke="black" stroke-width="1"/>
                <text x="{$dotSpace * 13}" y="20" text-anchor="middle">1925</text>
                <line x1="{$dotSpace * 14}" y1="0" x2="{$dotSpace * 14}" y2="-{$yLength}" stroke="black" stroke-width="1"/>
                
                <!-- Y Axis measurement lines, with text marking axises -->
                <xsl:for-each select="$minuteColl//TEI/ancestor::teiCorpus">
                    <xsl:variable name="dateNum" select="descendant::TEI[1]/descendant::date/@when/number(tokenize(., '\-')[1])"/>
                    <xsl:variable name="preJulyAccepted" select="count(descendant::TEI/descendant::date[@when/number(tokenize(., '\-')[2]) le 6]/ancestor::TEI//list[@type='applicants']/descendant::item[not(persName[@role='rejected'])])"/>
                    <xsl:variable name="postJulyAccepted" select="count(descendant::TEI/descendant::date[@when/number(tokenize(., '\-')[2]) ge 7]/ancestor::TEI//list[@type='applicants']/descendant::item[not(persName[@role='rejected'])])"/>
                    <xsl:variable name="preJulyCancellati" select="count(descendant::TEI/descendant::date[@when/number(tokenize(., '\-')[2]) le 6]/ancestor::TEI//list[@type='cancellati']/descendant::item)"/>
                    <xsl:variable name="postJulyCancellati" select="count(descendant::TEI/descendant::date[@when/number(tokenize(., '\-')[2]) ge 7]/ancestor::TEI//list[@type='cancellati']/descendant::item)"/>
                    <circle cx="{(($dateNum - 1919) * 2 + 1) * $dotSpace}" cy="-{$preJulyAccepted * $dotScale}" r="6" style="fill:blue"/>
                    <circle cx="{(($dateNum - 1919) * 2 + 2) * $dotSpace}" cy="-{$postJulyAccepted * $dotScale}" r="6" style="fill:blue"/>
                    <circle cx="{(($dateNum - 1919) * 2 + 1) * $dotSpace}" cy="-{$preJulyCancellati * $dotScale}" r="6" style="fill:red"/>
                    <circle cx="{(($dateNum - 1919) * 2 + 2) * $dotSpace}" cy="-{$postJulyCancellati * $dotScale}" r="6" style="fill:red"/>
                </xsl:for-each>
            </g>
        </svg>

    </xsl:template>
</xsl:stylesheet>