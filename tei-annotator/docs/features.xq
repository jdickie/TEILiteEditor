xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'TEI Annotator Features'

let $content := 
<div class="content">
   <p>The TEI annotator is designed to run in any web browser and be easy to extend to add new annotations.  Here is
   a short list of features:</p>
   <ol>
     <li><b>Fully Open Source</b> Non-viral Open Source Apache 2.0 style license.  Can be used without any obligation
     to publish modified source code.</li>
     <li><b>Browser Based Editing</b> Allows anyone with a web browser to and or update TEI documents.</li>
     <li><b>Support for Mainstream Browsers</b>Runs on FireFox, Safari, Chrome, Opera and even Internet Explorer.</li>
     <li><b>Customizable by Non Programmers</b> Users can change the options by just editing a XNL configuration file.  This would
allow TEI authors to only have to enable the markup items that you want.</li>
     <li><b>Reusable Standard Components</b> We have defined several reusable component types for annotators.  These types include
      <ol>
           <li><b>Insertion</b> - inserts any new TEI element a the cursor insertion point.</li>
           <li><b>Insertion with Parameters</b> - inserts any new TEI element a the cursor insertion point and then prompts the user for parameters.</li>
           <li><b>Selection Wrappers</b> - wraps the selected text with a TEI element.</li>
           <li><b>Selection Wrappers with parameters</b> - wraps the selected text with a TEI element and prompts the user for parameters.</li>
           <li><b>Server-based identification services with REST interfaces</b> - allow dialog panels to send search
           queries to the server and returns search results.  User can see labels but seperate IDs are used as parameters.</li>
        </ol>
     </li>
     <li><b>Examples of TEI Standard Annotations.</b>  many standard TEI tags for bold, italic, underline, strike through, line break, page breaks etc.  You can see an list of the examples <a href="../views/list-annotators.xq">here</a></li>
     <li><b>Extensible</b> Allows organization to extend with in-line TEI annotations for people, geolocations and dates.</li>
     <li><b>Sample Annotation ID services</b> We have provided sample ID services for the following TEI entities:
        <ol>
           <li>People</li>
           <li>Geolocations</li>
           <li>Terms</li>
        </ol>
     </li>
     <li><b>Extensible annotation architecture</b> to allow others to extend the system without extensive knowledge of JavaScript.</li>
     <li><b>Supported</b> We would like to build a network of people that are trained in this architecture
     that can be available to support and maintain these tools.</li>
     <li><b>Integration with other TEI components</b> The system can be integrated with other TEI components such as the
     TEI to HTML conversion viewers as well as TEI schema validation and TEI search using eXist Lucene indexes.</li>
   </ol>
</div>

return 
    style:assemble-page($title, $content)
