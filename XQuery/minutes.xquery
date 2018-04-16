declare default element namespace "http://www.w3.org";
declare namespace html = "http://www.w3.org/1999/xhtml";
let $year := //html:body
let $meetings := $year/html:section
for $meeting in $meetings
let $img := $meeting/html:div[@class='manuscript']
let $transcription := $meeting/div[@class='transcription']
let $translation := $meeting/div[@class='translation']
return $meetings