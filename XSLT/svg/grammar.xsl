<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tos="http://toscana.newtfire.org" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="yLength" as="xs:integer" select="500"/>
    <xsl:variable name="angCount" as="xs:integer" select="count(//w[not(ancestor::foreign)])"/>
    <xsl:variable name="angXValue" as="xs:double" select="6.5789"/>
    <xsl:variable name="xLength" as="xs:double" select="$angCount * $angXValue"/>
    <xsl:template match="/">
        <div class="grammar">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 700">
                <g transform="translate(120,570)">
                    <xsl:apply-templates select="/teiCorpus/teiCorpus"/>

                    <!-- X- and y-axis labels, with legend -->
                    <text x="0" y="-{$yLength + 40}" text-anchor="start" fill="white"
                        font-size="30px" text-decoration="underline">Figure 3</text>
                    <text x="-70" y="-{$yLength div 2}"
                        transform="rotate(270, -70, -{$yLength div 2})" font-size="30px"
                        text-anchor="middle" fill="white">Proportions by year</text>
                    <text x="{$xLength div 2}" y="50" font-size="30px" text-anchor="middle"
                        fill="white">Proportions over the years</text>
                    <rect x="0" y="20" width="25" height="25" fill="#CE4B29" stroke="white"/>
                    <text x="32" y="38" text-anchor="start" fill="white">Ungrammatical use</text>
                    <rect x="0" y="50" width="25" height="25" fill="#3E6E63" stroke="white"/>
                    <text x="32" y="68" text-anchor="start" fill="white">Grammatical use</text>
                    <rect x="0" y="80" width="25" height="25" fill="#BFA179" stroke="white"/>
                    <text x="32" y="98" text-anchor="start" fill="white">Appears outside sentential
                        context (does not apply)</text>

                    <!-- Graph borders -->
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="white" stroke-width="1"/>
                    <line x1="0" y1="-{$yLength}" x2="{$xLength}" y2="-{$yLength}" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength}" y1="0" x2="{$xLength}" y2="-{$yLength}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="white" stroke-width="1"/>

                    <!-- X-axis milestones -->
                    <line x1="{$xLength * .1}" y1="0" x2="{$xLength * .1}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .2}" y1="0" x2="{$xLength * .2}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .3}" y1="0" x2="{$xLength * .3}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .4}" y1="0" x2="{$xLength * .4}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .5}" y1="0" x2="{$xLength * .5}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .6}" y1="0" x2="{$xLength * .6}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .7}" y1="0" x2="{$xLength * .7}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .8}" y1="0" x2="{$xLength * .8}" y2="-10" stroke="white"
                        stroke-width="1"/>
                    <line x1="{$xLength * .9}" y1="0" x2="{$xLength * .9}" y2="-10" stroke="white"
                        stroke-width="1"/>

                    <text x="{$xLength * .2 + 8}" y="20" text-anchor="middle" fill="white"
                        >20%</text>
                    <text x="{$xLength * .4 + 8}" y="20" text-anchor="middle" fill="white"
                        >40%</text>
                    <text x="{$xLength * .6 + 8}" y="20" text-anchor="middle" fill="white"
                        >60%</text>
                    <text x="{$xLength * .8 + 8}" y="20" text-anchor="middle" fill="white"
                        >80%</text>

                    <!-- Y-axis milestones -->
                    <line x1="0" y1="-{$yLength * .1}" x2="10" y2="-{$yLength * .1}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .2}" x2="10" y2="-{$yLength * .2}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .3}" x2="10" y2="-{$yLength * .3}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .4}" x2="10" y2="-{$yLength * .4}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .5}" x2="10" y2="-{$yLength * .5}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .6}" x2="10" y2="-{$yLength * .6}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .7}" x2="10" y2="-{$yLength * .7}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .8}" x2="10" y2="-{$yLength * .8}" stroke="white"
                        stroke-width="1"/>
                    <line x1="0" y1="-{$yLength * .9}" x2="10" y2="-{$yLength * .9}" stroke="white"
                        stroke-width="1"/>

                    <text x="-10" y="-{$yLength * .2 - 8}" text-anchor="end" fill="white">20%</text>
                    <text x="-10" y="-{$yLength * .4 - 8}" text-anchor="end" fill="white">40%</text>
                    <text x="-10" y="-{$yLength * .6 - 8}" text-anchor="end" fill="white">60%</text>
                    <text x="-10" y="-{$yLength * .8 - 8}" text-anchor="end" fill="white">80%</text>
                </g>
            </svg>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="year" select="teiHeader/fileDesc//date/@when"/>
        <xsl:variable name="totalCount" as="xs:integer"
            select="count(descendant::w[not(ancestor::foreign)])"/>
        <xsl:variable name="angYValue" as="xs:double" select="$yLength div $totalCount"/>
        <xsl:variable name="grammaticalCount" as="xs:integer"
            select="count(descendant::w[not(ancestor::foreign) and @tos:accordo = 'y'])"/>
        <xsl:variable name="ungrammaticalCount" as="xs:integer"
            select="count(descendant::w[not(ancestor::foreign) and @tos:accordo = 'n'])"/>
        <xsl:variable name="naCount" as="xs:integer"
            select="count(descendant::w[not(ancestor::foreign) and @tos:accordo = 'na'])"/>
        <xsl:variable name="precedingCount" as="xs:integer"
            select="count(preceding-sibling::teiCorpus/descendant::w[not(ancestor::foreign)])"/>
        <rect x="{$precedingCount * $angXValue}" y="-{$naCount * $angYValue}"
            height="{$naCount * $angYValue}" width="{$totalCount * $angXValue}" fill="#BFA179"
            stroke="white"/>
        <rect x="{$precedingCount * $angXValue}" y="-{($grammaticalCount + $naCount) * $angYValue}"
            height="{$grammaticalCount * $angYValue}" width="{$totalCount * $angXValue}"
            fill="#3E6E63" stroke="white"/>
        <rect x="{$precedingCount * $angXValue}"
            y="-{($grammaticalCount + $ungrammaticalCount + $naCount) * $angYValue}"
            height="{$ungrammaticalCount * $angYValue}" width="{$totalCount * $angXValue}"
            fill="#CE4B29" stroke="white"/>
        <text x="{($precedingCount * $angXValue) + (($totalCount * $angXValue) div 2)}"
            y="-{$yLength + 10}" text-anchor="middle" fill="white">
            <xsl:value-of select="$year"/>
        </text>
    </xsl:template>
</xsl:stylesheet>
