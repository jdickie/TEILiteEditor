xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: grab this list of sample people in US government for the demo from here: http://www.govtrack.us/data/us/people.xml :)
let $sequence-of-people := doc(concat($style:db-path-to-app, '/import-data/people.xml'))//person

let $people :=
<people>{
   for $person in $sequence-of-people
   return
   <person>
      <id>{string($person/@id)}</id>
      <lastname>{string($person/@lastname)}</lastname>
      <firstname>{string($person/@firstname)}</firstname>
   </person>
}</people>

let $login := xmldb:login($style:db-path-to-app-data, 'admin', 'admin123')
let $store := xmldb:store($style:db-path-to-app-data, 'people.xml', $people)

return
<results>
   <message>{count($people//person)} records stored in {$style:db-path-to-app-data}/people.xml</message>
</results>
