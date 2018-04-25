<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="teiCorpus[teiCorpus]">
        <minutes>
            <xsl:apply-templates select="descendant::TEI"/>
        </minutes>
    </xsl:template>
    <xsl:template match="lb">
        <lb/>
    </xsl:template>
    <xsl:template match="TEI">
        <meeting date="{descendant::publicationStmt/date/@when}"/>
        <xsl:apply-templates select="descendant::body"/>
    </xsl:template>
    <xsl:template match="persName">
        <persName ref="{@ref}"><xsl:apply-templates/></persName>
    </xsl:template>
    <xsl:template match="rs">
        <rs ref="{@ref}"><xsl:apply-templates/></rs>
    </xsl:template>
    <xsl:template match="pb">
        <pb n="{@n}" facs="{@facs}"/>
    </xsl:template>
    <xsl:template match="div">
        <div type="{@type}"><xsl:apply-templates/></div>
        
    </xsl:template>
</xsl:stylesheet>