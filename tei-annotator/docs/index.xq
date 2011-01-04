xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $title := 'Documentation for the TEI Annotator'

let $documentation-collection := concat($style:db-path-to-app, '/docs')

let $document-descriptions := doc(concat($documentation-collection, '/document-descriptions.xml'))//document

let $content := 
<div class="content">
      
      <p>Welcome to the {$title}.</p>
      
      <b>The User Guide</b> A user guide for users that are setting up and configuring a web
      site for web-based TEI Annotation.
      <br/>
      
      <a href="user-guide/tei-annotator-user-guide.xhtml">HTML Version</a> 
      <a href="user-guide/tei-annotator-user-guide.pdf">PDF Version</a>
      <br/>
      <br/>
      <b>Other Documents</b>
      <table>
         <thead>
            <tr>
               <th>Document Name</th>
               <th>Description</th>
            </tr>
         </thead>
         <tbody>
      {
      for $child in xmldb:get-child-resources($documentation-collection)
         let $name := $document-descriptions[id/text() = $child]/name/text()
         let $description := $document-descriptions[id/text() = $child]/description/text()
         order by $child
         return
            if ($child = 'index.xq' or ends-with($child, '.xml')) then ()
            else
            <tr>
               <td><a href="{$child}">{$name}</a></td>
               <td>{$description}</td>
            </tr>
      }
      </tbody>
      </table>
</div>

return 
    style:assemble-page($title, $content)
