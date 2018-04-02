<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://toscana.newtfire.org"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="persons" as="xs:string+" select="sort(distinct-values(//act/@ref))"/>
    <xsl:variable name="dates" as="xs:string+" select="sort(distinct-values(//act/date/@when))"/>
    <!-- The preceding two variables are for the purpose of locating specific points on the visualization
    by identifying intersecting points between the @ref values and @dates. Every @ref and @date combination
    have a unique point on the visualization, based on the combination of their relative positions in the
    series of strings, declared in the two variables. They are sorted alphetically and chronologically,
    respectively. -->
    <xsl:variable name="yLength" as="xs:integer" select="640"/>
    <xsl:variable name="xLength" as="xs:integer" select="1000"/>
    <xsl:variable name="xScale" as="xs:double" select="$xLength div count($persons)"/>
    <xsl:variable name="yScale" as="xs:double" select="$yLength div count($dates)"/>
    <!-- These variables will be used to create the graph's proportions and scale the rectangles' width and height. -->
    <xsl:template match="/">
        <h3>Member and Officer Activity</h3>
        <hr class="min"/>
        <div class="heatmapSvg">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 700">
                <g transform="translate(60,{$yLength + 30})">
                    <xsl:for-each select="$persons">
                        <xsl:variable name="currentPerson" as="xs:string" select="."/>
                        <xsl:variable name="currentPersonPos" as="xs:integer" select="position()"/>
                        <xsl:for-each select="$dates">
                            <xsl:variable name="currentDate" as="xs:string" select="."/>
                            <xsl:variable name="currentDatePos" as="xs:integer" select="position()"/>
                            <xsl:variable name="count" as="xs:integer"
                                select="count($root//act[@ref eq $currentPerson and date/@when = $currentDate])"/>
                            <xsl:choose>
                                <xsl:when test="$count eq 0">
                                    <rect stroke="black" stroke-width=".2"
                                        x="{$currentPersonPos * $xScale}"
                                        y="-{$currentDatePos * $yScale}" width="{$xScale}"
                                        height="{$yScale}" fill="rgb(255, 255, 212)"/>
                                </xsl:when>
                                <xsl:when test="$count eq 1">
                                    <rect stroke="black" stroke-width=".2"
                                        x="{$currentPersonPos * $xScale}"
                                        y="-{$currentDatePos * $yScale}" width="{$xScale}"
                                        height="{$yScale}" fill="rgb(254, 227, 145)"/>
                                </xsl:when>
                                <xsl:when test="$count eq 2">
                                    <rect stroke="black" stroke-width=".2"
                                        x="{$currentPersonPos * $xScale}"
                                        y="-{$currentDatePos * $yScale}" width="{$xScale}"
                                        height="{$yScale}" fill="rgb(254, 196, 79)"/>
                                </xsl:when>
                                <xsl:when test="$count eq 3">
                                    <rect stroke="black" stroke-width=".2"
                                        x="{$currentPersonPos * $xScale}"
                                        y="-{$currentDatePos * $yScale}" width="{$xScale}"
                                        height="{$yScale}" fill="rgb(254, 153, 41)"/>
                                </xsl:when>
                                <xsl:when test="$count eq 4">
                                    <rect stroke="black" stroke-width=".2"
                                        x="{$currentPersonPos * $xScale}"
                                        y="-{$currentDatePos * $yScale}" width="{$xScale}"
                                        height="{$yScale}" fill="rgb(217, 95, 14)"/>
                                </xsl:when>
                                <xsl:when test="$count eq 5">
                                    <rect stroke="black" stroke-width=".2"
                                        x="{$currentPersonPos * $xScale}"
                                        y="-{$currentDatePos * $yScale}" width="{$xScale}"
                                        height="{$yScale}" fill="rgb(153, 52, 4)"/>
                                </xsl:when>
                            </xsl:choose>

                            <!-- The <xsl:choose> above uses the variables declared  to find the points in the graph
                        that pertain to a specific person on a specific day, and each of these <xsl:when> elements determines
                        the color of the rectangle based on the color. I tried to use variables to determine the color, but
                        with no luck. -->

                            <xsl:if
                                test="$root//act[@type = 'officer' and @ref eq $currentPerson and date/@when = $currentDate]">
                                <line x1="{$currentPersonPos * $xScale}"
                                    y1="-{$currentDatePos * $yScale}"
                                    x2="{$currentPersonPos * $xScale}"
                                    y2="-{$currentDatePos * $yScale - $yScale}" stroke="black"
                                    stroke-width="2"/>
                                <line x1="{$currentPersonPos * $xScale + $xScale}"
                                    y1="-{$currentDatePos * $yScale}"
                                    x2="{$currentPersonPos * $xScale + $xScale}"
                                    y2="-{$currentDatePos * $yScale - $yScale}" stroke="black"
                                    stroke-width="2"/>
                            </xsl:if>

                            <!-- The <xsl:if statement above finds every rectangle that has a unit of activity of @type officer. In knowing this, I can find out who was an acting officer
                        on a given day, and the relationship between general member and officer activity comes to light. I have one line on the left and right of each rectangle. -->

                        </xsl:for-each>
                    </xsl:for-each>
                    <xsl:for-each select="//year">
                        <xsl:variable name="meetingCount" as="xs:integer" select="count(meeting)"/>
                        <xsl:variable name="prevMeetingCount" as="xs:integer"
                            select="count(preceding-sibling::year/meeting)"/>
                        <xsl:variable name="meetingTotal" as="xs:integer"
                            select="$meetingCount + $prevMeetingCount"/>
                        <line x1="8.892" y1="-{$meetingTotal * $yScale}" x2="{$xLength + 8.892}"
                            y2="-{$meetingTotal * $yScale}" stroke="black" stroke-width="2"/>
                        <text x="-25" y="-{(($meetingCount div 2) + $prevMeetingCount) * $yScale}"
                            text-anchor="middle">
                            <xsl:value-of select="@when"/>
                        </text>
                    </xsl:for-each>

                    <!-- This last <xsl:if> statement uses the <year> elements in my input document to add the year number to the axis labels. As of now, the graph's
                cells are still quite small, and I'm unsure how I will label the axes for people without using JavaScript. -->
                </g>
            </svg>
        </div>
    </xsl:template>
</xsl:stylesheet>
