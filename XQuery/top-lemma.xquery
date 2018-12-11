declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

<html>
    <head>
        <title>Distinct Lemmas in the Corpus by Yer</title>
    </head>
    <body>
        <h1>Distinct Lemmas in the Corpus by Year</h1>
        <table>
            <tr>
                <th>Year</th>
                <th>Lemmas</th></tr>
            {
                let $corpus := /tei:teiCorpus
                let $years := $corpus/tei:teiCorpus
                for $year in $years
                let $yearDate := $year/tei:teiHeader/tei:fileDesc/descendant::tei:date/@when/string()
                let $lemmas := $year/descendant::tei:w[not(ancestor::tei:foreign)]/@lemma/string()
                let $distinctLemmas := distinct-values($lemmas)
                for $distinctLemma in $distinctLemmas
                let $match := $year/descendant::tei:w[@lemma/string() eq $distinctLemma]
                let $matchCount := count($match)
                let $yearMatchOnes := count($year//$match[$matchCount eq 1])
              return count($years)
              (: return
                    <tr>
                    <td>{$yearDate}</td>
                    <td>
                    <ul>
                    {for $distinctLemma in $distinctLemmas
                    return <li>{string-join(($distinctLemma, ': ', $matchCount))}</li>} 
                    </ul></td></tr> :)
                    
            }</table>
    </body>
</html>



