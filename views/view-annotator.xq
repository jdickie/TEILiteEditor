xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title := concat('View Annotator ', $id)

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
    
let $config-file := concat($style:db-path-to-app, '/utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml')

(: this Annotator :)
let $ann := doc($config-file)//Annotator[@id = $id]

let $content :=
<div class="content">
 <table class="span-24">
    <thead>
       <tr>
          <th class="span-2">Field</th>
          <th class="span-22 last">Value</th>
       </tr>
    </thead>
    <tbody>
     <tr><th class="field-label">ID:</th><td>{$id}</td></tr>
     <tr><th class="field-label">Label:</th><td>{substring-before(substring-after($id, 'teiann'), 'Btn')}</td></tr>
     <tr><th class="field-label">Name:</th><td>{string($ann/@name)}</td></tr>
     <tr><th class="field-label">Type:</th><td>{string($ann/@typeCode)}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$ann/AnnotatorDescriptionText/text()}</td></tr>
     <tr><th class="field-label">Possible Parent Elements:</th><td>{$ann/AnnotatorPossibleParentElementNames/text()}</td></tr>
     <tr><th class="field-label">Possible Sibling Elements:</th><td>{$ann/AnnotatorPossiblePrecedingSiblingElementNames/text()}</td></tr>
     
     <tr><th class="field-label" colspan="2" style="text-align: center">Attributes</th></tr>
     <tr><th class="field-label">AnnotatorAttribute:</th><td>{$ann/AnnotatorAttribute/text()}</td></tr>
     <tr><th class="field-label">Name:</th><td>{string($ann/AnnotatorAttribute[1]/@name)}</td></tr>
     <tr><th class="field-label">Value:</th><td>{string($ann/AnnotatorAttribute[1]/@value)}</td></tr>
     
     <tr><th class="field-label" colspan="2" style="text-align: center">Panels</th></tr>
     <tr><th class="field-label">Panel Min Width:</th><td>{$ann/AnnotatorPanel[1]/AnnotatorPanelMinWidth}</td></tr>
     <tr><th class="field-label">Panel Min Height:</th><td>{$ann/AnnotatorPanel[1]/AnnotatorPanelMinHeight}</td></tr>
     <tr><th class="field-label">Panel ID:</th><td>{string($ann/AnnotatorPanel[1]/AnnotatorPanelTab[1]/@id)}</td></tr>
     
     <tr><th class="field-label" colspan="2" style="text-align: center">Panel Fields</th></tr>
     <tr><th class="field-label">Panel ID:</th><td>{string($ann/AnnotatorPanel[1]/AnnotatorPanelTab[1]/AnnotatorPanelField[1]/@id)}</td></tr>
     <tr><th class="field-label">Ref:</th><td>{string($ann/AnnotatorPanel[1]/AnnotatorPanelTab[1]/AnnotatorPanelField[1]/AnnotatorPanelFieldRef)}</td></tr>
     <tr><th class="field-label">Regex:</th><td>{string($ann/AnnotatorPanel[1]/AnnotatorPanelTab[1]/AnnotatorPanelField[1]/AnnotatorPanelFieldValidationRegex)}</td></tr>
     <tr><th class="field-label">HTML:</th><td>{string($ann/AnnotatorPanel[1]/AnnotatorPanelTab[1]/AnnotatorPanelTabHtmlContent)}</td></tr>
     </tbody>
  </table>

   <div class="edit-controls">
      <a href="../edit-config/edit.xq?id={$id}">Edit Annotator</a>
      <a href="../edit-config/delete-confirm.xq?id={$id}">Delete Annotator</a>
   </div>
</div>

return style:assemble-page($title, $content)