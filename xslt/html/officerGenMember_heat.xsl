<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="persons" as="xs:string+" select="distinct-values(//@ref)"/>
    <xsl:template match="/">
        <svg>
            <g transform="translate(20,690)">
                <line x1="0" y1="0" x2="1160" y2="0" stroke="black" stroke-width="2"/>
                <line x1="0" y1="-670" x2="1160" y2="-670" stroke="black" stroke-width="2"/>
                <line x1="1160" y1="0" x2="1160" y2="-670" stroke="black" stroke-width="2"/>
                <line x1="0" y1="0" x2="0" y2="-670" stroke="black" stroke-width="2"/>
                <rect x="0" y="-5.87" height="5.87" width="14.32" fill="red"/>
            </g>
        </svg>
    </xsl:template>

</xsl:stylesheet>
