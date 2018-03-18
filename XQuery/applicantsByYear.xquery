declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $years as element(tei:TEI)+ := //tei:TEI;
<html>
    <head><title>Applicants by year</title></head>
    <body>
        <h1>Applicants by year</h1>{
            for $year in $years
            let $date as xs:string := $year//tei:publicationStmt/tei:date/@when/string()
            let $applicants as xs:string* := $year//tei:list[@type = "applicants"]/tei:item/tei:persName/@ref/string()
            return
                (<h2>{$date}</h2>,
                <ul>{
                        for $i in distinct-values($applicants)
                            order by $i
                        return
                            <li>{$i, ' : ', count(index-of($applicants, $i))}</li>
                    }</ul>)
        }</body></html>
