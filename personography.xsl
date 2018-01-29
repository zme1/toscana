<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:template match="/">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Lega Toscana di Protezione XSLT Generated Personography File</title>
                        <author>Zachary Enick</author>
                    </titleStmt>
                    <publicationStmt>
                        <authority>Prepared in TEI 5 by Zachary Enick for the Italian research assistantship at the
                            University of Pittsburgh. Github repository: <ref target="http://github.com/zme1/toscana"
                            />. Date last worked on: <date when="2018-01-28"/></authority>
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
                </body>
            </text>
        </TEI>
    </xsl:template>
    <xsl:template match="persName"></xsl:template>
</xsl:stylesheet>