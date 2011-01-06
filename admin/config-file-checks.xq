xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Config File Checks'

let $content := 
<div class="content">
      <p>Welcome to the {$title} program.
      
      The purpose of this application is to demonstrate the configuration
      files that must be customized for the TEI annitator to work.</p>
      
      <h4>TEI Plugin Configuration</h4>
      <a href="../utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml">Annotator Specifications</a>
      
      
      
      
</div>

return 
    style:assemble-page($title, $content)
