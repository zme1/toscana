xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $sickEvents as element(tei:seg)+ := //tei:seg[@subtype eq 'sick'];
declare function local:list($input) as item()+ {
    let $results := 
        for $item at $pos in $input
        return
            ($item,
            if ($pos lt count($input)) then
                <br/>
            else
                ())
    return
        $results
};
<html>
    <head>
        <title>Lega Toscana Compensations</title>
        <style>
            table, tr, td, th {{border: 1px black solid;border-collapse: collapse;}}
            td, td {{padding: 2px;}}
            td:last-child {{text-align: right;}}
        </style>
    </head>
    <body>
        <table>
            <tr>
                <th>Member</th>
                <th>Date</th>
                <th>Amount</th></tr>
            {
                for $sickEvent in $sickEvents
                let $name as xs:string := $sickEvent/tei:persName[@role eq 'target']/@ref/string()
                let $dates as xs:string := $sickEvent/ancestor::tei:TEI[1]/descendant::tei:publicationStmt/tei:date/@when/string()
                let $amounts as xs:string := $sickEvent/tei:num/@value/string()
                    group by $name
                    order by $name
                return
                    <tr>
                        <td>{$name}</td>
                        <td>{local:list($dates)}</td>
                        <td>{local:list($amounts)}</td>
                    </tr>
            }
        </table></body></html>