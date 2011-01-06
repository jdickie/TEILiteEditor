xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Default function and element declarations :)
declare namespace html="http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace exfk="http://kuberam.ro/exsltforms";

let $title := 'TEI Small Toolbar Test'
let $file := request:get-parameter('file', '07-tei-complex-content-test.xml')

let $style :=
    <html:style language="text/css">
        <![CDATA[
            @namespace xf url("http://www.w3.org/2002/xforms");
            .block-form xf|label {
                width: 15ex;
            } 
        ]]>
     </html:style>


let $form :=
<html eXSLTFormsDataInstancesViewer="true"
   xmlns="http://www.w3.org/1999/xhtml" 
   xmlns:exfk="http://kuberam.ro/exsltforms" 
   xmlns:ev="http://www.w3.org/2001/xml-events" 
   xmlns:xf="http://www.w3.org/2002/xforms"
    >
    <head>
	    <title>{$title}</title>
	    <style language="text/css">
		    <![CDATA[
			     @namespace xf url("http://www.w3.org/2002/xforms");
			     body {font-family: Helvetica, Arial, sans-serif; padding: 10px; font-size: 14px;}
			     .question .xforms-value {width: 100ex; font-size: 14px;}
			     textarea {height: 10ex; width: 100ex; font-family: Helvetica, Arial, sans-serif; font-size: 14px;}
			     xf|label {
			         font-weight: bold; display: inline-block;
			         width: 10ex;
			         vertical-align: top;
			         text-align: right; 
			         padding-right: 5px;
			         }
			     ]]>
   	    </style>
       
       <xf:model>
           <xf:instance id="save-data" src="{$file}"/>
       </xf:model>


    </head>
    <body>
       <h1>{$title}</h1>

       <p>Loading: <a href="{$file}">{$file}</a></p>
       
        <xf:input ref="instance('save-data')/question">
            <xf:label>Questions:</xf:label>
        </xf:input>
        <br/>
        
        <xf:textarea ref="instance('save-data')/text" appearance="exfk:CKEditor" incremental="true">
            <xf:label>TEI Document:</xf:label>
            <xf:extension>
                    <exfk:rteOptions>
        			    {{
        			    skin:'office2003',
        			    width: 910,
        			    height: 300,
        			    extraPlugins : 'tei-ann',
                        toolbar:
[[ 'teiannBoldBtn', 'teiannCellBtn', 'teiannDateBtn', 'teiannEditEntityBtn', 'teiannGeoLocationBtn', 'teiannGlossaryBtn', 'teiannHeadBtn', 'teiannHyperlinkBtn', 'teiannItalicBtn', 'teiannItemBtn', 'teiannLineBreakBtn', 'teiannListBtn', 'teiannPageBreakBtn', 'teiannParagraphBtn', 'teiannPersonBtn', 'teiannRemoveEntityBtn', 'teiannRoleBtn', 'teiannStrikethroughBtn', 'teiannTableBtn', 'teiannUnderlineBtn', 'Source' ]],
        			toolbarCanCollapse: false,
                     entities: false,
                     scayt_autoStartup : false,
                     disableNativeSpellChecker:true
        			    }}
        		    </exfk:rteOptions>
                </xf:extension>
        </xf:textarea>      
    </body>
</html>


    
let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/rest/db/dma/apps/tei-annotator/utils/xsltforms/xsltforms.xsl"'}
let $debug := processing-instruction xsltforms-options {'debug="yes"'}
return ($xslt-pi, $debug, $form)

