xquery version "1.0";

(: View Item :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";
import module namespace ckedit = "http://ckedit.syntactica.com" at "../../../modules/ckedit.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $id := request:get-parameter('id', '')

(: the paragraph ID, that is the 1st, 2nd, 3rd nth paragraph in the text. :)
let $pid := xs:integer(request:get-parameter('pid', ''))

(: check for required parameters :)
return

if (not($id and $pid)) then 
    <error>
        <message>Parameters "id" or "pid" (paragraph ID) is missing.  This argument is required for this web service.</message>
    </error>
else
    let $data-collection := $style:db-path-to-app-data
    let $doc-path := concat($data-collection, '/', $id)
    let $sequence-of-body-paras := doc($doc-path)//tei:body//tei:p
    return
    <tei:div xmlns:tei="http://www.tei-c.org/ns/1.0">
       <id>{$id}</id>
       <tei:pid>{$pid}</tei:pid>
       <tei:doc>{ $sequence-of-body-paras[$pid]} </tei:doc>
    </tei:div>