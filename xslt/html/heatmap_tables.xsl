<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons" as="xs:string+" select="sort(distinct-values(//act/@ref))"/>
    <xsl:variable name="dates" as="xs:string+" select="sort(distinct-values(//act/date/@when))"/>
    <xsl:template match="/">
        <table class="heatTable">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Date</th>
                    <th>Tracked Activity</th>
                </tr>
            </thead>
            <xsl:for-each select="$persons">
                <xsl:variable name="currentPerson" as="xs:string" select="."/>
                <xsl:variable name="idPerson"
                    select="$root//act[@ref eq $currentPerson]/substring-after(@ref, '#')"/>
                <xsl:variable name="currentPersonPos" as="xs:integer" select="position()"/>
                <xsl:for-each select="$dates">
                    <xsl:variable name="currentDate" as="xs:string" select="."/>
                    <xsl:variable name="idDate"
                        select="$root//act[date/@when eq $currentDate]/translate(date/@when, '-', '')"/>
                    <xsl:variable name="currentDatePos" as="xs:integer" select="position()"/>
                    <xsl:variable name="activity"
                        select="$root//act[@ref eq $currentPerson and $currentDate eq date/@when]"/>
                    <tbody class="heatToggle" id="tbody-{$idPerson[1]}{$idDate[1]}" style="display: none;">
                        <tr>
                            <td>
                                <xsl:value-of select="$currentPerson"/>
                            </td>
                            <td>
                                <xsl:value-of select="$currentDate"/>
                            </td>
                            <td>
                                <xsl:for-each select="$activity">
                                    <xsl:value-of select="@type"/>
                                </xsl:for-each>
                            </td>
                            <!-- I still need to format table cells with multiple units of
                                activity, but all the information is there. -->
                        </tr>
                    </tbody>
                </xsl:for-each>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>
