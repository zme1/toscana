<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    <!-- This visualization will use a stacked bar graph to compare the relative activity among that year's administrators and general members.
    The graph will look at the names referenced in the minutes that are not nested within any sort of list (which does not direcltly imply
    presence at the meeting) or <seg> elements of @subtype value "sick", which explicates absence. Constraining the graph to only specific
    elements and their nested contents would miss a wealth of shorthand discussion in the minutes that is not directly marked up, and which
    may include more general member activity than the proposals would. -->
    
    <xsl:variable name="minutesColl" select="../../"/>
</xsl:stylesheet>