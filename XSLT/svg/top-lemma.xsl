<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:template match="/">
        <div class="lemma-table">
            <table>
                <tbody class="lemma-table">
                    <tr>
                        <th>Year</th>
                        <th>Top Lemmas</th>
                    </tr>
                    <xsl:apply-templates select="/teiCorpus[teiCorpus]"/>
                    <xsl:apply-templates select="/teiCorpus[TEI]"/>
                </tbody>
            </table>
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
    <xsl:template match="teiCorpus/teiCorpus">
        <xsl:variable name="year" as="xs:string" select="teiHeader/fileDesc/descendant::date/@when"/>
        <xsl:variable name="currentYear" select="current()"/>
        <xsl:variable name="lemmas" as="node()+"
            select="descendant::w[not(ancestor::foreign)]/@lemma"/>
        <xsl:variable name="distinctLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
        <xsl:variable name="multiLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($currentYear//w[not(ancestor::foreign) and @lemma eq current()]) gt 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="singleLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($currentYear//w[not(ancestor::foreign) and @lemma eq current()]) eq 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:comment> All lemmas: <xsl:value-of select="$distinctLemmas"/></xsl:comment>
        <xsl:comment> Multi lemmas: <xsl:value-of select="$multiLemmas"/></xsl:comment>
        <xsl:comment> Single lemmas: <xsl:value-of select="$singleLemmas"/></xsl:comment>
        <tr>
            <td>
                <xsl:value-of select="$year"/>
            </td>
            <td>
                <ul>
                    <xsl:for-each select="$multiLemmas">
                        <xsl:variable name="currentLemma" select="current()"/>
                        <xsl:variable name="lemmaMatch"
                            select="$currentYear/descendant::w[@lemma eq $currentLemma]"/>
                        <xsl:variable name="matchCount" select="count($lemmaMatch)"/>
                        <xsl:if test="$matchCount gt 1">
                            <li>
                                <xsl:value-of select="concat($currentLemma, ': ', $matchCount)"/>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                    <li>
                        <xsl:value-of
                            select="concat('Number of words used once: ', count($singleLemmas))"/>
                    </li>
                </ul>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="teiCorpus[teiCorpus]">
        <xsl:variable name="corpus" select="current()"/>
        <xsl:variable name="lemmas" as="node()+"
            select="descendant::w[not(ancestor::foreign)]/@lemma"/>
        <xsl:variable name="distinctLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
        <xsl:variable name="multiLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($corpus//w[not(ancestor::foreign) and @lemma eq current()]) gt 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="singleLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($corpus//w[not(ancestor::foreign) and @lemma eq current()]) eq 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <tr>
            <td>All years</td>
            <td>
                <ul>
                    <xsl:for-each select="$multiLemmas">
                        <xsl:variable name="currentLemma" select="current()"/>
                        <xsl:variable name="lemmaMatch"
                            select="$corpus/descendant::w[@lemma eq $currentLemma]"/>
                        <xsl:variable name="matchCount" select="count($lemmaMatch)"/>
                        <xsl:if test="$matchCount gt 1">
                            <li>
                                <xsl:value-of select="concat($currentLemma, ': ', $matchCount)"/>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                    <li>
                        <xsl:value-of
                            select="concat('Number of words used once: ', count($singleLemmas))"/>
                    </li>
                </ul>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
