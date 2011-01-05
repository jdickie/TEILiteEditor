<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) 2009-2010 kuberam.ro - Claudius Teodorescu
Contact at : claud108@yahoo.com

Copyright (C) 2008-2009 agenceXML - Alain COUTHURES
Contact at : info@agencexml.com

Copyright (C) 2006 AJAXForms S.L.
Contact at: info@ajaxforms.com

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
	-->
<xsl:stylesheet xmlns:exfk="http://kuberam.ro/exsltforms" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:exslt="http://exslt.org/common" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" exclude-result-prefixes="xhtml xforms ev">
    <xsl:output method="html" encoding="iso-8859-1" omit-xml-declaration="no" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:variable name="eXSLTFormsConfigOptions">
	<xsl:copy-of select="document('eXSLTFormsConfigOptions.xml')/*"/>
</xsl:variable>

<xsl:template name="eXSLTForms">
	<xsl:variable name="exsltformsBaseURI"><xsl:value-of select="exslt:node-set($eXSLTFormsConfigOptions)/eXSLTFormsConfigOptions/eXSLTFormsBaseURI"/></xsl:variable>
	<script type="text/javascript">
		var exsltformsBaseURI = '<xsl:value-of select="$exsltformsBaseURI"/>';
	</script>
	<script src="{$exsltformsBaseURI}exsltforms.js" type="text/javascript">/* */</script>
	<xsl:variable name="RTEs" select="//xforms:textarea[starts-with(@appearance, 'exfk:')]"/>
	<xsl:if test="count($RTEs) &gt; 0">
		<script src="{$exsltformsBaseURI}rte/rte.js" type="text/javascript">/* */</script>
		<xsl:variable name="rteConfigOptions">
			<rteConfigOptions>
				<xsl:copy-of select="document('rte/rteConfigOptions.xml')/rteConfigOptions/*"/>
			</rteConfigOptions>
		</xsl:variable>
		<xsl:variable name="editorTypesOnPage">
			<xsl:for-each select="$RTEs/@appearance">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:for-each select="exslt:node-set($rteConfigOptions)/rteConfigOptions/editor">
			<xsl:if test="contains($editorTypesOnPage, @type)">
				<xsl:copy-of select="initialize/*"/>
			</xsl:if>
		</xsl:for-each>
		<script type="text/javascript">
<!-- 		<![CDATA[ -->
				eXSLTForms.rte.registerEditors();
<!-- 			]]> -->
		</script>
	</xsl:if>
</xsl:template>

<!--<xsl:template match="xforms:xslt" mode="script" priority="1">
        <xsl:variable name="idExtElem" select="count(preceding::xforms:xslt|ancestor::xforms:xslt)"/>
        <xsl:variable name="idInsertElem" select="concat('xf_insert_xslt', $idExtElem)"/>
        <xsl:variable name="idDeleteElem" select="concat('xf_delete_xslt', $idExtElem)"/>
        <xsl:variable name="kxexprs">
		<xexprs xmlns="">
			<xsl:for-each select="@xmlDoc|@parameters">
				<xsl:sort select="."/>
				<xexpr><xsl:value-of select="."/></xexpr>
			</xsl:for-each>
		</xexprs>
        </xsl:variable>
        <xsl:call-template name="xps">
            <xsl:with-param name="ps" select="exslt:node-set($kxexprs)/xexprs"/>
        </xsl:call-template>
        <xsl:value-of select="concat('var xf_xslt_', $idExtElem, ' = new xslt_action(&quot;', @xmlDoc, '&quot;, &quot;', @xslDoc, '&quot;, &quot;', @parameters, '&quot;, &quot;', @target, '&quot;, &quot;xslt', $idExtElem, '&quot;);')"/>
        <xsl:value-of select="concat('var ', $idInsertElem, ' = new XFInsert(&quot;', @target)"/>
        <xsl:text>",null,null,null,"after","instance('xf-instance-extensions')",null,null,null);</xsl:text>
        <xsl:value-of select="concat('new Listener(document.getElementById(&quot;xf-model-extensions&quot;),&quot;xforms-xslt-insert_xslt', $idExtElem, '&quot;,null,function(evt) {run(', $idInsertElem, ',getId(evt.currentTarget ? evt.currentTarget : evt.target),evt,false,true);});')"/>
        <xsl:value-of select="concat('var ', $idDeleteElem, ' = new XFDelete(&quot;', @target, '&quot;,null,null,null,null,null,null);')"/>
        <xsl:value-of select="concat('new Listener(document.getElementById(&quot;xf-model-extensions&quot;),&quot;xforms-xslt-delete_xslt', $idExtElem, '&quot;,null,function(evt) {run(', $idDeleteElem, ',getId(evt.currentTarget ? evt.currentTarget : evt.target),evt,false,true);});')"/>
        <xsl:apply-templates select="*" mode="script"/>
