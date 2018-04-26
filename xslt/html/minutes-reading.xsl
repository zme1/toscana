<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://toscana.newtfire.org"
    exclude-result-prefixes="xs" xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <link type="text/css" rel="stylesheet" href="../../css/lega.css"/>
                <title>Minute Volume</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="year">
        <section class="minutes-{@when}">
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    <xsl:template match="pb">
        <img class="thumbnail" src="{@facs}"/>
    </xsl:template>
</xsl:stylesheet>