xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "modules/style.xqm";

let $title := 'TEI Annotator'

let $content := 
<div class="content">
      <p>Welcome to the {$title} demonstration application.
      
      The purpose of this application is to demonstrate the features and functions of the TEI
      annotator application and show how the TEI annotator edits real live TEI documents.</p>
      
      <h3><a href="docs/index.xq">Documentation</a></h3> Application features, Architecture, a User Guide, PPTs and other project-related documentation.
      
       <br/><br/>
      
      <h3>Annotators Configuration File Reports</h3>
      <a href="views/list-annotators.xq">List TEI Annotators</a> A Listing of TEI Annotators in the configuration file.<br/>
      <a href="views/toolbar-tags.xq">Toolbar Tags</a> A dynamic report listing of toolbar buttons for creating the toolbar.<br/>
      <a href="views/list-distinct-annotator-types.xq">Annotators by Type</a> A report listing annotators by type.<br/>
      
      <br/><br/>
      
      <h3>Unit Tests</h3>
      <a href="unit-tests/index.xq">Unit Tests</a> A listing of unit tests<br/>
      
      <br/><br/>
      <h3>Suggest Apps</h3>
      <a href="services/suggest-person.xq?prefix=Ab">Suggest people</a> Suggest people with a lastname that start with "Ab"<br/>
      
      <br/><br/>
      <h3>Admin</h3>
      <a href="admin/reindex.xq">Reindex</a> Reindex the data collection that contains sample people records.<br/>
      <a href="admin/config-file-checks.xq">Check Config Files</a> Runs some basic checks on configuration files..<br/>
</div>

return 
    style:assemble-page($title, $content)
