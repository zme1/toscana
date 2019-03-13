<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="dotInterval" as="xs:integer" select="90"/>
    <xsl:variable name="xLength" select="$dotInterval * 12 + 20"/>
    <xsl:variable name="yScale" select="1"/>
    <xsl:variable name="maxComp"
        select="max(/teiCorpus/teiCorpus/sum(descendant::seg[@subtype = 'sick']/num/@value/number()))"/>
    <xsl:variable name="yLength" select="$maxComp * $yScale + 30"/>
    <xsl:variable name="dollarScale" select="$maxComp div 42"/>
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
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1450 520">
                    <g transform="translate(150,490)">
                        <xsl:apply-templates select="teiCorpus/teiCorpus"/>
                        <text x="0" y="-{$yLength + 20}" text-anchor="start" fill="white"
                            font-size="30px" text-decoration="underline">Figure 2</text>
                        <!-- Main axis lines -->
                        <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="white" stroke-width="1"/>
                        <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="white" stroke-width="1"/>

                        <!-- Text at each month on the X axis -->
                        <text x="{$dotInterval}" y="25" text-anchor="middle" style="fill: white;"
                            >January</text>
                        <text x="{$dotInterval * 2}" y="25" text-anchor="middle"
                            style="fill: white;">February</text>
                        <text x="{$dotInterval * 3}" y="25" text-anchor="middle"
                            style="fill: white;">March</text>
                        <text x="{$dotInterval * 4}" y="25" text-anchor="middle"
                            style="fill: white;">April</text>
                        <text x="{$dotInterval * 5}" y="25" text-anchor="middle"
                            style="fill: white;">May</text>
                        <text x="{$dotInterval * 6}" y="25" text-anchor="middle"
                            style="fill: white;">June</text>
                        <text x="{$dotInterval * 7}" y="25" text-anchor="middle"
                            style="fill: white;">July</text>
                        <text x="{$dotInterval * 8}" y="25" text-anchor="middle"
                            style="fill: white;">August</text>
                        <text x="{$dotInterval * 9}" y="25" text-anchor="middle"
                            style="fill: white;">September</text>
                        <text x="{$dotInterval * 10}" y="25" text-anchor="middle"
                            style="fill: white;">October</text>
                        <text x="{$dotInterval * 11}" y="25" text-anchor="middle"
                            style="fill: white;">November</text>
                        <text x="{$dotInterval * 12}" y="25" text-anchor="middle"
                            style="fill: white;">December</text>

                        <!-- Text and dashed lines in intervals of $40 on the y axis -->
                        <line x1="0" y1="-{$dollarScale * 4}" x2="{$xLength}"
                            y2="-{$dollarScale * 4}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 4 - 5}" text-anchor="middle"
                            style="fill: white;">$40</text>
                        <line x1="0" y1="-{$dollarScale * 8}" x2="{$xLength}"
                            y2="-{$dollarScale * 8}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 8 - 5}" text-anchor="middle"
                            style="fill: white;">$80</text>
                        <line x1="0" y1="-{$dollarScale * 12}" x2="{$xLength}"
                            y2="-{$dollarScale * 12}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 12 - 5}" text-anchor="middle"
                            style="fill: white;">$120</text>
                        <line x1="0" y1="-{$dollarScale * 16}" x2="{$xLength}"
                            y2="-{$dollarScale * 16}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 16 - 5}" text-anchor="middle"
                            style="fill: white;">$160</text>
                        <line x1="0" y1="-{$dollarScale * 20}" x2="{$xLength}"
                            y2="-{$dollarScale * 20}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 20 - 5}" text-anchor="middle"
                            style="fill: white;">$200</text>
                        <line x1="0" y1="-{$dollarScale * 24}" x2="{$xLength}"
                            y2="-{$dollarScale * 24}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 24 - 5}" text-anchor="middle"
                            style="fill: white;">$240</text>
                        <line x1="0" y1="-{$dollarScale * 28}" x2="{$xLength}"
                            y2="-{$dollarScale * 28}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 28 - 5}" text-anchor="middle"
                            style="fill: white;">$280</text>
                        <line x1="0" y1="-{$dollarScale * 32}" x2="{$xLength}"
                            y2="-{$dollarScale * 32}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 32 - 5}" text-anchor="middle"
                            style="fill: white;">$320</text>
                        <line x1="0" y1="-{$dollarScale * 36}" x2="{$xLength}"
                            y2="-{$dollarScale * 36}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 36 - 5}" text-anchor="middle"
                            style="fill: white;">$360</text>
                        <line x1="0" y1="-{$dollarScale * 40}" x2="{$xLength}"
                            y2="-{$dollarScale * 40}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 40 - 5}" text-anchor="middle"
                            style="fill: white;">$400</text>
                        <line x1="0" y1="-{$dollarScale * 44}" x2="{$xLength}"
                            y2="-{$dollarScale * 44}" stroke="white" stroke-width=".5"
                            stroke-dasharray="5,10"/>
                        <text x="-45" y="-{$dollarScale * 44 - 5}" text-anchor="middle"
                            style="fill: white;">$440</text>
                    </g>
                </svg>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="year" select="TEI[1]/teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
        <g class="lineToggle">
            <line class="line{$year}" x1="0" y1="0" x2="{$dotInterval}"
                y2="-{TEI[1]/sum(descendant::seg[@subtype = 'sick']/num/@value)}"/>
            <text x="{$xLength + 5}"
                y="-{sum(descendant::seg[@subtype='sick']/num/@value/number())}"
                text-anchor="middle" style="fill: white;">
                <xsl:value-of select="$year"/>
            </text>
            <xsl:apply-templates select="TEI"/>
        </g>
    </xsl:template>
    <xsl:template match="TEI" xmlns="http://www.w3.org/2000/svg">
        <xsl:variable name="year" select="teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="compValue" select="sum(descendant::seg[@subtype = 'sick']/num/@value)"/>
        <xsl:variable name="runningTotal"
            select="sum(preceding-sibling::TEI/sum(descendant::seg[@subtype = 'sick']/num/@value))"/>
        <xsl:variable name="xPos"
            select="(teiHeader/descendant::publicationStmt/date/number(tokenize(@when, '-')[2])) * $dotInterval"/>
        <xsl:variable name="yPos" select="($runningTotal + $compValue) * $yScale"/>
        <circle class="line{$year}" cx="{$xPos}" cy="-{$yPos}" r="4"/>
        <xsl:if test="following-sibling::TEI[not(teiHeader/descendant::publicationStmt/date[@when = '1920-12-30'])]">
            <line class="line{$year}" x1="{$xPos}" y1="-{$yPos}"
                x2="{following-sibling::TEI[1]/(teiHeader/descendant::publicationStmt/date/number(tokenize(@when, '-')[2])) * $dotInterval}"
                y2="-{($runningTotal + $compValue + following-sibling::TEI[1]/sum(descendant::seg[@subtype='sick']/num/@value)) * $yScale}"/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
