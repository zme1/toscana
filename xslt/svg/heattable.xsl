<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org" xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons" as="xs:string+"
        select="sort(distinct-values(//act/@ref))"/>
    <xsl:variable name="dates" as="xs:string+"
        select="sort(distinct-values(//act/date/@when))"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Hi, Mom!</title>
            </head>
            <body>
                <table border="1">
                    <tr>
                        <th>Name</th>
                        <th>Date</th>
                        <th>Count</th>
                    </tr>
                    <xsl:for-each select="$persons">
                        <xsl:variable name="currentPerson" as="xs:string" select="."/>
                        <xsl:for-each select="$dates">
                            <xsl:variable name="currentDate" as="xs:string" select="."/>
                            <xsl:variable name="count" as="xs:integer"
                                select="count($root//act[@ref eq $currentPerson and date/@when = $currentDate])"/>
                            <tr>
                                <td>
                                    <xsl:value-of select="$currentPerson"/>
                                </td>
                                <td>
                                    <xsl:value-of select="$currentDate"/>
                                </td>
                                <td>
                                    <xsl:value-of select="$count"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
