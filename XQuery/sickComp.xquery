xquery version "3.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option method "xml";
declare option omit-declaration-namespace "yes";
declare option indent "yes";

<html>
<head>
<title>Test table</title></head><body><div>
<table>
<tr>
<th>Member</th>
<th>Date(s) of Compensation</th>
<th>Amount(s) of Compensation</th>
</tr>
{
let $targets := //tei:seg[@subtype='sick']/descendant::tei:persName[@role='target']/@ref
let $distinctTargets := distinct-values($targets)

for $distinctTarget in $distinctTargets
let $distinctTargetMatches := //tei:seg[@subtype='sick']/descendant::tei:persName[@role='target'][@ref = $distinctTarget]
for $distinctTargetMatch in $distinctTargetMatches
let $distinctTargetMatchPres := 
let $distinctTargetAmount := $distinctTargetMatch/(preceding-sibling::tei:num | following-sibling::tei:num)/@value/number()
let $distinctTargetMatchDate := $distinctTargetMatch/ancestor::tei:text/preceding-sibling::tei:teiHeader/descendant::tei:publicationStmt/tei:date/@when/string()
order by sum($distinctTargetAmount) descending
return <tr><td>{$distinctTarget}</td><td>{$distinctTargetMatchDate}</td><td>${$distinctTargetAmount}</td></tr>}</table>
</div>
</body>
</html>




(: let $targets := //seg[@subtype='sick']/descendant::persName[@role='target']/@ref
let $distinctTargets := distinct-values($targets)

for $distinctTarget in $distinctTargets
let $distinctTargetMatch := //seg[@subtype='sick']/descendant::persName[@role-'target'[@ref = $distinctTarget]
return :) 