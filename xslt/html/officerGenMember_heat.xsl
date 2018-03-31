<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:tos="http://toscana.newtfire.org" xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="persons" as="xs:string+" select="sort(distinct-values(//@ref))"/>
    <xsl:variable name="dates" as="xs:string+" select="//tos:date/@when"/>
    <xsl:template match="/">
        <xsl:message>
            <xsl:sequence select="$dates"/>
        </xsl:message>
        <svg>
            <g transform="translate(20,690)">
                <line x1="0" y1="0" x2="1160" y2="0" stroke="black" stroke-width="2"/>
                <line x1="0" y1="-670" x2="1160" y2="-670" stroke="black" stroke-width="2"/>
                <line x1="1160" y1="0" x2="1160" y2="-670" stroke="black" stroke-width="2"/>
                <line x1="0" y1="0" x2="0" y2="-670" stroke="black" stroke-width="2"/>
                <rect x="0" y="-5.87" height="5.87" width="14.32" fill="red"/>
            </g>
        </svg>
        <xsl:for-each select="$dates">
            <xsl:variable name="currentDate" select="current()"/>
        <xsl:for-each select="$persons">
            <xsl:variable name="currentPerson" select="current()"/>
                <xsl:variable name="match" select="$document//tos:act[@ref = current()]"/>
            <xsl:variable name="allDates" select="$match/tos:date/@when"/>
            <xsl:for-each select="$allDates">   
            <xsl:comment>
                   <xsl:value-of select="concat($currentPerson, ': ', string-join(current()[.= $currentDate], ', '))"/>
                
                </xsl:comment>
            </xsl:for-each>
        </xsl:for-each> 
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
