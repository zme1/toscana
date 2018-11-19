<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="yScale" as="xs:double" select="8.2812"/>
    <xsl:variable name="xLength" as="xs:integer" select="1000"/>
    <xsl:template match="/">
        <div class="grammar">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 640">
                <g transform="translate(120,290)">
                    <!-- Top half of the graph -->
                    <line x1="0" y1="0" x2="1000" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="-265" x2="1000" y2="-265" stroke="black" stroke-width="1"/>
                    <line x1="1000" y1="0" x2="1000" y2="-265" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-265" stroke="black" stroke-width="1"/>
                    <!-- Bottom half of the graph -->
                    <line x1="0" y1="265" x2="1000" y2="265" stroke="black" stroke-width="1"/>
                    <line x1="1000" y1="0" x2="1000" y2="265" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="265" stroke="black" stroke-width="1"/>
                </g>
            </svg>
        </div>
    </xsl:template>
</xsl:stylesheet>