<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="../../css/lega.css"/>
                <link rel="stylesheet" type="text/css" href="../../css/minutes.css"/>
                <title>Minutes: <xsl:value-of
                        select="/teiCorpus/teiCorpus[7]/teiHeader/descendant::publicationStmt/date/@when"
                    /></title>
            </head>
            <body>
                <xsl:comment>#include virtual="../ssi/ssi_minutes_menu.html" </xsl:comment>
                <h3>Minute logs from <xsl:value-of
                        select="/teiCorpus/teiCorpus[7]/teiHeader/descendant::publicationStmt/date/@when"
                    />.</h3>
                <hr class="min"/>
                <xsl:apply-templates select="/teiCorpus/teiCorpus[7]"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus[7]">
        <xsl:apply-templates select="TEI"/>
    </xsl:template>
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    <xsl:template match="TEI">
        <xsl:variable name="date" as="xs:string" select="descendant::publicationStmt/date/@when"/>
        <xsl:variable name="transcription" select="descendant::div[@type = 'transcription']"/>
        <xsl:variable name="translation" select="descendant::div[@type = 'translation']"/>
        <section id="meeting_{$date}">
            <div class="manuscript">
                <xsl:apply-templates select="descendant::pb" mode="img"/>
            </div>
            <div class="transcription">
                <span class="mainTitle">
                    <xsl:apply-templates select="descendant::title[@type = 'main']"/>
                </span>
                <span class="subTitle">
                    <xsl:apply-templates select="descendant::title[@type = 'sub']"/>
                </span>
                <xsl:apply-templates select="$transcription"/>
            </div>
            <div class="translation">
                <span class="mainTitle">
                    <xsl:apply-templates select="descendant::title[@type = 'main']"/>
                </span>
                <span class="subTitle">
                    <xsl:apply-templates select="descendant::title[@type = 'sub']"/>
                </span>
                <xsl:apply-templates select="$translation"/>
            </div>
        </section>
        <hr class="maj"/>
    </xsl:template>
    <xsl:template match="pb[ancestor::div[@type = 'transcription']]" mode="img">
        <xsl:variable name="year" as="xs:string"
            select="ancestor::teiCorpus[not(teiCorpus)]/teiHeader/descendant::publicationStmt/date/@when"/>
        <xsl:variable name="meetingDate" as="xs:string"
            select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/@when"/>
        <a target="_blank" href="../../img/meetingMinutes/{$year}/{$meetingDate}/{@n}.png">
            <img class="manuscript" src="../../img/meetingMinutes/{$year}/{$meetingDate}/{@n}.png"
                alt="Manuscript scan."/>
        </a>
    </xsl:template>
    <xsl:template match="pb">
        <xsl:if test="preceding-sibling::*">
            <p class="pb">
                <em>[ Page break ]</em>
            </p>
        </xsl:if>
    </xsl:template>
    <xsl:template match="note[@resp]">
        <span class="note">
            <xsl:text> [ </xsl:text>
            <xsl:apply-templates/>
            <xsl:text> ] </xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="signed">
        <xsl:apply-templates/><span class="sig"> [ firmato ]</span>
    </xsl:template>
    <xsl:template match="(persName | rs)">
        <span class="{@ref}"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="del">
        <span class="del"><xsl:apply-templates/></span>
    </xsl:template>
</xsl:stylesheet>
