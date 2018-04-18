<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://toscana.newtfire.org"
    xpath-default-namespace="http://toscana.newtfire.org"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="act[count(date) gt 1]">
        <xsl:for-each select="date">
            <act type="{../@type}" subtype="{../@subtype}" ref="{../@ref}" role="{../@role}">
                <date when="{@when}"/>
            </act>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="act[not(@role)][@type='committee']">
        <act type="{@type}" subtype="{@subtype}" ref="{@ref}" role="membro">
            <date when="{date/@when}"/>
        </act>
    </xsl:template>
</xsl:stylesheet>