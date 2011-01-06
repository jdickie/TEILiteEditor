xquery version "1.0";

(: List of all Annotators in the  :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $title := 'All TEI Annotators for Tool bar'

let $config-file := concat($style:db-path-to-app, '/utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml')
let $annotators := doc($config-file)//Annotator

let $content := 
<div class="content">

Copy the following into the content area of your textarea after the <b>toolbar:</b> line.<br/><br/>
<div class="monofont" style="font-family: Courier;">
[[
  {
    for $annotator in $annotators
       let $id := string($annotator/@id)
       order by $id
       return  
          concat("'", string($annotator/@id), "', ")
  } 'Source'
]]
</div>
<br/>
These are the button definitions for the following annotation entities:
<br/><br/>
{
    string-join(
        for $annotator in $annotators
           let $id := string($annotator/@id)
           order by $id
           return  
              substring-before(substring-after($id, 'teiann'), 'Btn')
     , ', ')
  }

</div>

return 
    style:assemble-page($title, $content)
