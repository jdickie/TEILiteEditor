xquery version "1.0";

(: Get Entities :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

(: if no entity then assume people for testing :)
let $entity := request:get-parameter('entity', 'people')
let $q := request:get-parameter('q', '')

(: The default is a contains search.  You can also add the parameter type = 'prefix' to get a prefix search. :)
let $type := request:get-parameter('type', 'contains')


return
    if ($q eq '') then 
        <error>
            <message>Parameter "q" is missing.  This argument is required for this web service.</message>
        </error>
    else
    let $data-collection := doc(concat($style:db-path-to-app, '/code-tables/', $entity, '.xml'))
    
    let $hits :=
       if ($type = 'prefix')
          then $data-collection//item[starts-with(lower-case(label), $q)]
          (: for anything other than prefix we do a contains :)
          else $data-collection//item[contains(lower-case(label), $q)]

return
<results>
   <entity>{$entity}</entity>
   <type>{$type}</type>
   <q>{$q}</q>
   <items>{
    for $hit in $hits
    let $label := $hit/label/text()
    order by $label
    return 
        $hit
    }
    </items>
</results>