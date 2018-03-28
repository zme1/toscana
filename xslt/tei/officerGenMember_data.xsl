<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0">
    <xsl:template match="/">
        <years>
            <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
        </years>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <year when="{teiHeader/descendant::publicationStmt/date/@when}">
            <xsl:for-each select="descendant::seg[@type = 'proposal']">
                <xsl:choose>
                    <xsl:when test="count(descendant::*[@role = 'supporter'][not(@ref='#legaT')]) gt 1">
                        <act type="proposal" ref="{descendant::*[@role='supporter'][1]/@ref}"/>
                        <act type="proposal" ref="{descendant::*[@role='supporter'][2]/@ref}"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <act type="proposal" ref="{descendant::*[@role='proposer']/@ref}"/>
                        <act type="proposal" ref="{descendant::*[@role='supporter']/@ref}"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </year>
    </xsl:template>
</xsl:stylesheet>
