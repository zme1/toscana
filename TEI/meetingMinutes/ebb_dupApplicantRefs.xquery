declare default element namespace "http://www.tei-c.org/ns/1.0";

let $applicants := //list[@type="applicants"]//persName/@ref/string()
let $dvApps := distinct-values($applicants)
for $i in $dvApps 
let $match := //list[@type="applicants"]//persName[@ref = $i]
where count($match) gt 1
return 
($i, $match/ancestor::TEI//date/@when/string(),  "&#10;")
