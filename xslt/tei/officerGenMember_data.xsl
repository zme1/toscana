<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <years>
            <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
        </years>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <year when="{teiHeader/descendant::publicationStmt/date/@when}">
            <xsl:apply-templates select="descendant::seg"/>
            <xsl:apply-templates select="descendant::list[@type='committee']"/>
        </year>
    </xsl:template>
    <xsl:template match="seg[@type = 'proposal']">
        <xsl:variable name="yr" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:choose>
            <xsl:when test="count(descendant::*[@role = 'supporter'][not(@ref='#legaT')]) gt 1">
                <act type="proposal" ref="{descendant::*[@role='supporter'][1]/@ref}">
                    <date when="{$yrmo}"/>
                </act>
                <act type="proposal" ref="{descendant::*[@role='supporter'][2]/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:when>
            <xsl:otherwise>
                <act type="proposal" ref="{descendant::*[@role='proposer']/@ref}">
                    <date when="{$yrmo}"/>
                </act>
                <act type="proposal" ref="{descendant::*[@role='supporter']/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="seg[@type='proposalWritten']">
        <xsl:for-each select="*[@role='proposer']">
            <xsl:variable name="yr" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[1]"/>
            <xsl:variable name="mo" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[2]"/>
            <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
            <act type="proposal" ref="{@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="seg[@type='proposalReject']">
        <xsl:for-each select="*[@role]">
            <xsl:variable name="yr" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[1]"/>
            <xsl:variable name="mo" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[2]"/>
            <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
            <act type="proposal" ref="{@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="seg[@type='comp']">
        <xsl:variable name="yr" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:for-each select=".[@subtype='sick']">
            <act type="comp" ref="{*[@role='target']/@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
        <xsl:for-each select=".[@subtype='donation']">
            <act type="donation" ref="{*[@role='source']/@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="list[@type='committee']">
        <xsl:variable name="yr" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo" select="ancestor::text/preceding-sibling::teiHeader/descendant::date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:choose>
            <xsl:when test="@subtype='regolamento'">
                <xsl:for-each select="descendant::item">
                    <act type="committee" ref="{persName/@ref}">
                        <date when="{$yrmo}"/>
                    </act>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@subtype='investigazione'">
                <xsl:for-each select="item">
                    <act type="committee" ref="{persName/@ref}">
                        <date when="{$yrmo}"/>
                    </act>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@subtype='intrattenimento'">
                <act type="committee" ref="{persName/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:when>
            <xsl:otherwise>
                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
