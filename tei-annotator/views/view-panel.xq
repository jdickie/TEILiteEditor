xquery version "1.0";

(: List of all Annotators in the  :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $title := 'View TEI Annotator Panel'

let $id := request:get-parameter('id', '')

let $config-file := concat($style:db-path-to-app, '/utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml')
let $annotator := doc($config-file)//Annotator[@id = $id]

return $annotator/AnnotatorPanel
