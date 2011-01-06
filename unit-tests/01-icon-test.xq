xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";
import module namespace tei-to-html = "http://danmccreary.com/tei-to-html" at "../modules/tei-to-html.xqm";

let $title := 'Test of CSS'

let $content :=
<div class="content">
   <link type="text/css" rel="stylesheet" href="../css/tei-entities.css"/>
    <p>Test of icons to be used at the end of entity links.
            <ol>
                <li><b>Person</b>
                    
                    <p>This is an example of a person annotation for  
                    <a href="../images/person.png">
                       <span class="persName" title="smith-john">
                            John Smith
                            <img src="../images/person.png" alt="Person"/>
                        </span>
                        </a>.  
                        
                        In view mode, all people entities
                        will link to a page about that person.  In annotation mode clicking on a list will open the annotation editor.  Here is another person: 
                        
                        <a href="view-person?id=carter-jimmy">
                            <span class="persName" title="carter-jimmy">Jimmy Carter</span>
                            <img src="../images/person.png" alt="Person"/>
                        </a>.  Note that if you hover over the item the person ID in the registry will appear.
                        
                        Note that if the ID is not in the person registry a red link like this: <a href="../images/person.png">
                            <span class="person-unknown" title="fred-jones">Fred Jones</span>
                            <img src="../images/person.png" alt="Person"/>
                        </a> can be used.
                    In the annotation mode this will allow the editor to add the person or change the ID to a correct entry.</p>
                </li>
                <li><b>Dates</b>
                    <p> This is an date entity. <a href="edit-date-control.xq?id=date">
                            <span class="date" title="2007-12-31">December 31st of 2007<img src="../images/calendar.png" alt="Date" />
                            </span>
                        </a> and it shows ho you can view the data by using a hover.  No link is used in the view mode but the annotation mode
                        can set the correct date and date precision or uncertainty.  (Check with Joe on this).</p>
                </li>
                <li><b>GeoLocations</b>
                    <p>The <a href="geolocation?id=united-states">
                            <span class="placeName" title="united-states">United States<img src="../images/geolocation.png" alt="Place"/>
                            </span>
                        </a> is located in <span class="placeName" title="north-america">North America<img src="../images/geolocation.png" alt="Place"/></span>.</p>
                        
                    <p> <a href="geolocation?soviet-union">
                            <span class="placeName" title="soviet-union">Russia<img src="../images/geolocation.png" alt="Place"/>
                            </span>
                        </a> is located in <span class="placeName" title="asia">Asia<img src="../images/geolocation.png" alt="Place"/></span>.</p>
                </li>
                <li><b>Links</b>
                    <p>If a document has an 
                        <a href="http://www.example.com">
                            <span class="link" title="http://www.example.com">
                               External Web Site
                               <img src="../images/link.png" alt="Link"/>
                            </span>
                        </a> you will note that the icon indicates this.</p>
                </li>
                <li><b>Terms</b>
                
                <p>If a document has a term
                
                
                
                   <a href="gloss-term.xq?id=us-dept-of-state">
                   <span class="gloss" title="us-dept-of-state">
                       US Department of State
                       <img src="../images/term.png" alt="Term" height="16px;"/>
                       </span>
                    </a>
                  the text will be dark purple (indigo) and the icon has a "T" for "Term".</p></li>
            </ol>
        </p>
</div>

return
    style:assemble-page($title, $content)