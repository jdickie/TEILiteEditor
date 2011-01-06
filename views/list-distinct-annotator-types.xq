xquery version "1.0";

(: List of all Annotators in the  :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $title := 'List Distinct TEI Annotators Types in Configuration File'

let $config-file := concat($style:db-path-to-app, '/utils/ckeditor/plugins/tei-ann/config/Annotator-Specifications.xml')
let $annotators := doc($config-file)//Annotator
let $distinct-annotator-types := distinct-values($annotators/@typeCode)

let $content := 
<div class="content">
      <style type="text/css"><![CDATA[
         thead tr {color: blue; background-color: lightblue;}
         td {padding: 5px;}
      ]]></style>
      Distinct Count = {count($distinct-annotator-types)}
      <table class="span-21 last">
         <thead>
            <tr>
               <th class="span-5">Type</th>
               <th class="span-1">Count</th>
               <th class="span-15 last">Report</th>
            </tr>
         </thead>
         <tbody>
      {
      for $annotator-type in $distinct-annotator-types
         let $annotators-with-this-type := $annotators[@typeCode = $annotator-type]
         order by $annotator-type
         return  
            <tr>
            
               <td><a 
                     href="list-annotators.xq?filter=true&amp;type={$annotator-type}">{$annotator-type}</a>
               </td>

               <td>{count($annotators-with-this-type)}</td>
               <td>
               { 
                  for $ann in $annotators-with-this-type/@id
                     return
                        <a href="view-annotator.xq?id={$ann}">
                           {substring-before(substring-after($ann, 'teiann'), 'Btn')}
                        </a>

                  }
                  </td>

            </tr>
      }
      </tbody>
      </table>
</div>

return 
    style:assemble-page($title, $content)
