<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://toscana.newtfire.org" exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
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
    <xsl:template match="div[@type = 'meeting']">
        <xsl:variable name="precedePb" select="preceding::pb[1]"/>
        <div class="meeting">
            <div class="img"><xsl:apply-templates select="descendant::pb[parent::div[@type = 'transcription']]" mode="thumbnail"/></div>
        </div>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="pb" mode="thumbnail">
        <img target="_blank" class="thumbnail" src="{@facs}"/>
    </xsl:template>
    <xsl:template match="div[@type='transcription' or @type='translation']">
        <div class="{@type}-{@when}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    <xsl:template match="signed">
    <xsl:apply-templates/><xsl:text> [ signed ]</xsl:text>
    </xsl:template>
    <xsl:template match="unclear">
        <xsl:text>[ unclear ]</xsl:text>
    </xsl:template>
    <xsl:template match="del">
        <span class="del"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="pb">
        <hr/>
    </xsl:template>
</xsl:stylesheet>
