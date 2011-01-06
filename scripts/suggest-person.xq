xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-file := concat($app-collection, '/scripts/people-test.xml')
return doc($data-file)/results