</xsl:template>-->

<xsl:template match="xforms:transform" mode="script" priority="1">
<!--	<xsl:choose>
		<xsl:when test="@type = 'xslt'">

		</xsl:when>
		<xsl:when test="@type = 'xquery'">

		</xsl:when>
		<xsl:when test="@type = 'xproc'">

		</xsl:when>
	</xsl:choose>-->
        <xsl:variable name="idExtElem" select="count(preceding::xforms:transform|ancestor::xforms:transform)"/>
        <xsl:variable name="idInsertElem" select="concat('xf_insert_xslt', $idExtElem)"/>
        <xsl:variable name="idDeleteElem" select="concat('xf_delete_xslt', $idExtElem)"/>
        <xsl:variable name="kxexprs">
		<xexprs xmlns="">
			<xsl:for-each select="@ref|@param">
				<xsl:sort select="."/>
				<xexpr><xsl:value-of select="."/></xexpr>
			</xsl:for-each>
		</xexprs>
        </xsl:variable>
        <xsl:call-template name="xps">
            <xsl:with-param name="ps" select="exslt:node-set($kxexprs)/xexprs"/>
        </xsl:call-template>
        <xsl:value-of select="concat('var xf_transform_', $idExtElem, ' = new xslt_action(&quot;', @origin, '&quot;, &quot;', @transformer, '&quot;, &quot;', @param, '&quot;, &quot;', @ref, '&quot;, &quot;xslt', $idExtElem, '&quot;);')"/>
        <xsl:value-of select="concat('var ', $idInsertElem, ' = new XFInsert(&quot;', @ref)"/>
        <xsl:text>",null,null,null,"after","instance('xf-instance-extensions')",null,null,null);</xsl:text>
        <xsl:value-of select="concat('new Listener(document.getElementById(&quot;xf-model-extensions&quot;),&quot;xforms-xslt-insert_xslt', $idExtElem, '&quot;,null,function(evt) {run(', $idInsertElem, ',getId(evt.currentTarget ? evt.currentTarget : evt.target),evt,false,true);});')"/>
        <xsl:value-of select="concat('var ', $idDeleteElem, ' = new XFDelete(&quot;', @target, '&quot;,null,null,null,null,null,null);')"/>
        <xsl:value-of select="concat('new Listener(document.getElementById(&quot;xf-model-extensions&quot;),&quot;xforms-xslt-delete_xslt', $idExtElem, '&quot;,null,function(evt) {run(', $idDeleteElem, ',getId(evt.currentTarget ? evt.currentTarget : evt.target),evt,false,true);});')"/>
        <xsl:apply-templates select="*" mode="script"/>


