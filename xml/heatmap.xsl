<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org" xmlns="http://www.w3.org/2000/svg"
    version="3.0">
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons" as="xs:string+" select="sort(distinct-values(//act/@ref))"/>
    <xsl:variable name="dates" as="xs:string+" select="sort(distinct-values(//act/date/@when))"/>
    <!-- The preceding two variables are for the purpose of locating specific points on the visualization
    by identifying intersecting points between the @ref values and @dates. Every @ref and @date combination
    have a unique point on the visualization, based on the combination of their relative positions in the
    series of strings, declared in the two variables. They are sorted alphetically and chronologically,
    respectively. -->
    <xsl:variable name="yLength" as="xs:integer" select="640"/>
    <xsl:variable name="xLength" as="xs:integer" select="1000"/>
    <xsl:variable name="xScale" as="xs:double" select="$xLength div count($persons)"/>
    <xsl:variable name="yScale" as="xs:double" select="$yLength div count($dates)"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <svg width="100%" height="100%">
            <g transform="translate(50,{$yLength + 30})">
                <xsl:for-each select="$persons">
                    <xsl:variable name="currentPerson" as="xs:string" select="."/>
                    <xsl:variable name="currentPersonPos" as="xs:integer" select="position()"/>
                    <xsl:for-each select="$dates">
                        <xsl:variable name="currentDate" as="xs:string" select="."/>
                        <xsl:variable name="currentDatePos" as="xs:integer" select="position()"/>
                        <xsl:variable name="count" as="xs:integer"
                            select="count($root//act[@ref eq $currentPerson and date/@when = $currentDate])"/>
                        <xsl:variable name="saturation" as="xs:double" select="$count * 100 div 7"/>
                        <rect x="{$currentPersonPos * $xScale}" y="-{$currentDatePos * $yScale}" width="{$xScale}"
                            height="{$yScale}" fill="hsl(240,{$saturation}%, 50%)"/>
                        <text transform="rotate(90)" x="15" y="-{$currentPersonPos * $xScale}" text-anchor="middle" font-size="4px">*</text>
                    </xsl:for-each>
                </xsl:for-each>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
