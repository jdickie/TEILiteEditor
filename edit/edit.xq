xquery version "1.0";

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";
import module namespace ckedit = "http://ckedit.syntactica.com" at "../../../modules/ckedit.xqm";

(: Default function and element declarations :)
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace hist="http://history.state.gov/ns/1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace exfk="http://kuberam.ro/exsltforms";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $pid := request:get-parameter('pid', '')

return
(: check for required parameters new or $id and a $pid :)
    if ( not($new) and not($id) ) then 
        <error>
            <message>One of "new" or  ("id" and "pid) is missing.  One of these two arguments is required for form.</message>
        </error>
    else

let $app-collection := $style:db-path-to-app

let $style :=
    <style language="text/css">
        <![CDATA[
            @namespace xf url("http://www.w3.org/2002/xforms");
            .block-form xf|label {
                width: 15ex;
            }
            
            /* make sure the select and select1 items don't float to the left */
            xf|select xf|item, xf|select1 xf|item {
                margin-left: 16ex;
            }

            .uri .xforms-value {width: 90ex;}
            .url .xforms-value {width: 70ex;}
            
            .tei-annotator textarea {
                height: 40ex;
                width:900px;
            }
            
            .annotation-panel {
               font-family: Arial, Helvetica, sans-serif;
               color: black;
               position: fixed;
               top: 0;
               margin-left:auto;
               margin-right: auto;
               width: 500px;
               height:310px; border:3px solid #1c5180; background:#ddd;
               margin-top:200px;
               padding: 10px;
            }
            
            .scrolling-list
            {
                width:500px;
                height:250px;
                /* automatically turn on only the vertical scroll if the number of items is more than the size of the model panel */
                overflow-y: auto;
                background: white;
                color: black;
            }

        ]]>
     </style>


let $model :=
<xf:model>
    <xf:instance id="save-data" src="get-instance?id={$id}&amp;pid={$pid}" xmlns="http://www.tei-c.org/ns/1.0"/>
    
    <!-- used to simulate the selected text item -->
    <xf:instance id="tmp" xmlns="">
       <data>
          <selected-text>John</selected-text>
          <sample-date>1970-06-15</sample-date>
          <sample-url>http://www.example.com</sample-url>
       </data>
    </xf:instance>
    
    <xf:instance id="search-params" xmlns="">
       <data>
          <entity>people</entity>
          <q>e</q>
       </data>
    </xf:instance>
    
    <xf:instance id="search-results" xmlns="">
       <data/>
    </xf:instance>

    <xf:bind nodeset="instance('tmp')/sample-date" type="xf:date"/>
    
    <xf:submission id="search-submission" ref="instance('search-params')" method="get"
       action="get-entities.xq"
       replace="instance" instance="search-results" separator="&amp;"/>

    
    <xf:submission id="save" ref="instance('save-data')"  method="POST" action="update.xq"/>
    
</xf:model>

let $content :=
<div class="content">
<p>Loading: <a href="get-instance?id={$id}&amp;pid={$pid}">get-instance?id={$id}&amp;pid={$pid}</a></p>
         

        <xf:textarea ref="instance('save-data')//tei:doc" appearance="exfk:CKEditor" incremental="true">
            <xf:extension>
                    <exfk:rteOptions>
			    {{
			    skin:'office2003'
			    ,width: 910
			    ,height: 300
			    ,extraPlugins : 'tei-ann'
			    ,toolbar:
				[
					[ 'Source', 'teiannBoldBtn', 'teiannItalicBtn', 
					  'teiannPersonBtn', 'teiannGlossaryBtn', 'teiannGeoLocationBtn', 'teiannDateBtn', 'teiannHyperlinkBtn',
					  'teiannLineBreakBtn', 'teiannPageBreakBtn',  'teiannRemoveEntityBtn']
				]
			    }}
		    </exfk:rteOptions>
                </xf:extension>
        </xf:textarea>
        
        <!-- the purpose of this is to simulate the panels and the user actions after an annotator has been selected -->
        <xf:switch>
         
            <xf:case id="default-case" selected="true">
            </xf:case>

            <xf:case id="person-case">
               <div class="annotation-panel">
                <span>Select Person ID:</span>
                   <div class="scrolling-list"> 
                      <xf:repeat nodeset="instance('search-results')//items/item">
                        <xf:trigger>
                             <xf:label><xf:output value="label"/></xf:label>
                             <xf:toggle case="default-case" ev:event="DOMActivate" />
                        </xf:trigger>
                      </xf:repeat>
                   </div>
                   <br/>
                   <xf:trigger class="modal-cancel">
                      <xf:label>Cancel</xf:label>
                      <xf:toggle case="default-case" ev:event="DOMActivate" />
                   </xf:trigger>
               </div>
            </xf:case>
            
            <xf:case id="date-case">
               
               <div class="annotation-panel">
                <span>Select a Date:</span><br/>
                   <xf:input ref="instance('tmp')/sample-date">
                        <xf:label>Enter (Verify) Date:</xf:label>
                   </xf:input>
                   <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                     <xf:trigger>
                          <xf:label>Cancel</xf:label>
                           <xf:toggle case="default-case" ev:event="DOMActivate" />
                     </xf:trigger>
               </div>
            </xf:case>
            
            <xf:case id="glossary-case">
               <div class="annotation-panel">
                <span>Select Glossary Term ID:</span>
                   <div class="scrolling-list">
                      <xf:repeat nodeset="instance('search-results')//items/item">
                        <xf:trigger>
                             <xf:label><xf:output value="label"/></xf:label>
                             <xf:toggle case="default-case" ev:event="DOMActivate" />
                        </xf:trigger>
                      </xf:repeat>
                   </div>
                    <br/>
                   <xf:trigger class="modal-cancel">
                      <xf:label>Cancel</xf:label>
                      <xf:toggle case="default-case" ev:event="DOMActivate" />
                   </xf:trigger>
               </div>
            </xf:case>
            
            <xf:case id="geolocation-case">
               <div class="annotation-panel">
                <span>Select Location:</span>
                   <div class="scrolling-list">
                      <xf:repeat nodeset="instance('search-results')//items/item">
                           <xf:trigger>
                              <xf:label><xf:output value="label"/></xf:label>
                              <xf:toggle case="default-case" ev:event="DOMActivate" />
                           </xf:trigger>
                      </xf:repeat>
                   </div>
                    <br/>
                   <xf:trigger class="modal-cancel">
                      <xf:label>Cancel</xf:label>
                      <xf:toggle case="default-case" ev:event="DOMActivate" />
                   </xf:trigger>
               </div>
            </xf:case>
            
            <xf:case id="link-case">
               <span>Select a Link:</span>
               <div class="annotation-panel">
               
                   <xf:input ref="instance('tmp')/sample-url" class="url">
                        <xf:label>Enter URL:</xf:label>
                   </xf:input>
                   <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                     <xf:trigger>
                          <xf:label>Cancel</xf:label>
                           <xf:toggle case="default-case" ev:event="DOMActivate" />
                     </xf:trigger>
               </div>
            </xf:case>
            
            <xf:case id="bold-case">
               <span>Adding bold tag around selected text...:</span>
            </xf:case>
            
            <xf:case id="italic-case">
               <span>Adding italic tag around selected text...</span>
            </xf:case>
            
            <xf:case id="link-case">
               <p>Adding link tag to the document...</p>
            </xf:case>
            
            <xf:case id="list-case">
               <p>Adding list with header to the document...</p>
            </xf:case>
            
         </xf:switch>
         
         
        
        <xf:submit submission="save">
           <xf:label>Save</xf:label>
        </xf:submit>
        
        <br/>
        <br/>
        <h4>Debug Area:</h4>
        
        <xf:submit submission="search-submission">
           <xf:label>Simulate Search Results</xf:label>
        </xf:submit>
        
        <br/>
        <xf:output value="count(instance('search-results')//item)"/> items in result set.<br/>
        <br/>
        Entity Type (people, glossary, place) : <xf:output value="instance('search-params')/entity"/><br/>
        <br/>
        <xf:repeat nodeset="instance('search-results')//item">
           <xf:output value="label"/>
        </xf:repeat>
          
</div>

    
return  style:assemble-ck-form((), style:title(), style:breadcrumbs() 
                                     ,$style , 
                                     $model, $content, 
                                     true())

