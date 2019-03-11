<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <xsl:variable name="root" select="/"/>
    <xsl:variable name="lemmas" as="node()+" select="//w[not(ancestor::foreign)]/@lemma"/>
    <xsl:variable name="distinctLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
    <xsl:variable name="graphLemmas" as="xs:string+">
        <xsl:for-each select="$distinctLemmas">
            <xsl:sort
                select="count($root/descendant::w[not(ancestor::foreign) and @lemma = current()])"
                order="descending"/>
            <xsl:if
                test="count($root/descendant::w[not(ancestor::foreign) and @lemma = current()]) ge 1">
                <xsl:value-of select="current()"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>


    <xsl:variable name="xLength" as="xs:integer" select="350"/>
    <xsl:variable name="yLength" as="xs:integer" select="450"/>
    <xsl:variable name="xScale" as="xs:double" select="$xLength div 17"/>

    <xsl:variable name="lineWidth" as="xs:integer" select="7"/>
    <xsl:variable name="lineInterval" as="xs:double"
        select="($yLength - (count($graphLemmas) * $lineWidth)) div count($graphLemmas)"/>
    <xsl:variable name="lineTotal" as="xs:double" select="$lineWidth + $lineInterval"/>

    <xsl:template match="/">
        <div class="lemma-flex">
            <div class="lemma-bar">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 520">
                    <g transform="translate(125, 490)">
                        <text x="0" y="-{$yLength + 20}" text-anchor="start" fill="white" font-size="30px" text-decoration="underline">Figure 5</text>
                        <xsl:for-each select="$graphLemmas">
                            <xsl:variable name="position" select="position()"/>
                            <xsl:variable name="currentLemma" select="current()"/>
                            <xsl:variable name="lemmaCount" as="xs:integer"
                                select="count($root/descendant::w[not(ancestor::foreign) and @lemma = $currentLemma])"/>
                            <line x1="0" y1="-{$position * $lineTotal - 7.5}"
                                x2="{$xScale * $lemmaCount}" y2="-{$position * $lineTotal - 7.5}"
                                stroke="#3E6E63" stroke-width="{$lineWidth}"/>
                            <text x="{$xScale * $lemmaCount + 10}"
                                y="-{$position * $lineTotal - 10}" text-anchor="start" fill="white">
                                <xsl:value-of select="$lemmaCount"/>
                            </text>
                            <text x="-10" y="-{$position * $lineTotal - 10}" text-anchor="end"
                                fill="white">
                                <xsl:value-of select="current()"/>
                            </text>
                        </xsl:for-each>
                        <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="white"/>
                        <line x1="0" y1="0" x2="0" y2="-{$yLength}" stroke="white"/>
                    </g>
                </svg>
            </div>
            <div class="lemma-text">
                <p>One final analysis of the perceived proficiency of the transcribers' use of
                    English beyond the scope of orthography or grammaticality resides in the number
                    of distinct <em>lemmas</em> (i.e. root word forms) used each each individual
                    year. To the left, the table lists all of the lemmas used that were used more
                    than one time in that year and the number of times each appeared. Additionally,
                    there is a separate tally of all words that were found only once in a given
                    year. Before any of the individual years are listed, a separate list tabulates
                    holistic figures for the entire corpus, which effectively illustrates the
                    restricted vocabulary throughout the years. Namely, the most commonly used words
                    are chairman, ticket, manager, and committee, all of which clearly relate to
                    event-based discussions. The inventory of words used in a single year is
                    similarly restricted among all the transcribers, none of whom showed a tendency
                    to experiment with many new word forms. Rather, aside from using the same
                    cluster of lemmas, other words were used in isolation, not to be written
                    again.</p>
                <p><em>Productivity</em> (i.e. the use of one single word in multiple contexts) is a
                    key indicator of effective apprenticeship of a language; the reuse of a small
                    collection of terms and the isolated use of other words without employing them
                    again are both indicators that these men were likely not actively exercising
                    knowledge of English. Rather, it seems as though the entire Tuscan League may
                    have regularly employed that subset of words reflexively, without a conscious
                    intent to actively incorporate more English into their vocabulary. These are
                    indicators that English was viewed in a prestigious light among the members of
                    the Tuscan League, and that the language's prestige value led them to
                    incorporate it into their writing, rather than their functional knowledge of the
                    language itself.</p>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
