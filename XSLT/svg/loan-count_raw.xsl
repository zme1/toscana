<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://tei-c.org"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <div class="loan-raw">
            <svg xmlns="http://www.w3.org/2000/svg" height="500" width="1000">
                <g transform="translate(200, 500)">
                    <line x1="0" y1="0" x2="700" y2="0" stroke="black" stroke-width="1"/>
                    <line x1="0" y1="0" x2="0" y2="-300" stroke="black" stroke-width="1"/>
                </g>
            </svg>
        </div>
    </xsl:template>
</xsl:stylesheet>
