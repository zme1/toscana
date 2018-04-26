<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://toscana.newtfire.org"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
<minutes><xsl:apply-templates select="teiCorpus/teiCorpus"/></minutes>    
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <year when="{teiHeader//publicationStmt/date/@when}">
            <xsl:apply-templates select="descendant::body"/>
        </year>
    </xsl:template>
    <xsl:template match="div">
        <div type="{@type}" when="{ancestor::text/preceding-sibling::teiHeader//publicationStmt/date/@when}"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="pb">
        <pb n="{@n}" facs="{@facs}" when="{ancestor::text/preceding-sibling::teiHeader//publicationStmt/date/@when}"/>
    </xsl:template>
    <xsl:template match="lb">
        <lb/>
    </xsl:template>
    <xsl:template match="signed">
        <signed><xsl:apply-templates/></signed>
    </xsl:template>
</xsl:stylesheet>