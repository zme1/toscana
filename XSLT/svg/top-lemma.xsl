<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tos="http://toscana.newtfire.org"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:template match="/">
        <div class="lemma-table">
            <table>
                <tr>
                    <th>Year</th>
                    <th>Top Lemmas</th>
                </tr>
                <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
            </table>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <xsl:variable name="year" as="xs:string" select="teiHeader/fileDesc/descendant::date/@when"/>
        <xsl:variable name="currentYear" select="current()"/>
        <xsl:variable name="lemmas" as="node()+"
            select="descendant::w[not(ancestor::foreign)]/@lemma"/>
        <xsl:variable name="distLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
        <xsl:variable name="multiLemmas" as="xs:string*">
            <xsl:for-each select="$distLemmas">
                <xsl:if
                    test="count($currentYear//w[not(ancestor::foreign) and @lemma eq current()]) gt 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="singleLemmas" as="xs:string*">
            <xsl:for-each select="$distLemmas">
                <xsl:if
                    test="count($currentYear//w[not(ancestor::foreign) and @lemma eq current()]) eq 1"/>
                <xsl:value-of select="current()"/>
            </xsl:for-each>
        </xsl:variable>
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
</xsl:stylesheet>
