xquery version "1.0";

(: Delete Item Confirmation :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $id := request:get-parameter("id", "")
let $title := concat('Delete Confirmation for Annotator id=', $id)

let $config-file := concat($style:db-path-to-app, '/utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml')

let $content := 
    <div>
        <h1>Are you sure you want to delete this Annotator?</h1>
        <b>Item ID: </b>{$id}<br/>
        <b>Config Fle: </b> {$config-file}
        <br/><br/>
        <a class="warn" href="delete.xq?id={$id}">Yes - Delete This Annotator</a>
        <br/><br/><br/>
        <a class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View Items)</a>
        <br/><br/><br/>
    </div>
    
return 
    style:assemble-page($title, $content)