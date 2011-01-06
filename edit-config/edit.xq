xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')

return
(: check for required parameters :)
    if (not($new or $id)) then 
        <error>
            <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
        </error>
    else

(: proceed :)

let $title := concat('Edit Annotator id=', $id)
let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('get-instance.xq?id=', $id)

let $cancel :=
   if ($new)
      then '../'
      else  concat('../views/view-item.xq?id=', $id)

let $style :=
<xhtml:style language="text/css">
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
        .description textarea {
            height: 10ex;
            width:630px;
        }
        .note textarea {
            height: 10ex;
            width:630px;
        }
    ]]>
 </xhtml:style>

let $model :=
    <xf:model>
        <xf:instance id="save-data" src="{$file}"/>
        
        <xf:instance id="code-tables" src="all-codes.xq" xmlns=""/>
        
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" 
            instance="save-data" replace="all"/>
            
    </xf:model>
        
let $content :=
    <div class="content">
    
        <xf:submit submission="save">
           <xf:label>Save</xf:label>
        </xf:submit>
       
        <div class="block-form">
    
            <xf:input ref="@id" class="id">
               <xf:label>ID:</xf:label>
               <xf:hint>This must be a globally distinct for all CKEditor controls.  Use the teiann prefix and the Btn suffix.</xf:hint>
            </xf:input>

            <xf:input ref="@name">
                <xf:label>TEI Element:</xf:label>
                <xf:hint>TEI Element Name</xf:hint>
            </xf:input>
           
            <xf:textarea ref="AnnotatorDescriptionText" class="description">
                <xf:label>Description:</xf:label>
            </xf:textarea>
           
            <xf:select1 ref="@typeCode" appearance="full">
                <xf:label>Type:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/code-table[name='annotator-type-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>
           
           <xf:input ref="AnnotatorPossibleParentElementNames">
                <xf:label>Parent Names:</xf:label>
            </xf:input>
            
            <xf:input ref="AnnotatorPossiblePrecedingSiblingElementNames">
                <xf:label>Siblings Names:</xf:label>
            </xf:input>
            
            <fieldset>
               <legend>Attribute</legend>
               <xf:input ref="AnnotatorAttribute">
                  <xf:label>Attribute:</xf:label>
               </xf:input>
               <xf:input ref="AnnotatorAttribute/@name">
                  <xf:label>Name:</xf:label>
                  <xf:hint>The name of the attribute that will be populated by the editor.</xf:hint>
               </xf:input>
               <xf:input ref="AnnotatorAttribute/@value">
                  <xf:label>Value:</xf:label>
                  <xf:hint>The value that will be populated by the panel.</xf:hint>
               </xf:input>
            </fieldset>
            
            <fieldset>
               <legend>Dialog Panel</legend>
               <xf:input ref="AnnotatorPanel[1]/AnnotatorPanelMinWidth">
                  <xf:label>Min Width:</xf:label>
               </xf:input>
               <xf:input ref="AnnotatorPanel[1]/AnnotatorPanelMinHeight">
                  <xf:label>Min Height:</xf:label>
               </xf:input>
               
               <fieldset>
                     <legend>Tab 1</legend>
                     <xf:input ref="AnnotatorPanel[1]/AnnotatorPanelTab/@id">
                        <xf:label>Tab ID:</xf:label>
                     </xf:input>
                     <xf:input ref="AnnotatorPanel[1]/AnnotatorPanelTab/AnnotatorPanelField/@id">
                        <xf:label>Field ID:</xf:label>
                     </xf:input>
                     <xf:input ref="AnnotatorPanel[1]/AnnotatorPanelTab/AnnotatorPanelField/AnnotatorPanelFieldRef">
                        <xf:label>Field ID Ref:</xf:label>
                     </xf:input>
                     <xf:input ref="AnnotatorPanel[1]/AnnotatorPanelTab/AnnotatorPanelField/AnnotatorPanelFieldValidationRegex">
                        <xf:label>Regular Expression:</xf:label>
                     </xf:input>
                     <xf:textarea ref="AnnotatorPanel[1]/AnnotatorPanelTab/AnnotatorPanelTabHtmlContent">
                        <xf:label>HTML:</xf:label>
                     </xf:textarea>

                </fieldset>
                <xf:trigger>
                   <xf:label>Add Tab 2</xf:label>
                   <xf:message ev:event="DOMActivate">Sorry, Tab 2 has not been implemented yet.</xf:message>
                </xf:trigger>
            </fieldset>
            
            <xf:input ref="AnnotatorIconName">
                <xf:label>Icon File Name:</xf:label>
            </xf:input>
           
       
        </div> <!-- end of block form layout -->
       
      <br/>
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
           <xf:message ev:event="DOMActivate">Sorry, Save has been disabled for this role.</xf:message>
       </xf:submit>
       
              


            <a href="{$file}"><img src="{$style:web-path-to-site}/resources/images/xml.png" alt="View XML" height="25px"/></a>

    </div>
    
return style:assemble-form($title, (), $style, $model, $content, true())