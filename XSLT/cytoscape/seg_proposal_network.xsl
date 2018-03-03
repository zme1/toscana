<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="minuteColl" select="collection('../../TEI/meetingMinutes')"/>
<xsl:template match="/">
    <xsl:for-each select="//seg[@type='proposal']">
        <xsl:value-of select="persName[@role='proposer']/@ref"/>
        <xsl:text>&#x9;</xsl:text>
        <xsl:value-of select="persName[@role='proposer']/@role"/>
        <xsl:text>&#x9;</xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text>&#x9;</xsl:text>
        <xsl:text>(proposal @subtype here)</xsl:text>
        <xsl:text>&#x9;</xsl:text>
        <xsl:value-of select="persName[@role='supporter']/@ref"/>
        <xsl:text>&#x9;</xsl:text>
        <xsl:value-of select="persName[@role='supporter']/@role"/>
        <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
</xsl:template>
</xsl:stylesheet>