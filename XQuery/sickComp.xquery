xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";

<html>
<head>
<title>Lega Toscana Compensations</title>
</head>
<body>
<table>
<tr>
<th>Member</th>
<th>Compensation date(s)</th>
<th>Compensation amount(s)</th></tr>
{
let $targets := //tei:seg[@subtype='sick']/descendant::tei:persName[@role='target']/@ref
let $distinctTargets := distinct-values($targets)

for $distinctTarget in $distinctTargets
let $distinctTargetMatches := //tei:seg[@subtype='sick']/descendant::tei:persName[@role='target'][@ref = $distinctTarget]
for $distinctTargetMatch in $distinctTargetMatches
let $distinctTargetAmount := $distinctTargetMatch/(preceding-sibling::tei:num | following-sibling::tei:num)/@value/number()
let $distinctTargetMatchDate := $distinctTargetMatch/ancestor::tei:text/preceding-sibling::tei:teiHeader/descendant::tei:publicationStmt/tei:date/@when/string()
order by sum($distinctTargetAmount) descending
return <tr><td>{$distinctTarget}</td><td>{$distinctTargetMatchDate}</td><td>{$distinctTargetAmount}</td></tr>
}
</table></body></html>