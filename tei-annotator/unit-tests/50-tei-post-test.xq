xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Default function and element declarations :)
declare namespace html="http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace hist="http://history.state.gov/ns/1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace exfk="http://kuberam.ro/exsltforms";

let $file := request:get-parameter('file', '50-tei-post-test.xml')

let $title := '50-tei-post-test.xml'

let $style :=
    <html:style language="text/css">
        <![CDATA[
            @namespace xf url("http://www.w3.org/2002/xforms");
            .block-form xf|label {
                width: 15ex;
            }
            
        ]]>
     </html:style>


let $model :=
<xf:model>
    <xf:instance id="save-data" src="{$file}"/>
    
    <xf:submission id="save" method="post" action="../scripts/echo-post.xq" instance="save-data" replace="all"/>
</xf:model>

let $content :=
<div class="content">
   <p>Loading: <a href="">{$file}</a></p>


    <xf:textarea ref="instance('save-data')/text" appearance="exfk:CKEditor" incremental="true">
    <xf:label>TEI Document:</xf:label>
        <xf:extension>
                <exfk:rteOptions>
        		    {{
        		    skin:'office2003'
        		    ,width: 910
        		    ,height: 100
        		    ,extraPlugins : 'tei-ann'
        		    ,toolbar:
        			[
        				[ 'teiannBoldBtn', 'teiannItalicBtn', 
        				  'teiannPersonBtn', 'teiannGlossaryBtn', 'teiannGeoLocationBtn', 'teiannDateBtn', 'teiannHyperlinkBtn',
        				  'teiannLineBreakBtn', 'teiannPageBreakBtn',  'teiannRemoveEntityBtn', 
        				  'teiannParagraphBtn',
        				  'Source']
        			],
        			toolbarCanCollapse: false,
                     entities: false,
                     scayt_autoStartup : false,
                     disableNativeSpellChecker:true
        		    }}
        	    </exfk:rteOptions>
            </xf:extension>
    </xf:textarea>
    
    <xf:submit submission="save">
       <xf:label>Send HTTP POST with data to server.</xf:label>
    </xf:submit>

</div>

let $form :=
<html>
  <head>
     <title>{$title}</title>
  {$model}
  {$style}
  </head>
  <body>
    <h1>{$title}</h1>
    {$content}
  </body>
</html>

let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/rest/db/dma/apps/tei-annotator/utils/xsltforms/xsltforms.xsl"'}
let $debug := processing-instruction xsltforms-options {'debug="yes"'}
return ($xslt-pi, $debug, $form)

