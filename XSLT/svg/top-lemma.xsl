<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:variable name="root" select="/"/>
    <xsl:template match="/">
        <div class="lemma-table">
            <table>
                <tbody class="lemma-table">
                    <tr>
                        <th>Year</th>
                        <th>Top Lemmas</th>
                    </tr>
                    <xsl:apply-templates select="/teiCorpus[teiCorpus]"/>
                    <xsl:apply-templates select="/teiCorpus/teiCorpus"/>
                </tbody>
            </table>
            <div class="lemma-text">
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam maximus ornare
                    tempus. Suspendisse potenti. Aliquam erat volutpat. Duis imperdiet sem vitae
                    porta eleifend. Praesent justo purus, cursus a auctor nec, commodo a lorem. Cras
                    non nisl at turpis venenatis sagittis. Nulla eleifend accumsan nulla eget
                    fermentum. Nullam ac nunc ante. Aenean ut odio nisi. Nam arcu ipsum, dapibus nec
                    maximus at, eleifend in justo. Praesent eget odio vitae sapien imperdiet
                    viverra. Nunc auctor scelerisque metus vitae condimentum. Vivamus pretium, diam
                    congue congue cursus, lacus nibh pellentesque augue, sed pellentesque nisi eros
                    ut mauris. Donec massa leo, dignissim eu dapibus rutrum, lobortis eget nisl.
                    Duis blandit pretium lorem, sit amet lacinia tellus sollicitudin id. Aenean
                    risus urna, ullamcorper tristique sollicitudin id, suscipit ut metus.</p>
                <p>Sed at scelerisque nibh, sed vulputate dui. Nullam ultricies pharetra turpis, id
                    sodales ex ultrices aliquet. Aliquam sit amet vestibulum nunc. Class aptent
                    taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
                    Ut ut neque bibendum, maximus metus ac, egestas diam. Quisque et dui ligula.
                    Integer nec nunc vitae justo gravida accumsan dignissim sed lectus. Suspendisse
                    ipsum mi, iaculis in nisl et, fermentum tristique mi. In facilisis massa
                    ullamcorper efficitur venenatis. Aenean feugiat dui ex, eu rutrum eros lobortis
                    vitae. Nunc sit amet volutpat leo. Quisque lectus nunc, egestas id turpis in,
                    convallis pretium urna. Praesent placerat lorem risus, nec accumsan ligula
                    dignissim eget.</p>
                <p>Vivamus congue, quam vitae ultricies suscipit, enim tellus volutpat justo, at
                    condimentum est mi ac arcu. Integer ultricies at massa nec porta. Phasellus eget
                    sapien aliquet, convallis mauris ut, tempus libero. Ut libero sapien, dapibus in
                    fringilla sed, ornare quis tellus. Mauris tristique sit amet nibh at tincidunt.
                    Vestibulum pretium, leo eu convallis rhoncus, arcu elit aliquam elit, sagittis
                    pretium tellus dui at eros. Donec tempor id arcu nec blandit. Curabitur
                    vehicula, diam sed hendrerit iaculis, dolor purus laoreet lacus, eget hendrerit
                    ante velit non tellus. Aenean venenatis est sapien, non tempus diam facilisis
                    eget. Vestibulum placerat fringilla lacus id vehicula. </p>
                <p>Fusce ultricies vehicula justo, id pretium massa imperdiet non. Proin consectetur
                    leo eu iaculis tincidunt. Sed sollicitudin diam justo, a ornare arcu hendrerit
                    ac. Nunc luctus metus et tempus ullamcorper. Aenean eget nunc eget enim
                    vestibulum fermentum. Integer sed arcu nulla. Nam viverra vehicula risus, id
                    cursus ante vehicula in. Aenean eget lacus et tortor porta mattis eu sed nibh.
                    Sed orci quam, sodales nec interdum id, vestibulum quis dui. Aliquam tristique
                    sagittis orci, nec finibus orci vulputate sed. Nullam id augue eget sem interdum
                    tincidunt dignissim eu nibh. Class aptent taciti sociosqu ad litora torquent per
                    conubia nostra, per inceptos himenaeos. Curabitur non ipsum at diam tempus
                    tincidunt sed vitae quam. In porta quam et purus ullamcorper hendrerit. </p>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="teiCorpus/teiCorpus">
        <xsl:variable name="year" as="xs:string" select="teiHeader/fileDesc/descendant::date/@when"/>
        <xsl:variable name="currentYear" select="current()"/>
        <xsl:variable name="lemmas" as="node()+"
            select="descendant::w[not(ancestor::foreign)]/@lemma"/>
        <xsl:variable name="distinctLemmas" as="xs:string+" select="distinct-values($lemmas)"/>
        <xsl:variable name="multiLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($currentYear//w[not(ancestor::foreign) and @lemma eq current()]) gt 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="singleLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($currentYear//w[not(ancestor::foreign) and @lemma eq current()]) eq 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:comment> All lemmas: <xsl:value-of select="$distinctLemmas"/></xsl:comment>
        <xsl:comment> Multi lemmas: <xsl:value-of select="$multiLemmas"/></xsl:comment>
        <xsl:comment> Single lemmas: <xsl:value-of select="$singleLemmas"/></xsl:comment>
        <tr>
            <td>
                <xsl:value-of select="$year"/>
            </td>
            <td>
                <ul>
                    <xsl:for-each select="$multiLemmas">
                        <xsl:variable name="currentLemma" select="current()"/>
                        <xsl:variable name="lemmaMatch"
                            select="$currentYear/descendant::w[@lemma eq $currentLemma]"/>
                        <xsl:variable name="matchCount" select="count($lemmaMatch)"/>
                        <xsl:if test="$matchCount gt 1">
                            <li>
                                <xsl:value-of select="concat($currentLemma, ': ', $matchCount)"/>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                    <li>
                        <xsl:value-of
                            select="concat('Number of words used once: ', count($singleLemmas))"/>
                    </li>
                </ul>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="teiCorpus[teiCorpus]">
        <xsl:variable name="corpus" select="current()"/>
        <xsl:variable name="lemmas" as="node()+" select="descendant::w[not(ancestor::foreign)]/@lemma"/>
        <xsl:variable name="distinctLemmas" as="xs:string+" select="distinct-values($lemmas)"/>   
        <xsl:variable name="multiLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($corpus//w[not(ancestor::foreign) and @lemma eq current()]) gt 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="singleLemmas" as="xs:string*">
            <xsl:for-each select="$distinctLemmas">
                <xsl:if
                    test="count($corpus//w[not(ancestor::foreign) and @lemma eq current()]) eq 1">
                    <xsl:value-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <tr>
            <td>All years</td>
            <td>
                <ul>
                    <xsl:for-each select="$multiLemmas">
                        <xsl:variable name="currentLemma" select="current()"/>
                        <xsl:variable name="lemmaMatch"
                            select="$corpus/descendant::w[@lemma eq $currentLemma]"/>
                        <xsl:variable name="matchCount" select="count($lemmaMatch)"/>
                        <xsl:if test="$matchCount gt 1">
                            <li>
                                <xsl:value-of select="concat($currentLemma, ': ', $matchCount)"/>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                    <li>
                        <xsl:value-of
                            select="concat('Number of words used once: ', count($singleLemmas))"/>
                    </li>
                </ul>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
