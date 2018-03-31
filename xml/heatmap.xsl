<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org" xmlns="http://www.w3.org/2000/svg"
    version="3.0">
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons" as="xs:string+" select="sort(distinct-values(//act/@ref))"/>
    <xsl:variable name="dates" as="xs:string+" select="sort(distinct-values(//act/date/@when))"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <svg width="100%" height="500">
            <g transform="translate(0,{count($dates) * 5})">
                <xsl:for-each select="$persons">
                    <xsl:variable name="currentPerson" as="xs:string" select="."/>
                    <xsl:variable name="currentPersonPos" as="xs:integer" select="position()"/>
                    <xsl:for-each select="$dates">
                        <xsl:variable name="currentDate" as="xs:string" select="."/>
                        <xsl:variable name="currentDatePos" as="xs:integer" select="position()"/>
                        <xsl:variable name="count" as="xs:integer"
                            select="count($root//act[@ref eq $currentPerson and date/@when = $currentDate])"/>
                        <xsl:variable name="saturation" as="xs:double" select="$count * 100 div 7"/>
                        <rect x="{$currentPersonPos * 5}" y="-{$currentDatePos * 5}" width="5"
                            height="5" fill="hsl(240,{$saturation}%, 50%)"/>
                    </xsl:for-each>
                </xsl:for-each>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
