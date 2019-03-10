<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="lemmas" as="node()+" select="//w/@lemma"/>
    <xsl:variable name="distinctLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
    <xsl:variable name="graphLemmas" as="xs:string+">
        <for-each select="$distinctLemmas">
            <xsl:if test="count($root//w[not(ancestor::foreign) and @lemma = current()]) ge 4">
                <xsl:value-of select="current()"/>
            </xsl:if>
        </for-each>
    </xsl:variable>
    <xsl:template match="/">
        <div class="lemma-circle">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 680">
                <g transform="translate(120,550)">
                    
                </g>
            </svg>
        </div>
    </xsl:template>
    
</xsl:stylesheet>