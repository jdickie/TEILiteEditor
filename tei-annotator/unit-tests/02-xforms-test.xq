xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace exfk="http://kuberam.ro/exsltforms";

declare option exist:serialize "method=xhtml media-type=text/xml indent=no process-xsl-pi=no";
(: Default function and element declarations :)
let $title := 'XForms Test'

let $style :=
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

let $model :=
<xf:model>
    <xf:instance id="save-data" src="02-sample-instance.xml"/>
</xf:model>

let $content :=
<div class="content">
   <p>Loading: <a href="ckeditor-test-instance.xml">02-sample-instance.xml</a></p>
   <p>The following is an XForms textarea with "encoded" HTML.  You should see &lt;div&gt;, &lt;p&gt; and &lt;hi&gt;
   tags in the textarea below.</p>

    <xf:textarea ref="instance('save-data')//text" incremental="true">
       <xf:label>Textarea:</xf:label>
    </xf:textarea>
    <br/><br/>
   <p>To view what this looks like "on the wire" click on the
      <a href="ckeditor-test-instance.xml">02-sample-instance.xml</a> and do a "view source" in your browser.
   </p>
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

