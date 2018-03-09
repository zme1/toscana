<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
        version="3.0">
        
        <xsl:output method="xml" indent="yes"/>
        <xsl:mode on-no-match="shallow-copy"/>
        <xsl:variable name="minutes" select="doc('../../TEI/meetingMinutes/volume1.xml')"/>
        <xsl:template match="person">
 <person xml:id="{persName/@xml:id}">
     <xsl:apply-templates select="persName"/>
 </person>
        </xsl:template>
        <xsl:template match="persName">
            <persName>
                <xsl:apply-templates/>
                <note/>
            </persName>
        </xsl:template>
</xsl:stylesheet>