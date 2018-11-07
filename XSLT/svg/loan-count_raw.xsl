<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://tei-c.org"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="dotInterval" as="xs:integer" select="90"/>
    <xsl:variable name="xLength" select="$dotInterval * 12 + 20"/>
    <xsl:variable name="yScale" select="1"/>
    <xsl:variable name="maxAng" select="max(//TEI/count(descendant::w))"/>
    <xsl:template match="/">
        <div class="loan-raw">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 640">
                <g transform="translate(100,600)">
                    <line x1="0" y1="0" x2="800" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-560" stroke="black" stroke-width="1"/>
                    <text x="100" y="30" text-align="center">hi</text>
                </g>
            </svg>
        </div>
    </xsl:template>
</xsl:stylesheet>
