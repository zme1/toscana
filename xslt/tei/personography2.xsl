<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="distinctPers" select="distinct-values(//TEI//persName)"/>
    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Lega Toscana di Protezione XSLT Generated Personography File - 2</title>
                        <author>Zachary Enick</author>
                    </titleStmt>
                    <publicationStmt>
                        <authority>Prepared in TEI 5 by Zachary Enick for the Italian research assistantship at the
                            University of Pittsburgh. Github repository: <ref target="http://github.com/zme1/toscana"
                            />. Date last worked on: <date when="2018-03-08"/></authority>
                        <availability>
                            <licence><!-- licence to go here --></licence>
                        </availability>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Born digital.</p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <listPerson>
                        <xsl:apply-templates select="//persName"/>
                    </listPerson>
                </body>
            </text>
        </TEI>
    </xsl:template>
<xsl:template match="TEI//persName">
    <xsl:variable name="distinctId" select="@ref"/>
    <xsl:variable name="distinctIdNoHash" select="$distinctId/tokenize(string(), '#')"/>
    <person>
        <persName xml:id="{$distinctIdNoHash}">
            <surname></surname>
            <forename></forename>
            <roleName>
                <xsl:apply-templates select="//roleName[preceding-sibling::persName[@ref=current()/@ref] or following-sibling::persName[@ref=current()/@ref]]">
                    <xsl:sort select="@type" order="descending"/>
                </xsl:apply-templates>
            </roleName>
        </persName>
    </person>
</xsl:template>
    <xsl:template match="roleName">
        <roleName type="{current()/@type}" role="{current()/@role}"/>
    </xsl:template>
</xsl:stylesheet>