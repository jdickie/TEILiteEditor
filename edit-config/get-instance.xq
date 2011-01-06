xquery version "1.0";

(: Get XML Instance for TEI Annotator  :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $id := request:get-parameter('id', '')

let $config-file := concat($style:db-path-to-app, '/utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml')
let $annotator := doc($config-file)//Annotator[@id = $id]

return $annotator

