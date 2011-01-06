xquery version "1.0";

declare option exist:serialize "method=xhtml media-type=application/xml indent=yes process-xsl-pi=no";

let $form :=
<html
   xmlns="http://www.w3.org/1999/xhtml" 
   xmlns:exfk="http://kuberam.ro/exsltforms" 
   xmlns:ev="http://www.w3.org/2001/xml-events" 
   xmlns:xf="http://www.w3.org/2002/xforms"
   eXSLTFormsDataInstancesViewer="true">
    <head>
	    <title>CKEditor rich text editor</title>
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
	<script type="text/javascript" src="http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js"/>
        <xf:model>
            <xf:instance id="save-data" xmlns="">
                <faq>
                    <id>1</id>
                    <question>Why is it called the Department of State?</question>
                    <answer>On September 15, 1789, Congress passed "An Act to provide for the safe keeping of the
Acts, Records, and Seal of the United States, and for other purposes." This law
changed the name of the Department of Foreign Affairs to the Department of State
because certain domestic duties were assigned to the agency. These included:&lt;/p&gt;
&lt;ul&gt;

&lt;li&gt;Receipt, publication, distribution, and preservation of the laws of the United
        States;&lt;/li&gt;
    &lt;li&gt;Preparation, sealing, and recording of the commissions of Presidential
        appointees;&lt;/li&gt;
    &lt;li&gt;Preparation and authentication of copies of records and authentication of copies
        under the Department's seal;&lt;/li&gt;
    &lt;li&gt;Custody of the Great Seal of the United States;&lt;/li&gt;

    &lt;li&gt;Custody of the records of the former Secretary of the Continental Congress,
        except for those of the Treasury and War Departments. &lt;/li&gt;
&lt;/ul&gt;
Other domestic duties that the Department was responsible for at various times
included issuance of patents on inventions, publication of the census returns,
management of the mint, control of copyrights, and regulation of immigration. Most
domestic functions have been transferred to other agencies. Those that remain in the
Department are: storage and use of the Great Seal, performance of protocol functions
for the White House, drafting of certain Presidential proclamations, and replies to
public inquiries.
			</answer>
                </faq>
            </xf:instance>
        </xf:model>

    </head>
    <body>
       <h1>FAQ Editor</h1>
       <xf:input ref="instance('save-data')/question" class="question">
           <xf:label>Question:</xf:label>
       </xf:input>
       <br/>
            <xf:textarea ref="instance('save-data')/answer" appearance="exfk:CKEditor" incremental="true"
            class="answer">
                <xf:label>Answer:</xf:label>
                <xf:extension>
                    <exfk:rteOptions>
                        {{
                        skin:'office2003'
                        ,width: 930
                        ,height: 300
                        }}
 		            </exfk:rteOptions>
 		        </xf:extension>
            </xf:textarea>
    </body>
</html>

let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/rest/db/dma/apps/tei-annotator/utils/xsltforms/xsltforms.xsl"'}
let $debug := processing-instruction xsltforms-options {'debug="yes"'}
return ($xslt-pi, $debug, $form)
