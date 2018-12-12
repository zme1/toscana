<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:template match="/">
        <html>
            <head><title>Messing with Lemmas</title>
            </head>
            <body>
                <h1>Table of Years with Lemma Data</h1>
                <table>
               <xsl:apply-templates select="//teiCorpus/teiCorpus"/>                    
                </table>
            </body>
        </html>
    </xsl:template> 
    <xsl:template match="teiCorpus">
        <!--ebb: Current context node, stored in a variable, for use in for-each loops: -->
        <xsl:variable name="current" select="current()"/>
        <xsl:variable name="year" as="xs:string" select="child::teiHeader//publicationStmt/date/@when"/>
        <xsl:variable name="lemmas" as="node()+" select="descendant::w[not(ancestor::foreign)]/@lemma"/>
        
        <xsl:variable name="distLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
       <xsl:comment>All Lemmas: <xsl:value-of select="$distLemmas"/></xsl:comment>
        <xsl:variable name="multiLemmas" as="xs:string+">
            <xsl:value-of select="for $i in $distLemmas return $i[count($current//w[not(ancestor::foreign)]/@lemma = current()) gt 1]"/>
        </xsl:variable>
        <xsl:comment>MultiLemmas: <xsl:value-of select="$multiLemmas"/></xsl:comment>
        <xsl:variable name="singleLemmas" as="xs:string+">
            <xsl:value-of select="for $i in $distLemmas return $i[count($current//w[not(ancestor::foreign)]/@lemma = $i) eq 1]"/>
        </xsl:variable>
        <tr>
            <td><xsl:value-of select="$year"/></td> 
            <td>
                <xsl:comment><xsl:value-of select="$multiLemmas"/></xsl:comment>
    <ul>
        <xsl:for-each select="$multiLemmas">
            <xsl:variable name="countCurrML" as="xs:integer" select="count($current//w[not(ancestor::foreign)]/@lemma = current())"/>
            <li>
             <xsl:value-of select="concat(current(), $countCurrML)"/>
            </li>
            
        </xsl:for-each>
        
    </ul>            
                
                
                
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>