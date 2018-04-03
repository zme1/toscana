<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org" xmlns="http://www.w3.org/1999/html"
    version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons" as="xs:string+" select="sort(distinct-values(//act/@ref))"/>
    <xsl:variable name="dates" as="xs:string+" select="sort(distinct-values(//act/date/@when))"/>
    <xsl:template match="/">
    <html>
        <head>
            <title>Heatmap tables</title>
        </head>
        <body>
<p>This is a test.</p>
        </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
