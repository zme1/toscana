<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns="http://toscana.newtfire.org" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <years>
            <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
        </years>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <year when="{teiHeader/descendant::publicationStmt/date/@when}">
            <xsl:for-each select="TEI">
                <xsl:variable name="yr" as="xs:string" select="teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
                <xsl:variable name="mo" as="xs:string" select="teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[2]"/>
                <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
                <meeting when="{$yrmo}"/>
            </xsl:for-each>
            <xsl:apply-templates select="TEI"/>
            <xsl:apply-templates select="descendant::seg"/>
            <xsl:apply-templates select="descendant::list[@type = 'committee']"/>
            <xsl:apply-templates
                select="descendant::list[@type = 'committee'][not(@subtype = 'investigazione')][not(@subtype = 'regolamento')][not(@subtype = 'intrattenimento')]/descendant::item[persName]"
            />
        </year>
    </xsl:template>
    <xsl:template match="seg[@type = 'proposal']">
        <xsl:variable name="yr"
            select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo"
            select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:choose>
            <xsl:when test="count(descendant::persName[@role = 'supporter']) eq 2">
                <act type="proposal" ref="{descendant::persName[@role='proposer']/@ref}">
                    <date when="{$yrmo}"/>
                </act>
                <act type="proposal" ref="{descendant::persName[@role='supporter'][1]/@ref}">
                    <date when="{$yrmo}"/>
                </act>
                <act type="proposal" ref="{descendant::persName[@role='supporter'][2]/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:when>
            <xsl:when test="descendant::*[@role='supporter'][@ref='#legaT']">
                <act type="proposal" ref="{descendant::persName[@role='proposer']/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:when>
            <xsl:when test="count(descendant::persName[@role='supporter']) eq 1">
                <act type="proposal" ref="{descendant::persName[@role='proposer']/@ref}">
                    <date when="{$yrmo}"/>
                </act>
                <act type="proposal" ref="{descendant::persName[@role='supporter']/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="seg[@type = 'proposalWritten']">
        <xsl:for-each select="*[@role = 'proposer']">
            <xsl:variable name="yr"
                select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
            <xsl:variable name="mo"
                select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[2]"/>
            <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
            <act type="proposal" ref="{@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="seg[@type = 'proposalReject']">
        <xsl:for-each select="*[@role]">
            <xsl:variable name="yr"
                select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
            <xsl:variable name="mo"
                select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[2]"/>
            <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
            <act type="proposal" ref="{@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="seg[@type = 'comp']">
        <xsl:variable name="yr"
            select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo"
            select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:for-each select=".[@subtype = 'sick']">
            <act type="compensation" ref="{*[@role='target']/@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
        <xsl:for-each select=".[@subtype = 'donation']">
            <act type="donation" ref="{*[@role='source']/@ref}">
                <date when="{$yrmo}"/>
            </act>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="list[@type = 'committee']">
        <xsl:variable name="yr"
            select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo"
            select="ancestor::text/preceding-sibling::teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:if test="@subtype = 'regolamento'">

            <xsl:for-each select="descendant::item[not(list)]">
                <act type="committee" subtype="regolamento" ref="{descendant::persName/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="@subtype = 'investigazione'">
            <xsl:for-each select="item[not(list)]">
                <act type="committee" subtype="investigazione" ref="{descendant::persName/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="@subtype = 'intrattenimento'">
            <xsl:for-each select="item[not(list)]">
                <act type="committee" subtype="intrattenimento" ref="{descendant::persName/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template
        match="list[@type = 'committee'][not(@subtype = 'investigazione')][not(@subtype = 'regolamento')][not(@subtype = 'intrattenimento')]/descendant::item[persName]">
        <xsl:variable name="date" select="ancestor::list[@type]/date/@when"/>
        <xsl:variable name="dateToken"
            select="tokenize(ancestor::list[@type]/date/@when-custom, ' ')"/>
        <xsl:variable name="context" select="current()"/>
        <xsl:if test="ancestor::list[date/@when-custom]">
            <act>
                <xsl:attribute name="type">committee</xsl:attribute>
                <xsl:attribute name="subtype"><xsl:value-of select="ancestor::list[@type]/@subtype"/></xsl:attribute>
                <xsl:attribute name="ref">
                    <xsl:value-of select="persName/@ref"/>
                </xsl:attribute>
                <xsl:for-each select="$dateToken">
                    <date>
                        <xsl:attribute name="when">
                            <xsl:value-of select="current()"/>
                        </xsl:attribute>
                    </date>
                </xsl:for-each>
            </act>
        </xsl:if>
        <xsl:if test="$date">
            <act>
                <xsl:attribute name="type">committee</xsl:attribute>
                <xsl:attribute name="subtype"><xsl:value-of select="ancestor::list[@type]/@subtype"/></xsl:attribute>
                <xsl:attribute name="ref">
                    <xsl:value-of select="persName/@ref"/>
                </xsl:attribute>
                    <date>
                        <xsl:attribute name="when">
                            <xsl:value-of select="$date"/>
                        </xsl:attribute>
                    </date>
                
            </act>
        </xsl:if>
    </xsl:template>
    <xsl:template match="TEI">
        <xsl:variable name="officer" select="./descendant::listPerson/person"/>
        <xsl:variable name="yr"
            select="teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[1]"/>
        <xsl:variable name="mo"
            select="teiHeader/descendant::publicationStmt/date/tokenize(@when, '-')[2]"/>
        <xsl:variable name="yrmo" select="string-join(($yr, $mo), '-')"/>
        <xsl:for-each select="$officer">
            <!--<role type="officer" ref="{persName/@ref}">
                <date when="{$yrmo}"/>
            </role>-->
            <xsl:if
                test="not(ancestor::TEI/descendant::list[@type = 'absent']/item/persName[matches(@ref, current()/persName/@ref)])">
                <act type="officer" role="{roleName/@role}" ref="{persName/@ref}">
                    <date when="{$yrmo}"/>
                </act>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
