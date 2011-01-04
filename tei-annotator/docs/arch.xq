xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'TEI Annotator Architecture'

let $content := 
<div class="content">
   <h1>{$title}</h1>
   <p>This document describes some of the overall considerations when we selected
   the CKEditor plugin architecture for this project.</p>
   
   <h2>Project Goals</h2>
   <ol>
      <li>We wanted the project to be based on fully open source systems (LGPL or Apache style licenses) so that others
      could add these components to their TEI web sites without any additional costs.</li>
      <li>We wanted people with just XML knowledge to be able to setup and configure the system.</li>
      <li>We wanted to take a "declarative" approach to the configuration of the system.  We
      wanted our end users to describe WHAT they wanted in the functionality of the TEI annotator, but not
      the HOW it should be done.</li>
      <li>We did not want users to have to know how to program JavaScript to change the system functions.</li>
      <li>We wanted to allow users to extend XForms if they were already using XForms.</li>
   </ol>
   
   
   
   <h2>Design Options</h2>
   <p>In general we looked at some of the following options.</p>
   <ol>
      <li>Write a JavaScript editor by hand by scratch.</li>
      <li>Build a full XML editor that would run in all browsers.</li>
      <li>Extend XForms textarea to work with encoded data.</li>
      <li>Find an an existing web-based WYSIWYG editor.</li>
      <li>Find an an existing XForms plugin that does Rich Text Editing and customize it.</li>
   </ol>
   

   <h2>Other Requirements</h2>
   <p>We wanted to find an active open source community behind the work we do so that it would be supported by
   future versions of browsers.</p>
   <p>We wanted to be able to easily customize the user experience including what TEI tags were permitted in what context.  This includes
   things like what buttons on the toolbar are enabled.</p>
   <p>We wanted to make sure that the tools also allows keyboard shortcuts for all operations for experienced
   users doing heads-down data entry.  The tools bar was useful for beginners but using the mouse should
   be an option, not a requirement.</p>
   <p>We wanted to be able to write a "specification" file for each annotator and have this specification file
   be used as the configuration for the annotator.</p>
   
   <h2>XSLTForms Rich Text Editors</h2>
   <p> When we started to see the work that Claudius Teodorescu had done extending XSLTForms we were very encouraged.  The only missing piece
was how to encode the TEI into HTML and then how we could configure the system. Claudius's suggestion was to build an additional
add on to the CKEditor project.</p>
   
</div>

return 
    style:assemble-page($title, $content)
