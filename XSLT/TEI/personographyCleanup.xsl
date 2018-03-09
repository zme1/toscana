<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <!--<xsl:mode on-no-match="shallow-copy"/>-->

<xsl:variable name="currFile" select="doc('../../TEI/personography/personography2.xml')"/>
    <xsl:variable name="distinctIds" select="distinct-values($currFile//person/persName/@xml:id)"/>
 
 <xsl:template match="/">
     <TEI>
     <xsl:copy-of select="//teiHeader"/>
     <xsl:apply-templates select="//text"/>
     </TEI>
 </xsl:template>
 
   
    
<xsl:template match="text">
    <text>
    <body>
  <listPerson>
  <xsl:for-each select="$distinctIds">
     
<xsl:copy-of select="($currFile//person[persName/@xml:id=current()])[1]"/>   
      <xsl:comment><xsl:value-of select="."/></xsl:comment>
      
  </xsl:for-each>     
  </listPerson>
    </body>
    </text>
</xsl:template>

 
</xsl:stylesheet>