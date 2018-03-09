<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
<xsl:mode on-no-match="shallow-copy"/>
    <!--2018-03-08 ebb: The line above performs the identify transformation. In oXygen, we'll set this to transform personography2.xml into itself, and just add info into it that we pull from the minutes file.  NOTE: I added the TEI namespace to your root element in the personography2.xml-->

<xsl:variable name="minutes" select="doc('../../TEI/meetingMinutes/volume1.xml')"/>
<!--ebb: I think this is the full set of your minutes files. Hope I got the file path right. -->
    
    <xsl:template match="person">
        <person xml:id="{persName/@xml:id}">
            <!--ebb: I'm just bumping your @xml:id up onto the person element in the output! -->
        <persName>
            <surname><xsl:apply-templates select="persName/surname"/></surname>
            <forename><xsl:apply-templates select="persName/forename"/></forename>
            <roleName><xsl:apply-templates select="roleName"/>
                <!--ebb: I think the first apply-templates here should grab the existing contents of the roleName element in your personography2.xml file. -->
                <xsl:variable name="currentID" select="persName/@xml:id"/>
                <!--ebb: I converted this into a local variable to make it easy to access in the for-each loop below. -->
                <xsl:for-each select="$minutes//TEI[descendant::profileDesc//person[substring-after(persName/@ref, '#')=$currentID]]">
                    <roleName type="{current()//descendant::profileDesc//person[substring-after(persName/@ref, '#')=$currentID]/roleName/@type}" role="{current()//descendant::profileDesc//person[substring-after(persName/@ref, '#')=$currentID]/roleName/@role}">
                   <date when="{ancestor::teiHeader//publicationStmt/date/@when}"/>
                        <!--ebb: Yeah, I know: this doesn't get you a convenient start date and end date, but instead, it'll output every year with this person mentioned in a particular role. I think you could process the output one more time to iron out the results...let's see how this turns out first. -->
               </roleName>
           </xsl:for-each>
            </roleName>           
        </persName>
        </person>
    </xsl:template>
    
</xsl:stylesheet>