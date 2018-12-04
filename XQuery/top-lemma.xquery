declare default element namespace "http://www.tei-c.org/ns/1.0";

let $lemmas := //w/@lemma/string()
let $distinctLemmas := distinct-values($lemmas)
for $distinctLemma in $distinctLemmas
let $match := //w[@lemma/string() eq $distinctLemma]
let $matchCount := count($match)
order by $matchCount
where $matchCount gt 1
return string-join(($distinctLemma, ' appears ', $matchCount, ' times.', '&#10;'))