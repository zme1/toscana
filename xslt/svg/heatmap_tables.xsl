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
                    <xsl:variable as="xs:string*" name="activity">
                        <xsl:for-each
                            select="$root//act[@ref eq $currentPerson and $currentDate eq date/@when]">
                            <xsl:variable name="type" select="@type" as="xs:string"/>
                            <xsl:variable name="subtype" select="@subtype" as="xs:string?"/>
                            <xsl:variable name="role" select="@role" as="xs:string?"/>
                            <xsl:variable name="concat" as="xs:string">
                                <xsl:choose>
                                    <xsl:when test="$type eq 'committee'">
                                        <xsl:sequence
                                            select="concat($subtype, ' ', $type, ', ', $role)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:sequence select="$type"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:sequence select="$concat"/>
                        </xsl:for-each>
                    </xsl:variable>
                    <tbody class="heatToggle" id="tbody-{$idPerson[1]}{$idDate[1]}"
                        style="display: none;">
                        <tr>
                            <td>
                                <xsl:value-of select="$idPerson[1]"/>
                            </td>
                            <td>
                                <xsl:value-of select="$currentDate"/>
                            </td>
                            <td>
                                <xsl:value-of
                                    select="
                                        if (count($activity) gt 0) then
                                            string-join($activity, '; ')
                                        else
                                            '[No activity]'"
                                />
                            </td>
                        </tr>
                    </tbody>
                </xsl:for-each>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>
