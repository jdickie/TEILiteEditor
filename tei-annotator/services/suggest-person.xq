xquery version "1.0";

(: suggest a person based on a prefix :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $prefix := request:get-parameter('prefix', '')

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $start-time := util:system-time()
let $hits := doc(concat($data-collection, '/people.xml'))//person[starts-with(lastname/text(), $prefix)]
let $end-time := util:system-time()
return
<results>
     <entity>person</entity>
     <description>Case insenstive last name starts with query.</description>
     <duration>{$start-time - $end-time}</duration>
     <prefix>{$prefix}</prefix>
         <items>{
            for $hit in $hits
               let $label := concat($hit/lastname/text(), ', ', $hit/firstname/text())
               return 
                 <item>
                    <label>{$label}</label>
                    <value>{$hit/id/text()}</value>
                 </item>
         }
         </items>
</results>

