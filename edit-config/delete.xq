xquery version "1.0";

(: Delete Item :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $id := request:get-parameter("id", "")
let $title := concat('Delete Demo for Annotator id=', $id)

let $config-file := concat($style:db-path-to-app, '/utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml')
let $ann := doc($config-file)//Annotator[@id = $id]

(: this script takes the integer value of the id parameter passed via get :)
let $id := request:get-parameter('id', '')

(: this logs you into the collection 
let $login := xmldb:login($data-collection, 'admin', '')
:)

(: this constructs the filename from the id :)
let $file := concat($id, '.xml')

(: this deletes the file 
let $remove := update delete $ann
:)

let $content := <p>If this was a production system then annotator id="{$id}" would have been removed from the configuration.</p>

return 
    style:assemble-page($title, $content)