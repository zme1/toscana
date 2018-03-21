declare default element namespace "http://www.tei-c.org/ns/1.0";

let $members := //(persName | rs)/@ref/string()
let $distinctMembers := distinct-values($members)

for $i in $distinctMembers
let $matchProposer := //seg[@type='proposal']/descendant::persName[@role='proposer'][@ref = $i]
let $matchSupporter := //seg[@type='proposal']/descendant::persName[@role='supporter'][@ref = $i]
let $matchCommittee := //list[@type='committee']/descendant::item/persName[@ref = $i]
let $matchComp := //seg[@subtype='sick']/descendant::*[@role = 'target'][@ref = $i]
let $matchSum := count($matchProposer) + count($matchSupporter) + count($matchCommittee)


