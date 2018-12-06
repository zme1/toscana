declare default element namespace "http://www.tei-c.org/ns/1.0";

let $corpus := /teiCorpus
let $years := $corpus/teiCorpus
for $year in $years
let $yearDate := $year/teiHeader/fileDesc/descendant::date/@when/string()
let $lemmas := $year/descendant::w[not(ancestor::foreign)]/@lemma/string()
let $distinctLemmas := distinct-values($lemmas)
for $distinctLemma in $distinctLemmas
let $match := $year/descendant::w[@lemma/string() eq $distinctLemma]
let $matchCount := count($match)
where $matchCount gt 1
return string-join(($yearDate, ': ', concat($distinctLemma, '(', $matchCount, ')'), ' &#10; '))






