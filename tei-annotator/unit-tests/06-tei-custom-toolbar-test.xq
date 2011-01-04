xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

(: Default function and element declarations :)
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace exfk="http://kuberam.ro/exsltforms";

let $title := 'TEI Toolbar Test'

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
           <xf:instance id="save-data" src="06-tei-custom-toolbar-test.xml"/>
       </xf:model>


    </head>
    <body>
       <h1>{$title}</h1>

       <p>Loading: <a href="06-tei-custom-toolbar-test.xml">06-tei-custom-toolbar-test.xml</a></p>
       
        
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
                        [
                           ['teiannBoldBtn', 'teiannItalicBtn'],
                           ['teiannDateBtn',  'teiannPersonBtn'],
                           ['Source' ]
                          ] 
        			    }}
        		    </exfk:rteOptions>
                </xf:extension>
        </xf:textarea>      
    </body>
</html>

let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/rest/db/dma/apps/tei-annotator/utils/xsltforms/xsltforms.xsl"'}
let $debug := processing-instruction xsltforms-options {'debug="yes"'}
return ($xslt-pi, $debug, $form)