</xsl:template>

    <xsl:template match="xforms:replace" mode="script" priority="1">
        <xsl:variable name="idExtElem" select="count(preceding::xforms:replace|ancestor::xforms:replace)"/>
        <xsl:variable name="idInsertElem" select="concat('xf_insert_replace', $idExtElem)"/>
        <xsl:variable name="idDeleteElem" select="concat('xf_delete_replace', $idExtElem)"/>
        <xsl:value-of select="concat('var xf_replace_', $idExtElem, ' = new replace_action(&quot;', $idExtElem, '&quot;);')"/>
        <xsl:value-of select="concat('var ',$idInsertElem, ' = new XFInsert(&quot;', @target, '&quot;,null,null,null,&quot;after&quot;,&quot;', @origin, '&quot;,null,null,null);')"/>
        <xsl:value-of select="concat('new Listener(document.getElementById(&quot;xf-model-extensions&quot;),&quot;xforms-replace-insert_replace', $idExtElem, '&quot;,null,function(evt) {run(', $idInsertElem, ',getId(evt.currentTarget ? evt.currentTarget : evt.target),evt,false,true);});')"/>
        <xsl:value-of select="concat('var ', $idDeleteElem, ' = new XFDelete(&quot;', @target, '&quot;,null,null,null,null,null,null);')"/>
        <xsl:value-of select="concat('new Listener(document.getElementById(&quot;xf-model-extensions&quot;),&quot;xforms-replace-delete_replace', $idExtElem, '&quot;,null,function(evt) {run(', $idDeleteElem, ',getId(evt.currentTarget ? evt.currentTarget : evt.target),evt,false,true);});')"/>
        <xsl:apply-templates select="*" mode="script"/>
    </xsl:template>

    <xsl:template match="xforms:action" mode="script" priority="2">
        <xsl:apply-templates select="*" mode="script"/>
        <xsl:variable name="idaction" select="count(preceding::xforms:action|ancestor::xforms:action)"/>
        <xsl:text>var xf_action_</xsl:text>
        <xsl:value-of select="$idaction"/>
        <xsl:text> = new XFAction(</xsl:text>
        <xsl:call-template name="toScriptParam">
            <xsl:with-param name="p" select="@if"/>
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="toScriptParam">
            <xsl:with-param name="p" select="@while"/>
        </xsl:call-template>
        <xsl:text>)</xsl:text>
        <xsl:for-each select="xforms:setvalue|xforms:insert|xforms:delete|xforms:action|xforms:toggle|xforms:send|xforms:setfocus|xforms:load|xforms:message|xforms:dispatch|xforms:reset|xforms:show|xforms:hide|xforms:transform|xforms:replace">
            <xsl:text>.add(xf_</xsl:text>
            <xsl:variable name="lname" select="local-name()"/>
            <xsl:variable name="nsuri" select="namespace-uri()"/>
            <xsl:value-of select="$lname"/>
            <xsl:text>_</xsl:text>
            <xsl:value-of select="count(preceding::*[local-name()=$lname and namespace-uri()=$nsuri]|ancestor::*[local-name()=$lname and namespace-uri()=$nsuri])"/>
            <xsl:text>)</xsl:text>
        </xsl:for-each>
        <xsl:text>;
</xsl:text>
</xsl:template>


    <xsl:template match="xforms:textarea[starts-with(@appearance, 'exfk:')]">
        <xsl:param name="appearance" select="false()"/>
        <xsl:variable name="idinput" select="count(preceding::xforms:textarea|ancestor::xforms:textarea)"/>
	<xsl:variable name="editorType" select="substring-after(@appearance, ':')"/>
        <xsl:variable name="idExtElem" select="concat($editorType, '_', $idinput)"/>
        <xsl:variable name="XFtextareaID">
		<xsl:choose>
			<xsl:when test="@id">
				<xsl:value-of select="@id"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>xf-textarea-</xsl:text>
				<xsl:value-of select="$idinput"/>
			</xsl:otherwise>
		</xsl:choose>
        </xsl:variable>
        <xsl:call-template name="field">
            <xsl:with-param name="appearance" select="$appearance"/>
            <xsl:with-param name="body">
                <textarea id="{$idExtElem}" appearance="{@appearance}"/>
            </xsl:with-param>
        </xsl:call-template>
	<script type="text/javascript">
			eXSLTForms.registry.textarea2rte['<xsl:value-of select="$idExtElem"/>'] = {
				editorType			:	'<xsl:value-of select="$editorType"/>',
				id 				:	'<xsl:value-of select="$idExtElem"/>',
				XFtextareaID			:	'<xsl:value-of select="$XFtextareaID"/>',
				incremental			:	'<xsl:value-of select="@incremental"/>',
				editorContentModified		:	'no',
				processContentOnSave		:	eXSLTForms.rte.generalFunctions.processContentOnSave,
				processContentOnUpdate		:	eXSLTForms.rte.generalFunctions.processContentOnUpdate,
				nativeConfigOptionsObject	:	<xsl:value-of select="xforms:extension/exfk:rteOptions"/>,
				nativeConfigOptionsString	:	"<xsl:value-of select="normalize-space(xforms:extension/exfk:rteOptions)"/>"
			};
	</script>
    </xsl:template>
</xsl:stylesheet>