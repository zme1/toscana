<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org" xmlns="http://toscana.newtfire.org"
    version="3.0">
    <xsl:variable name="root" select="/"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <years>
            <xsl:apply-templates select="//year"/>
        </years>
    </xsl:template>
    <xsl:template match="year">
        <year when="{@when}"><officers><xsl:variable name="currentYear" select="."/>
        <xsl:variable name="dates" as="xs:string+" select="distinct-values(act/date/@when)"/>
        <xsl:for-each select="distinct-values(act[@type='officer']/@ref)">
            <officer ref="{current()}"><xsl:value-of select="count($root//$currentYear/act[@ref eq current()])"/></officer>
        </xsl:for-each></officers>
        <total><xsl:value-of select="count(act)"/></total></year>
    </xsl:template>
</xsl:stylesheet>