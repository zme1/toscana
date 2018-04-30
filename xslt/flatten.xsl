<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!--
        Note: Transformation must be run with Saxon PE or EE (not HE) to get Italian
            output from format-date()
        Workflow
            Note: Interim structures are in TEI namespace, but are not valid TEI
            1.  Flatten
                Description: flatten all elements, linking start and end tags with shared @tagId values
                Input: original XML
                Output: $flattened
                Mode: templates are in 'flattened' mode
            2.  Group
                Description: group contents of each page in <page> element
                Input: $flattened:
                Output: $grouped
                Mode: templates are in ''grouped' mode
                Notes: dates and titles are sometimes in the wrong pages
            3.  Date fix
                Description: move dates and titles into correct pages
                Input: $grouped
                Output: $date   
                Note: templates are in 'date' mode
            4.  Map years to pages
                Description: create mapping of years to pages
                Input: $date
                Output: $page-chooser, page-chooser.xhtml
                Mode: pull processing, no templates
                Note: $page-chooser is serialized as navigation interface, and also used
                    to create separate HTML output for each year
            5.  Create HTML pages for each year
                Description: separate HTML file in pages-by-year subdirectory for each year's pages
                    Output is three column table: image, Italian, English
                Input: $date (contains <page> elements)
                Auxiliary input: $page-chooser (mapping from date to pages)
                Output: 1921.xhtml, etc. in pages-by-year subdirectory
                Mode: templates are in page-to-html mode
                
    -->
    <xsl:template match="/">
        <xsl:variable name="flattened" as="element(wrapper)">
            <wrapper>
                <xsl:apply-templates select="descendant::div[@type = 'transcription']/ab"
                    mode="flatten"/>
                <xsl:apply-templates select="descendant::div[@type = 'translation']/ab"
                    mode="flatten"/>
            </wrapper>
        </xsl:variable>
        <xsl:variable name="grouped" as="element(wrapper)">
            <wrapper>
                <xsl:for-each-group select="$flattened/node()" group-starting-with="pb">
                    <page>
                        <xsl:apply-templates select="current-group()" mode="grouped"/>
                    </page>
                </xsl:for-each-group>
            </wrapper>
        </xsl:variable>
        <xsl:variable name="date" as="element(wrapper)">
            <wrapper>
                <xsl:apply-templates select="$grouped" mode="date"/>
            </wrapper>
        </xsl:variable>
        <!-- 
            $date has been created, now do something with it
            create mapping of dates to pages first because it's needed to group dates by year 
        -->
        <xsl:result-document href="debug.xml">
            <xsl:sequence select="$date"/>
        </xsl:result-document>
        <!-- 
            Create HTML file that points from dates to pages
            Store as $page-chooser and serialize as page-chooser.xhtml
        -->
        <xsl:variable name="page-chooser" as="element(html:html)">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title>Hey, choose a meeting!</title>
                    <link type="text/css" rel="stylesheet" href="css/lega.css"/>
                </head>
                <body>
                    <h1>Hey, choose a meeting!</h1>
                    <ul id="page-chooser">
                        <xsl:for-each select="1 to count($date//date[parent::page[@lang = 'it']])">
                            <xsl:variable name="startDate"
                                select="($date//date)[position() eq current()]/@when"/>
                            <xsl:variable name="nextDate"
                                select="($date//date)[position() eq current() + 1]/@when"/>
                            <xsl:variable name="firstPage" as="xs:integer"
                                select="$startDate/ancestor::page/pb/@n"/>
                            <xsl:variable name="lastPage" as="xs:integer">
                                <xsl:choose>
                                    <xsl:when test="not($nextDate)">
                                        <xsl:value-of select="($date//page/pb)[last()]/@n"/>
                                    </xsl:when>
                                    <xsl:when
                                        test="$nextDate/ancestor::page/*[1][self::date[@when eq $nextDate]]">
                                        <xsl:value-of
                                            select="$nextDate/ancestor::page/preceding-sibling::page[1]/pb/@n"
                                        />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$nextDate/ancestor::page/pb/@n"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <li data-pages="{$firstPage to $lastPage}">
                                <xsl:value-of
                                    select="format-date(xs:date($startDate), '[D1] [MNn] [Y1,4]', 'it', (), 'it')"
                                />
                            </li>
                        </xsl:for-each>
                    </ul>
                </body>
            </html>
        </xsl:variable>
        <xsl:result-document href="pages-by-meeting.xhtml" doctype-system="about:legacy-compat"
            method="xml" indent="yes" xmlns="http://www.w3.org/1999/xhtml">
            <xsl:sequence select="$page-chooser"/>
        </xsl:result-document>
        <!-- 
            Create HTML output for each year
            Output is a three-column table, with image, Italian, English columns (in that order)
            English is currently a placeholder, image is pointer in the form of 
                http://toscana.newtfire.org/img/meetingMinutes/5.png
            Variables:
                $page-numbers: page numbers for current year
                $pages: <page> elements (in pseudo-TEI namespace) for current year
        -->
        <xsl:for-each-group select="$page-chooser//html:li"
            group-by="substring(., string-length(.) - 3)">
            <!-- numbers of pages for the current year -->
            <xsl:variable name="page-numbers" as="xs:integer+"
                select="sort(distinct-values(current-group()/@data-pages/tokenize(., ' ')) ! xs:integer(.))"/>
            <!-- <page> elements (in pseudo-TEI namespace) for current year -->
            <xsl:variable name="it-pages" as="element(tei:page)+"
                select="$date//tei:page[@lang eq 'it' and pb/@n = $page-numbers]"/>
            <xsl:result-document method="xml" indent="yes" doctype-system="about:legacy-compat"
                xmlns="http://www.w3.org/1999/xhtml"
                href="{concat('../html/',current-grouping-key(),'.html')}">
                <html>
                    <head>
                        <title>
                            <xsl:value-of select="concat('Minutes of ', current-grouping-key())"/>
                        </title>
                        <link rel="stylesheet" type="text/css" href="../css/lega.css"/>
                        <link rel="stylesheet" type="text/css" href="../css/minutes.css"/>
                    </head>
                    <body>
                        <xsl:comment>#include virtual="ssi/ssi_menu.html" </xsl:comment>
                        <div class="text">
                            <p>Welcome to the reading view of the first volume of the Lega Toscana
                                di Protezione's minute log; please feel free to browse any of the
                                seven years currently included in our corpus. The original
                                manuscript scans are to the left of the window, with the
                                transcription of the log in the middle, and our translation
                                occupying the rightmost column. <em>This is a current project in
                                    progress, so any and all comments on the translation or
                                    transcription of the minutes are warmly welcomed.</em> Please
                                contact Zac Enick at zacharyenick@pitt.edu with any feedback on the
                                rendering of the volume.</p>
                        </div>
                        <div class="custom-select">
                            <select onchange="location.href=this.options[this.selectedIndex].value;">
                                <option>Select Year</option>
                                <option value="1919.html">1919</option>
                                <option value="1920.html">1920</option>
                                <option value="1921.html">1921</option>
                                <option value="1922.html">1922</option>
                                <option value="1923.html">1923</option>
                                <option value="1924.html">1924</option>
                                <option value="1925.html">1925</option>
                            </select>
                        </div>
                        <h3>
                            <xsl:value-of select="concat('Minutes of ', current-grouping-key())"/>
                        </h3>
                        <table class="minutes">
                            <tr class="minutes">
                                <th>Image</th>
                                <th>Transcription</th>
                                <th>Translation</th>
                            </tr>
                            <xsl:for-each select="$it-pages">
                                <xsl:variable name="image-link" as="xs:string"
                                    select="concat('http://toscana.newtfire.org/img/meetingMinutes/', current()/pb/@n, '.png')"/>
                                <xsl:variable name="eng-page" as="element(tei:page)"
                                    select="$date//page[@lang eq 'eng' and pb/@n eq current()/pb/@n]"/>
                                <tr class="minutes">
                                    <td>
                                        <a href="{$image-link}">
                                            <img src="{$image-link}"/>
                                        </a>
                                    </td>
                                    <td>
                                        <xsl:apply-templates select="current()" mode="page-to-html"
                                        />
                                    </td>
                                    <td>
                                        <xsl:apply-templates select="$eng-page" mode="page-to-html"
                                        />
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    <!-- Templates to flatten original input, output is $flattened -->
    <xsl:template match="ab" mode="flatten">
        <xsl:copy-of select="ancestor::TEI//publicationStmt/date"/>
        <xsl:copy-of select="ancestor::TEI//titleStmt/title[not(empty(.))]"/>
        <xsl:apply-templates mode="flatten"/>
    </xsl:template>
    <xsl:template match="date" mode="flatten"/>
    <xsl:template match="*" mode="flatten">
        <xsl:element name="{name()}">
            <xsl:attribute name="tagType" select="'startTag'"/>
            <xsl:attribute name="tagId" select="generate-id()"/>
            <xsl:copy-of select="@*"/>
            <xsl:choose>
                <xsl:when test="self::pb[ancestor::div[@type = 'transcription']]">
                    <xsl:attribute name="lang">it</xsl:attribute>
                </xsl:when>
                <xsl:when test="self::pb[ancestor::div[@type = 'translation']]">
                    <xsl:attribute name="lang">eng</xsl:attribute>
                </xsl:when>
            </xsl:choose>
        </xsl:element>
        <xsl:apply-templates mode="flatten"/>
        <xsl:if test="not(self::lb | self::pb | self::date)">
            <xsl:element name="{name()}">
                <xsl:attribute name="tagType" select="'endTag'"/>
                <xsl:attribute name="tagId" select="generate-id()"/>
                <xsl:copy-of select="@*"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <!-- Templates to output groups by page -->
    <xsl:template match="node() | @*" mode="grouped">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="grouped"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="lb" mode="grouped">
        <xsl:element name="{name()}"/>
    </xsl:template>
    <xsl:template match="pb" mode="grouped">
        <pb>
            <xsl:apply-templates select="@* except (@tagType | @tagId)" mode="grouped"/>
        </pb>
    </xsl:template>
    <!-- Templates to move stupid dates -->
    <xsl:template match="page" mode="date">
        <xsl:copy>
            <xsl:attribute name="lang">
                <xsl:value-of select="child::pb/@lang"/>
            </xsl:attribute>
            <xsl:copy-of
                select="preceding-sibling::page[1]/(date | title)[not(following-sibling::*[not(self::date | self::title)])]"/>
            <xsl:apply-templates mode="date"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="del | unclear" mode="date">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="pb" mode="date">
        <xsl:copy>
            <xsl:copy-of select="@* except @lang"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="lb" mode="date">
        <lb/>
    </xsl:template>
    <xsl:template match="date | title" mode="date">
        <xsl:if test="following-sibling::*[not(self::title | self::date)]">
            <xsl:copy-of select="."/>
        </xsl:if>
    </xsl:template>
    <!-- End of templates to move dates and titles and create $date -->
    <!-- Templates to format Italian and English year/page output -->
    <xsl:template match="lb" mode="page-to-html" xmlns="http://www.w3.org/1999/xhtml">
        <br/>
    </xsl:template>
    <xsl:template match="title[not(empty(node()))]" mode="page-to-html"
        xmlns="http://www.w3.org/1999/xhtml">
        <h1 class="minute">
            <xsl:apply-templates mode="page-to-html"/>
        </h1>
    </xsl:template>
    <!-- End of templates to format Italian and English year/page output -->
</xsl:stylesheet>
