<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/html"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="../../css.lega.css"/>
                <title/>
            </head>
            <body>
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
        <section class="meeting_{$date}">
            <xsl:apply-templates select="descendant::pb" mode="img"/>
            <span class="mainTitle">
                <xsl:apply-templates select="descendant::title[@type = 'main']"/>
            </span>
            <span class="subTitle">
                <xsl:apply-templates select="descendant::title[@type = 'sub']"/>
            </span>
            <xsl:apply-templates select="text"/>
        </section>
    </xsl:template>
    <xsl:template match="pb" mode="img">
        <xsl:variable name="year" as="xs:string" select="ancestor::teiCorpus[not(teiCorpus)]/teiHeader/descendant::publicationStmt/date/@when"/>
        <xsl:variable name="meetingDate" as="xs:string" select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/@when"/>
        <img src="../../img/meetingMinutes/{$year}/{$meetingDate}/{@n}.png">Manuscript page number <xsl:value-of select="@n"/>.</img>
    </xsl:template>
    <xsl:template match="pb">
        <hr class="min"/>
    </xsl:template>
    <xsl:template match="note[@resp]">
        
    </xsl:template>
</xsl:stylesheet>
