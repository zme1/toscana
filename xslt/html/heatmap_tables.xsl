<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org" xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons" as="xs:string+" select="sort(distinct-values(//act/@ref))"/>
    <xsl:variable name="dates" as="xs:string+" select="sort(distinct-values(//act/date/@when))"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Heatmap tables</title>
            </head>
            <body>
                <xsl:for-each select="$persons">
                    <xsl:variable name="currentPerson" as="xs:string" select="."/>
                    <xsl:variable name="currentPersonPos" as="xs:integer" select="position()"/>
                    <xsl:for-each select="$dates">
                        <xsl:variable name="currentDate" as="xs:string" select="."/>
                        <xsl:variable name="currentDatePos" as="xs:integer" select="position()"/>
                        <xsl:variable name="activities" select="$root//act[@ref eq $currentPerson and date/@when eq $currentDate]"/>
                        <table class="{$currentDate}{$currentPerson}">
                            <tr>
                                <th>Name</th>
                                <td>Date</td>
                                <td>Tracked Activity</td>
                            </tr>
                            <tr>
                                <td><xsl:value-of select="$currentPerson"/></td>
                                <td><xsl:value-of select="$currentDate"/></td>
                                <td>HI</td>
                                <!--<xsl:if test="count($activities) eq 0">
                                    <td>N/A</td>
                                </xsl:if>
                                <xsl:if test="count($activities) eq 1">
                                    <td><xsl:value-of select="concat($activities/@type, ': ', $activities/@role, '$#xa;')"/></td>
                                </xsl:if>-->
                            </tr>
                        </table>
                    </xsl:for-each>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
