<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
  
<xsl:variable name="currFile" select="doc('../../TEI/personography/personography2.xml')"/>
    <xsl:variable name="distinctIds" select="distinct-values($currFile//person/@xml:id)"/>
 
 <xsl:template match="/">
     <TEI>
     <xsl:copy-of select="//teiHeader"/>
         <!--2018-03-08 ebb: xsl:copy-of is known as "deep copy": it's basically an identity transformation of everything marked from this point on, and it'll output the teiHeader with its tags and all its descendants intact. -->
     <xsl:apply-templates select="//text"/>
     </TEI>
 </xsl:template>
  
<xsl:template match="text">
    <text>
    <body>
  <listPerson>
  <xsl:for-each select="$distinctIds">
     
<xsl:copy-of select="($currFile//person[@xml:id=current()])[1]"/>   
  </xsl:for-each>     
  </listPerson>
    </body>
    </text>
</xsl:template>

 
</xsl:stylesheet>