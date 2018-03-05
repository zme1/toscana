<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="minuteColl" select="collection('../../TEI/meetingMinutes')/*"/>
<xsl:template match="/">
    <xsl:for-each select="$minuteColl//TEI//seg[@type='proposal']">
        <xsl:choose>
            <xsl:when test="count(*[@role='supporter']) eq 2">
                <xsl:value-of select="descendant::*[@role='proposer']/@ref"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='proposer']/@role"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="./@type"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='supporter'][1]/@ref"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='supporter'][1]/@role"/>
                <xsl:text>&#xa;</xsl:text>
                <xsl:value-of select="descendant::*[@role='proposer']/@ref"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='proposer']/@role"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="./@type"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='supporter'][2]/@ref"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='supporter'][2]/@role"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="descendant::*[@role='proposer']/@ref"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='proposer']/@role"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="./@type"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='supporter']/@ref"/>
                <xsl:text>&#x9;</xsl:text>
                <xsl:value-of select="descendant::*[@role='supporter']/@role"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
</xsl:template>
</xsl:stylesheet>