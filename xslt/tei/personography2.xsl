<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="distinctPers" select="distinct-values(//TEI//persName)"/>
    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Lega Toscana di Protezione XSLT Generated Personography File -
                            2</title>
                        <author>Zachary Enick</author>
                    </titleStmt>
                    <publicationStmt>
                        <authority>Prepared in TEI 5 by Zachary Enick for the Italian research
                            assistantship at the University of Pittsburgh. Github repository: <ref
                                target="http://github.com/zme1/toscana"/>. Date last worked on:
                                <date when="2018-03-0"/></authority>
                        <availability>
                            <licence><!-- licence to go here --></licence>
                        </availability>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Born digital.</p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <listPerson>
                        <xsl:apply-templates select="//persName"/>
                    </listPerson>
                </body>
            </text>
        </TEI>
    </xsl:template>
    <xsl:template match="TEI//persName">
        <xsl:variable name="distinctId" select="@ref"/>
        <xsl:variable name="distinctIdNoHash" select="$distinctId/tokenize(string(), '#')"/>
        <person xml:id="{$distinctIdNoHash}">
            <persName>
                <surname/>
                <forename/>
                <roleName>
                    <xsl:apply-templates
                        select="//teiCorpus//profileDesc/particDesc//person[persName[@ref = current()/@ref]]"/>
                    <xsl:apply-templates
                        select="//roleName[@type = 'committee'][preceding-sibling::persName[@ref = current()/@ref] or following-sibling::persName[@ref = current()/@ref]]">
                    </xsl:apply-templates>
                </roleName>
            </persName>
        </person>
    </xsl:template>
    <xsl:template match="roleName[@type = 'committee']">
        <xsl:variable name="startYr"
            select="ancestor::text/preceding-sibling::teiHeader//date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="startMo"
            select="ancestor::text/preceding-sibling::teiHeader//date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($startYr, $startMo), '-')"/>
        <xsl:variable name="endDate" select="ancestor::list/date/@when"/>

        <roleName type="{current()/@type}" subtype="{ancestor::list/@subtype}"
            role="{current()/@role}">
            <date from="{$yrmo}" to="{$endDate}"/>
        </roleName>
    </xsl:template>
    <xsl:template match="teiCorpus//profileDesc/particDesc//person">
        <xsl:variable name="yr"
            select="ancestor::profileDesc/preceding-sibling::fileDesc//date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo"
            select="ancestor::profileDesc/preceding-sibling::fileDesc//date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:choose>
            <xsl:when test="persName[@role = 'scaduto']">
                <roleName type="officer" role="{roleName/@role} scaduto">
                    <date from="{$yr}-01" to="{ancestor::teiCorpus[not(descendant::teiCorpus)]//*[@ref=current()/@ref][@role='scaduto']/ancestor::text/preceding-sibling::teiHeader//date/@when}"/>
                </roleName>
            </xsl:when>
            <xsl:when test="persName[@role = 'replacement']">
                <roleName type="officer" role="{roleName/@role} replacement">
                    <date when="{$yr}"/>
                </roleName>
            </xsl:when>
            <xsl:otherwise>
                <roleName type="officer" role="{roleName/@role}">
                    <date when="{$yr}"/>
                </roleName>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
