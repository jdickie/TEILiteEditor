xquery version "1.0";

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

(: Default function and element declarations :)
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace hist="http://history.state.gov/ns/1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

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

            .search .xforms-value {width: 90ex;}
            

        ]]>
     </style>


let $model :=
<xf:model>
    
    <xf:instance id="search-params" xmlns="">
       <data>
          <entity></entity>
          <q></q>
       </data>
    </xf:instance>
    
    <xf:instance id="results" xmlns="">
       <results/>
    </xf:instance>
    
    <xf:submission id="search-submission" ref="instance('search-params')" method="get"
       replace="instance" instance="results"
       action="get-entities.xq" separator="&amp;">
    </xf:submission>
    
    
</xf:model>

let $content :=
<div class="content">

        <xf:select1 ref="instance('search-params')/entity">
           <xf:label>Entity Type: </xf:label>
           <xf:item>
              <xf:label>Person</xf:label>
              <xf:value>people</xf:value>
           </xf:item>
           <xf:item>
              <xf:label>Geolocation</xf:label>
              <xf:value>places</xf:value>
           </xf:item>
           <xf:item>
              <xf:label>Glossary Term</xf:label>
              <xf:value>glossary</xf:value>
           </xf:item>
        </xf:select1>
         
         
         <xf:input ref="instance('search-params')/q">
           <xf:label> Query:</xf:label>
        </xf:input>
        
        <xf:submit submission="search-submission">
           <xf:label>Search</xf:label>
        </xf:submit>
        
        
        <br/>
        <br/>
        <xf:output value="count(instance('results')//item)"/> items found:<br/>
        <br/>
        <xf:repeat nodeset="instance('results')//item">
           <xf:output value="label"/>
        </xf:repeat>
       
</div>

return style:assemble-form((), $style, $model, $content)

