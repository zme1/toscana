<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
<xsl:apply-templates select="//list[@type='committee']"/>
    </xsl:template>
    <xsl:template match="list[@type='committee']">
        <xsl:variable name="currentList" select="current()"/>
        <xsl:for-each select="descendant::item[not(list)]">
            <xsl:variable name="currentPerson" select="current()"/>
            <xsl:for-each select="following::item[ancestor::list = $currentList][not(list)]">
                <xsl:value-of select="$currentPerson/persName/@ref"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="$currentList/@type"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="$currentList/@subtype"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="persName/@ref"/>
                <xsl:text>&#xa;</xsl:text> 
            </xsl:for-each>
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>