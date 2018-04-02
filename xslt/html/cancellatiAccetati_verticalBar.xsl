<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="yHeight" as="xs:integer" select="350"/>
    <xsl:variable name="barHeight" as="xs:integer" select="40"/>
    <xsl:variable name="barInterval" as="xs:integer" select="5"/>
    <xsl:variable name="xLength" as="xs:integer" select="750"/>
    <xsl:variable name="xScale"
        select="($xLength div 2) div (max(/teiCorpus/teiCorpus/count(descendant::list[@type = 'applicants']//item[not(persName[@role = 'rejected'])])) + 5)"/>
    <xsl:variable name="yrHeight" select="$barHeight + ($barInterval * 2)"/>
    <xsl:template match="/">
                <h3>Cancellati and Accetati in the Lega Through the Years</h3>
        <hr class="min"/>
                <div class="cancellatiContainer">
                    <div class="cancellatiSvg">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 850 430">
                            <g transform="translate(400,400)">
                                <xsl:apply-templates select="/teiCorpus/teiCorpus" mode="svg"/>
                                <!-- Left vertical line -->
                                <line x1="-{$xLength div 2}" y1="-{$yHeight}" x2="-{$xLength div 2}"
                                    y2="0" stroke="white" stroke-width="1"/>
                                <!-- Center vertical line -->
                                <line x1="0" y1="0" x2="0" y2="-{$yHeight}" stroke="white"
                                    stroke-width="1"/>
                                <!-- Right vertical line -->
                                <line x1="{$xLength div 2}" y1="-{$yHeight}" x2="{$xLength div 2}"
                                    y2="0" stroke="white" stroke-width="1"/>
                                <!-- Bottom horizonal line -->
                                <line x1="-{$xLength div 2}" y1="0" x2="{$xLength div 2}" y2="0"
                                    stroke="white" stroke-width="1"/>
                                <!-- Top horizontal line -->
                                <line x1="-{$xLength div 2}" y1="-{$yHeight}" x2="{$xLength div 2}"
                                    y2="-{$yHeight}" stroke="white" stroke-width="1"/>
                                <!-- <line x1="{$xScale *5}" y1="-{$yHeight}" x2="{$xScale * 5}" y2="0" stroke="black" stroke-width="0.25" stroke-dasharray="10, 5"/>
                        <line x1="{$xScale *15}" y1="-{$yHeight}" x2="{$xScale * 15}" y2="0" stroke="black" stroke-width="0.25" stroke-dasharray="10, 5"/>
                        <line x1="{$xScale *25}" y1="-{$yHeight}" x2="{$xScale * 25}" y2="0" stroke="black" stroke-width="0.25" stroke-dasharray="10, 5"/>
                        <line x1="{$xScale *35}" y1="-{$yHeight}" x2="{$xScale * 35}" y2="0" stroke="black" stroke-width="0.25" stroke-dasharray="10, 5"/>
                        <line x1="{$xScale *45}" y1="-{$yHeight}" x2="{$xScale * 45}" y2="0" stroke="black" stroke-width="0.25" stroke-dasharray="10, 5"/>
                        <line x1="{$xScale *55}" y1="-{$yHeight}" x2="{$xScale * 55}" y2="0" stroke="black" stroke-width="0.25" stroke-dasharray="10, 5"/> -->

                                <!-- Positive dashed y-axis lines, intervals of 10 -->
                                <line x1="{$xScale *10}" y1="-{$yHeight}" x2="{$xScale * 10}" y2="0"
                                    stroke="white" stroke-width="0.5" stroke-dasharray="10, 5"/>
                                <text x="{$xScale *10}" y="20" text-anchor="middle" style="fill: white;">10</text>
                                <line x1="{$xScale *20}" y1="-{$yHeight}" x2="{$xScale * 20}" y2="0"
                                    stroke="white" stroke-width="0.5" stroke-dasharray="10, 5"/>
                                <text x="{$xScale *20}" y="20" text-anchor="middle" style="fill: white;">20</text>
                                <line x1="{$xScale *30}" y1="-{$yHeight}" x2="{$xScale * 30}" y2="0"
                                    stroke="white" stroke-width="0.5" stroke-dasharray="10, 5"/>
                                <text x="{$xScale *30}" y="20" text-anchor="middle" style="fill: white;">30</text>
                                <line x1="{$xScale *40}" y1="-{$yHeight}" x2="{$xScale * 40}" y2="0"
                                    stroke="white" stroke-width="0.5" stroke-dasharray="10, 5"/>
                                <text x="{$xScale *40}" y="20" text-anchor="middle" style="fill: white;">40</text>
                                <line x1="{$xScale *50}" y1="-{$yHeight}" x2="{$xScale * 50}" y2="0"
                                    stroke="white" stroke-width="0.5" stroke-dasharray="10, 5"/>
                                <text x="{$xScale *50}" y="20" text-anchor="middle" style="fill: white;">50</text>
                                <line x1="{$xScale *60}" y1="-{$yHeight}" x2="{$xScale * 60}" y2="0"
                                    stroke="white" stroke-width="0.5" stroke-dasharray="10, 5"/>
                                <text x="{$xScale *60}" y="20" text-anchor="middle" style="fill: white;">60</text>

                                <!-- Negative dashed y-axis lines, intervals of 10 -->
                                <line x1="-{$xScale *10}" y1="-{$yHeight}" x2="-{$xScale * 10}"
                                    y2="0" stroke="white" stroke-width="0.5"
                                    stroke-dasharray="10, 5"/>
                                <text x="-{$xScale *10}" y="20" text-anchor="middle" style="fill: white;">10</text>
                                <line x1="-{$xScale *20}" y1="-{$yHeight}" x2="-{$xScale * 20}"
                                    y2="0" stroke="white" stroke-width="0.5"
                                    stroke-dasharray="10, 5"/>
                                <text x="-{$xScale *20}" y="20" text-anchor="middle" style="fill: white;">20</text>
                                <line x1="-{$xScale *30}" y1="-{$yHeight}" x2="-{$xScale * 30}"
                                    y2="0" stroke="white" stroke-width="0.5"
                                    stroke-dasharray="10, 5"/>
                                <text x="-{$xScale *30}" y="20" text-anchor="middle" style="fill: white;">30</text>
                                <line x1="-{$xScale *40}" y1="-{$yHeight}" x2="-{$xScale * 40}"
                                    y2="0" stroke="white" stroke-width="0.5"
                                    stroke-dasharray="10, 5"/>
                                <text x="-{$xScale *40}" y="20" text-anchor="middle" style="fill: white;">40</text>
                                <line x1="-{$xScale *50}" y1="-{$yHeight}" x2="-{$xScale * 50}"
                                    y2="0" stroke="white" stroke-width="0.5"
                                    stroke-dasharray="10, 5"/>
                                <text x="-{$xScale *50}" y="20" text-anchor="middle" style="fill: white;">50</text>
                                <line x1="-{$xScale *60}" y1="-{$yHeight}" x2="-{$xScale * 60}"
                                    y2="0" stroke="white" stroke-width="0.5"
                                    stroke-dasharray="10, 5"/>
                                <text x="-{$xScale *60}" y="20" text-anchor="middle" style="fill: white;">60</text>
                            </g>
                        </svg>
                    </div>
                    <xsl:apply-templates select="/teiCorpus/teiCorpus" mode="table"/>
                </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" mode="svg" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="date"
            select="teiHeader/fileDesc/publicationStmt/date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="barWidthAcc"
            select="(count(descendant::list[@type = 'applicants']/item[not(persName[@role = 'rejected'])])) * $xScale"/>
        <xsl:variable name="barWidthCan"
            select="(count(descendant::list[@type = 'cancellati']/item)) * $xScale"/>
        <xsl:variable name="yPos"
            select="$yHeight - (((position() - 1) * $yrHeight) + $barInterval)"/>
        <!-- Acettati rectangle -->
        <rect class="toggle" id="accToggle{$date}" x="0" y="-{$yPos}" height="{$barHeight}"
            width="{$barWidthAcc}" fill="#5A837A"/>
        <!-- Cancellati rectangle -->
        <rect class="toggle" id="canToggle{$date}" x="-{$barWidthCan}" y="-{$yPos}"
            height="{$barHeight}" width="{$barWidthCan}" fill="#CE4B29"/>
        <!-- Date for each year -->
        <text class="toggle" id="textToggle{$date}" x="0" y="-{$yPos - $barHeight div 2 - 5}"
            text-anchor="middle" style="fill: white;"><xsl:value-of select="$date"/></text>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" mode="table">
        <xsl:variable name="date"
            select="teiHeader/fileDesc/publicationStmt/date/tokenize(@when, '-')[1]"/>
        <div class="table" id="accettati{$date}">
            <table>
                <tr>
                    <th class="year">Year</th>
                    <th class="in">Incoming Members</th>
                    <th class="out">Outgoing Members</th>
                </tr>
                <tr>
                    <td class="year">
                        <xsl:value-of select="$date"/>
                    </td>
                    <td class="in">
                        <xsl:value-of
                            select="string-join(descendant::list[@type = 'applicants']/item[not(note)]/persName, ', ')"
                        />
                    </td>
                    <td class="out">
                        <xsl:value-of
                            select="string-join(descendant::list[@type = 'cancellati']/item/persName, ', ')"
                        />
                    </td>
                </tr>
            </table>
        </div>
    </xsl:template>
</xsl:stylesheet>
