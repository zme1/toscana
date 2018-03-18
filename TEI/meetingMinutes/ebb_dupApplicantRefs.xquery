declare default element namespace "http://www.tei-c.org/ns/1.0";

let $applicants := //list[@type="applicants"]/item/persName/@ref/string()
let $dvApps := distinct-values($applicants)
for $i in $dvApps 
let $match := //list[@type="applicants"]/item/persName[@ref = $i]
where count($match) gt 1
return 
($i, "appears repeatedly here:", string-join($match/ancestor::TEI//date/@when/string(), ', '),  ". &#10;")
