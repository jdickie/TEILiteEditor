/*
Copyright (C) 2010 kuberam.ro - Claudius Teodorescu. All rights reserved.
 
Released under LGPL License.
*/

// alert( ( new XMLSerializer() ).serializeToString(  ) );


var pluginDefinition = {
	requires : [ 'dialog', 'keystrokes' ],
	
	init : function( editor ) {

		var editorID = editor.name,
			warnOnForbiddenOverlapping = pluginLangDoc.querySelector( "lang > generalErrorMsgs > warnOnForbiddenOverlapping" ).textContent,
			selectionNonEmpty = pluginLangDoc.querySelector( "lang > generalErrorMsgs > selectionNonEmpty" ).textContent,
			selectionEmpty = pluginLangDoc.querySelector( "lang > generalErrorMsgs > selectionEmpty" ).textContent,
			warnOnRemovingRootEntity = pluginLangDoc.querySelector( "lang > generalErrorMsgs > warnOnRemovingRootEntity" ).textContent,
			warnOnSelectingSearchResult = pluginLangDoc.querySelector( "lang > generalErrorMsgs > warnOnSelectingSearchResult" ).textContent,
			editableAnnotatorTypes = annotatorSpecificationsDoc.querySelector( "EditableAnnotatorTypes" ).textContent;

		//overriding the current behaviour of Enter key
// 		editor.on( 'key', function( ev ) {
// 			var keyCode = ev.data.keyCode;//alert( ev.data.name );
// 			if ( keyCode == 13 ) {
// 				ev.cancel();
// 				editor.execCommand( 'teiannParagraphBtn' );
// 			}
// 		});

		//construction of the annotator's context menu
		if (editor.addMenuItem) {
			editor.addMenuGroup( 'teiannGroup' );
			editor.addMenuItem( 'editEntityItem', {
				label: pluginLangDoc.querySelector( "Annotator[id = 'teiannEditEntityBtn'] > ToolbarButtonTitle" ).textContent,
  				command: 'teiannEditEntityBtn',
  				group: 'teiannGroup',
				icon: CKEDITOR.basePath + 'plugins/tei-ann/images/' + annotatorSpecificationsDoc.querySelector( "Annotator[id = 'teiannEditEntityBtn'] > AnnotatorIconName" ).textContent
			});
			editor.addMenuItem( 'removeEntityItem', {
				label: pluginLangDoc.querySelector( "Annotator[id = 'teiannRemoveEntityBtn'] > ToolbarButtonTitle" ).textContent,
  				command: 'teiannRemoveEntityBtn',
  				group: 'teiannGroup',
				icon: CKEDITOR.basePath + 'plugins/tei-ann/images/' + annotatorSpecificationsDoc.querySelector( "Annotator[id = 'teiannRemoveEntityBtn'] > AnnotatorIconName" ).textContent
			});
		}
		if (editor.contextMenu) {
			editor.contextMenu.addListener(function(element, selection) {
				return { editEntityItem: CKEDITOR.TRISTATE_ON };
 			});
			editor.contextMenu.addListener(function(element, selection) {
				return { removeEntityItem: CKEDITOR.TRISTATE_ON };
 			});
		}
		delete editor._.menuItems.cut;
		delete editor._.menuItems.copy;
		delete editor._.menuItems.paste;


//		applying the tei-ann plugin's customizable CSS styleshhet
		editor.config.contentsCss = generalConfigOptionsDoc.querySelector( "CSSfilePath" ).textContent;

//		overriding the editor's eXSLTForms function for processing its content on update
		eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate = function( editorContent ) {
			var xsltResult = eXSLTForms_xslt( editorContent, CKEDITOR.basePath + 'plugins/tei-ann/xsl/tei2tei-ann.xsl', null );//externalVocab2annotatorVocab.xsl
			if ( !Core.isIE )
				{
				var serializer = new XMLSerializer();
				var xsltResultSerialized = serializer.serializeToString( xsltResult );
				}
				else {}
			return xsltResultSerialized;
		};

//		XSL transformation from TEI to tei-ann, when content is loaded first time
		var editorContent = eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate( editor.element.$.value );
		editor.setData( editorContent );
	
//		overriding the editor's eXSLTForms function for processing its content on save
		eXSLTForms.registry.textarea2rte[ editorID ].processContentOnSave = function( editorContent ) {
			var editorContent = editorContent.substring( 3, editorContent.length ).substring( 0, editorContent.length - 7 ).replace( /&nbsp;/gi, "&#160;" );
			var xsltResult = eXSLTForms_xslt( editorContent, CKEDITOR.basePath + 'plugins/tei-ann/xsl/tei-ann2tei.xsl', null );
			if ( !Core.isIE )
				{
				var serializer = new XMLSerializer();
				var xsltResultSerialized = serializer.serializeToString( xsltResult );
				}
				else {}
			return xsltResultSerialized;
		};

//		generation of needed buttons with their commands and dialog boxes (if case)
 		var annotatorSpecifications = annotatorSpecificationsDoc.querySelectorAll( "Annotator" );
		for ( var i=0, il = annotatorSpecifications.length; i < il; i++ ) {
			var annotatorSpecification = annotatorSpecifications[ i ];
			var annotatorID = annotatorSpecification.getAttribute( 'id' );
			var annotatorTypeCode = annotatorSpecification.getAttribute( 'typeCode' );
			
			//generation of button
			editor.ui.addButton( annotatorID,
				{
				label : pluginLangDoc.querySelector( "Annotator[id = '" + annotatorID + "'] > ToolbarButtonTitle" ).textContent,
				command : annotatorID,
				icon: CKEDITOR.basePath + 'plugins/tei-ann/images/' + annotatorSpecification.querySelector( "AnnotatorIconName" ).textContent
			});
			var annotatorPossibleParentElementNames = annotatorSpecification.querySelector( "AnnotatorPossibleParentElementNames" ).textContent,
				class = annotatorSpecification.getAttribute( 'name' );
			//generation of commands and dialog panels
			switch ( annotatorTypeCode ) {
				case "insert":
					var annotatorOptions = {
						'class': class,
						'annotatorPossibleParentElementNames' : annotatorPossibleParentElementNames
					};
					editor.addCommand( annotatorID, {
						annotatorOptions : annotatorOptions,
						exec : function( editor ) {
							//test if the annotator's future parent is among its possible parents
							var futureParentElementName = editor._.elementsPath.list[0].getAttribute( 'class' );
							if ( this.annotatorOptions.annotatorPossibleParentElementNames.indexOf( futureParentElementName ) == -1 ) {
								alert( warnOnForbiddenOverlapping );
								return false;
							}							

							if ( editor.getSelection().getNative() != '' ) {
								alert( selectionNonEmpty );
								} else { editor.insertElement( CKEDITOR.dom.element.createFromHtml( '<span class="' + this.annotatorOptions.class + '">&#160;</span>' ) );
							}
						}
					});
				break;
				case "insert-split":
					var annotatorOptions = {
						'class': class,
						'annotatorPossibleParentElementNames' : annotatorPossibleParentElementNames
					};
					editor.addCommand( annotatorID, {
						annotatorOptions : annotatorOptions,
						exec : function( editor ) {
							//test if the annotator's future parent is among its possible parents
							var futureParentElementName = editor._.elementsPath.list[0].getAttribute( 'class' ); //alert( futureParentElementName );
							if ( this.annotatorOptions.annotatorPossibleParentElementNames.indexOf( futureParentElementName ) !== -1 ) {
								var elementClass = this.annotatorOptions.class;
								var ranges = editor.getSelection().getRanges();
								range = ranges[0];
								var livingParentElement = range.getCommonAncestor( false, true );
								eXSLTForms.registry.plugins.teiann.splitElement( range, livingParentElement, elementClass );
								} else {
									alert( warnOnForbiddenOverlapping );
							}
						}
					});
				break;
				case "insert-parameterized":
				break;
				case "selected-wrap":
					var annotatorOptions = { 'element' : 'span', 'attributes' : { 'class' : class } };
					var annotatorAttributes = annotatorSpecification.querySelectorAll( "AnnotatorAttribute" );
					for ( var j=0, jl = annotatorAttributes.length; j < jl; j++ ) {
						var annotatorAttribute = annotatorAttributes[ j ];
						annotatorOptions.attributes[ annotatorAttribute.getAttribute( 'name' ) ] = annotatorAttribute.getAttribute( 'value' );
					}
					editor.addCommand( annotatorID, {
						annotatorOptions : annotatorOptions,
						exec : function( editor ) {
							if ( editor.getSelection().getNative() != '' ) {
								var style = new CKEDITOR.style( this.annotatorOptions );
								style.type = CKEDITOR.STYLE_INLINE;
								style.apply( editor.document );
								} else { alert( selectionEmpty )
							}
						}
					});
				break;
				case "selected-wrap-parameterized":
					var annotatorOptions = {
						'dialogID' : annotatorID + 'Panel',
						'validatingXSD' : { 'annotatorPossibleParentElementNames' : annotatorPossibleParentElementNames, 'precedingSibling' : {} },
						'edit' : 'false',
						'currentAnnotator' : ''
					};

					//definition of associated command
					editor.addCommand( annotatorID, {
						annotatorOptions : annotatorOptions,
						exec : function( editor ) {
							var command = this;
							if ( command.annotatorOptions.edit == 'false' && editor.getSelection().getNative() == '' ) { alert( selectionEmpty ); return false; }
							var futureParentElementName = editor._.elementsPath.list[0].getAttribute( 'class' );
							if ( command.annotatorOptions.edit == 'true' || this.annotatorOptions.validatingXSD.annotatorPossibleParentElementNames.indexOf( futureParentElementName ) !== -1 ) {
								editor.openDialog( command.annotatorOptions.dialogID );
								} else {
									alert( warnOnForbiddenOverlapping );
							}
						}
					});
					//definition of associated dialog panel
					eXSLTForms.registry.plugins.teiann.addDialogPanel( annotatorID, editor );
				break;
				case "selected-wrap-server":
					var annotatorOptions = {
						'dialogID' : annotatorID + 'Panel',
						'validatingXSD' : { 'annotatorPossibleParentElementNames' : annotatorPossibleParentElementNames, 'precedingSibling' : {} },
						'dialogHTMLcontent' : { 'element' : 'span', 'attributes' : { 'class' : class } },
						'edit' : 'false',
						'currentAnnotator' : ''
					};
					//adding the annotator's attributes
					var annotatorAttributes = annotatorSpecification.querySelectorAll( "AnnotatorAttribute" );
					for ( var j=0, jl = annotatorAttributes.length; j < jl; j++ ) {
						var annotatorAttribute = annotatorAttributes[ j ];
						annotatorOptions.dialogHTMLcontent.attributes[ annotatorAttribute.getAttribute( 'name' ) ] = annotatorAttribute.getAttribute( 'value' );
					}

					//definition of associated command
					editor.addCommand( annotatorID, {
						annotatorOptions : annotatorOptions,
						exec : function( editor ) {
							var command = this;
							if ( command.annotatorOptions.edit == 'false' && editor.getSelection().getNative() == '' ) { alert( selectionEmpty ); return false; }
							var futureParentElementName = editor._.elementsPath.list[0].getAttribute( 'class' );
							if ( command.annotatorOptions.edit == 'true' || this.annotatorOptions.validatingXSD.annotatorPossibleParentElementNames.indexOf( futureParentElementName ) !== -1 ) {
								editor.openDialog( command.annotatorOptions.dialogID );
								} else {
									alert( warnOnForbiddenOverlapping );
							}
						}
					});
					//definition of associated dialog panel
					eXSLTForms.registry.plugins.teiann.addDialogPanel( annotatorID, editor );
				break;
				//this cases are standard, do not modify
				case "edit-entity":
					editor.addCommand( 'teiannEditEntityBtn', {
						exec : function( editor ) {
							var annotatorName = editor.getSelection().getStartElement().getAttribute( 'class' ),
								annotatorType = annotatorSpecificationsDoc.querySelector( "Annotator[name = '" + annotatorName + "']" ).getAttribute( 'typeCode' ),
								annotatorID = annotatorSpecificationsDoc.querySelector( "Annotator[name = '" + annotatorName + "']" ).getAttribute( 'id' )
							if ( editableAnnotatorTypes.match( new RegExp( annotatorType ) ) !== null  ) {
								editor._.commands[ annotatorID ].annotatorOptions.edit = 'true';
								editor._.commands[ annotatorID ].annotatorOptions.currentAnnotator = editor.getSelection().getStartElement().$;
								editor.execCommand( annotatorID );
							}
						}
					});
				break;
				case "remove-entity":
					editor.addCommand( 'teiannRemoveEntityBtn', {
						exec : function( editor ) {
							if ( editor.getSelection().getStartElement().getAttribute( 'class' ) != editor._.elementsPath.list[ editor._.elementsPath.list.length - 3 ].getAttribute( 'class' ) ) {
								editor.openDialog( 'teiannRemoveEntityBtnPanel' );
								} else {
									alert( warnOnRemovingRootEntity );
							}
						}
					});
					//definition of associated dialog panel
					eXSLTForms.registry.plugins.teiann.addDialogPanel( annotatorID, editor );
				break;
			}
		}

		//define some dialogs' features
		CKEDITOR.on( 'dialogDefinition', function( evt ) {
			//add some annotator definitions - evt.data.commandData, evt.data.command (command itself !!)
			var panelDefinition = evt.data.definition, dialogName = evt.data.name, annotatorID = dialogName.substring(0, dialogName.length - 5),
				annotatorSpecification = annotatorSpecificationsDoc.querySelector( "Annotator[id = '" + annotatorID + "']" ),
				annotatorTypeCode = annotatorSpecification.getAttribute( 'typeCode' ),
				panelLang = pluginLangDoc.querySelector( "Annotator[id = '" + annotatorID + "']" );
			panelDefinition.title = panelLang.querySelector( "AnnotatorPanelTitle" ).textContent;
			panelDefinition[ 'annotatorDefinitions' ] = { 'annotatorID' : annotatorID, 'annotatorSpecification' : annotatorSpecification, panelHTMLcontent : { element: 'span', attributes : { 'class' : annotatorSpecification.getAttribute( 'name' ) } } };

			//customize definitions of dialog panels based upon annotatorTypeCode
			switch ( annotatorTypeCode ) {
				case "selected-wrap-server":
					var specificPanelLang = pluginLangDoc.querySelector( "lang > StandardPanels > selected-wrap-server > AnnotatorPanel" ),
						annotatorPanelTabs = annotatorSpecificationsDoc.querySelectorAll( "Annotators > StandardPanels > selected-wrap-server > AnnotatorPanel > AnnotatorPanelTab" );
					panelDefinition.minWidth = annotatorSpecificationsDoc.querySelector( "Annotators > StandardPanels > selected-wrap-server > AnnotatorPanel > AnnotatorPanelMinWidth" ).textContent;
					panelDefinition.minHeight = annotatorSpecificationsDoc.querySelector( "Annotators > StandardPanels > selected-wrap-server > AnnotatorPanel > AnnotatorPanelMinHeight" ).textContent;
					panelDefinition.onShow = function() {
						document.getElementById( 'teiannSearchCriterion' ).value = '';
						document.getElementById( 'teiannSearchList' ).options.length = 0;
						eXSLTForms.registry.plugins.teiann.generateList( editor, editor.getSelection().getNative(), panelDefinition.annotatorDefinitions.annotatorServiceURI );
					};
					panelDefinition.onOk = function() {
								var annotatorDefinitions = this.definition.annotatorDefinitions;
								if ( document.getElementById( 'teiannSearchList' ).value ) {
									annotatorDefinitions.annotatorOptions.dialogHTMLcontent.attributes[ annotatorDefinitions.attributeStoringSearchResult ] = document.getElementById( 'teiannSearchList' ).value;
									this.getParentEditor()._.commands[ annotatorID ].annotatorOptions.edit = 'false';
									var style = new CKEDITOR.style( annotatorDefinitions.annotatorOptions.dialogHTMLcontent );
									style.type = CKEDITOR.STYLE_INLINE;
									style.apply( editor.document );
									} else {
										alert( warnOnSelectingSearchResult );
										document.getElementById( 'teiannSearchList' ).focus();
										return false;
								}
					};
					panelDefinition.annotatorDefinitions[ 'annotatorServiceURI' ] = annotatorSpecification.querySelector( "AnnotatorIDServiceURI" ).textContent;
					panelDefinition.annotatorDefinitions[ 'attributeStoringSearchResult' ] = annotatorSpecification.querySelector( 'AnnotatorAttribute' ).getAttribute( 'name' );
					panelDefinition.annotatorDefinitions[ 'annotatorOptions' ] = editor._.commands[ annotatorID ].annotatorOptions;
					for ( var i=0, il = annotatorPanelTabs.length; i < il; i++ ) {
						var annotatorPanelTab = annotatorPanelTabs[ i ];
						var annotatorPanelTabID = annotatorPanelTab.getAttribute( 'id' );
						panelDefinition.contents[ i ] = {
							id : annotatorPanelTabID,
							label : specificPanelLang.querySelector( "AnnotatorPanelTab[id = '" + annotatorPanelTabID + "'] > AnnotatorPanelTabTitle" ).textContent,
							title : specificPanelLang.querySelector( "AnnotatorPanelTab[id = '" + annotatorPanelTabID + "'] > AnnotatorPanelTabTitle" ).textContent,
							expand : true,
							padding : 15,
							onLoad : function() {
								//interogate the server
								document.getElementById( 'teiannSearchButton' )[ 'teiannGenerateSearchList' ] = function() { eXSLTForms.registry.plugins.teiann.generateList( editor, document.getElementById( 'teiannSearchCriterion' ).value, panelDefinition.annotatorDefinitions.annotatorServiceURI ); }
								//set texts for tab elements
								var tabLang = specificPanelLang.querySelector( "AnnotatorPanelTab[id = '" + this.id + "']" );
								var tabLangElements = tabLang.querySelectorAll( "AnnotatorPanelTabElement" );
								for ( var i=0, il = tabLangElements.length; i < il; i++ ) {
									var tabLangElement = tabLangElements[ i ],
										tabLangElementType = tabLangElement.getAttribute( 'type' );
									switch( tabLangElementType ) {
										case 'label':
											document.getElementById( tabLangElement.getAttribute( 'id' ) ).innerHTML = tabLangElement.textContent;
										break;
										case 'button':
											alert( ( new XMLSerializer() ).serializeToString( document.getElementById( tabLangElement.getAttribute( 'id' ) ) ) );
											//alert("Search button: " + tabLangElement.getAttribute( 'id' ) );
											document.getElementById( tabLangElement.getAttribute( 'id' ) ).value = tabLangElement.textContent;
										break;
									}
								}
							},
							onShow : function() {},
							elements : [ { type : 'html', html : annotatorPanelTab.querySelector( "AnnotatorPanelTabHtmlContent" ).textContent } ]
						};
					}	
				break;
				case "selected-wrap-parameterized":
					panelDefinition.minWidth = annotatorSpecification.querySelector( "AnnotatorPanel > AnnotatorPanelMinWidth" ).textContent;
					panelDefinition.minHeight = annotatorSpecification.querySelector( "AnnotatorPanel > AnnotatorPanelMinHeight" ).textContent;
					var annotatorPanelTabs = annotatorSpecification.querySelectorAll( "AnnotatorPanel > AnnotatorPanelTab" );
					panelDefinition.onShow = function() {
						var command = this.getParentEditor()._.commands[ annotatorID ],
							currentAnnotator = command.annotatorOptions.currentAnnotator,
							annotatorSpecification = annotatorSpecificationsDoc.querySelector( "Annotator[id = '" + annotatorID + "']" ),
							annotatorPanelFields = annotatorSpecification.querySelectorAll( "AnnotatorPanelField" );
						if ( command.annotatorOptions.edit == 'true') {
							for ( var i=0, il = annotatorPanelFields.length; i < il; i++ ) {
								var annotatorPanelField = annotatorPanelFields[ i ],
									annotatorPanelFieldID = annotatorPanelField.getAttribute( 'id' ),
									annotatorPanelFieldRef = annotatorPanelField.querySelector( "AnnotatorPanelFieldRef" ).textContent.substring( 1 );
								document.getElementById( annotatorPanelFieldID ).value = currentAnnotator.attributes[ annotatorPanelFieldRef ].nodeValue;
							}
						}
					};
					panelDefinition.onOk = function() {
								var annotatorDefinitions = this.definition.annotatorDefinitions,
									annotatorSpecification = annotatorDefinitions.annotatorSpecification,
									panelHTMLcontent = annotatorDefinitions.panelHTMLcontent,
									annotatorPanelFields = annotatorSpecification.querySelectorAll( "AnnotatorPanelField" ),
									command = this.getParentEditor()._.commands[ annotatorID ],
									editOption = command.annotatorOptions.edit,
									currentAnnotator = command.annotatorOptions.currentAnnotator;
								for ( var i=0, il = annotatorPanelFields.length; i < il; i++ ) {
									var annotatorPanelField = annotatorPanelFields[ i ],
										annotatorPanelFieldValidationRegex = annotatorPanelField.querySelector( "AnnotatorPanelFieldValidationRegex" ).textContent,
										annotatorPanelFieldID = annotatorPanelField.getAttribute( 'id' ),
										annotatorPanelFieldValue = document.getElementById( annotatorPanelFieldID ).value;
									if ( annotatorPanelFieldValidationRegex != '' && annotatorPanelFieldValue.match( new RegExp( annotatorPanelFieldValidationRegex ) ) == null ) {
										var annotatorPanelFieldLabel = panelLang.querySelector( "AnnotatorPanelTabElement[for = '" + annotatorPanelFieldID + "']" ).textContent;
										alert( "The validation failed for field having label '" + annotatorPanelFieldLabel + "'." );
										return false;
									}
									var annotatorPanelFieldRef = annotatorPanelField.querySelector( "AnnotatorPanelFieldRef" ).textContent;
									if ( editOption == 'true' ) {
										currentAnnotator.setAttribute( annotatorPanelFieldRef.substr( 1 ), annotatorPanelFieldValue );
										} else {
											panelHTMLcontent.attributes[ annotatorPanelFieldRef.substr( 1 ) ] = annotatorPanelFieldValue;
									}
									document.getElementById( annotatorPanelFieldID ).value = '';
								}
								if ( editOption == 'false' ) {
									var style = new CKEDITOR.style( panelHTMLcontent );
									style.type = CKEDITOR.STYLE_INLINE;
									style.apply( editor.document );
								}
								editOption = 'false';
					};
					for ( var i=0, il = annotatorPanelTabs.length; i < il; i++ ) {
						var annotatorPanelTab = annotatorPanelTabs[ i ];
						var annotatorPanelTabID = annotatorPanelTab.getAttribute( 'id' );
						panelDefinition.contents[ i ] = {
							id : annotatorPanelTabID,
							label : panelLang.querySelector( "AnnotatorPanelTab[id = '" + annotatorPanelTabID + "'] > AnnotatorPanelTabTitle" ).textContent,
							title : panelLang.querySelector( "AnnotatorPanelTab[id = '" + annotatorPanelTabID + "'] > AnnotatorPanelTabTitle" ).textContent,
							expand : true,
							padding : 15,
							onLoad : function() {
								//set texts for tab elements
								var tabLang = panelLang.querySelector( "AnnotatorPanelTab[id = '" + this.id + "']" );
								var tabLangElements = tabLang.querySelectorAll( "AnnotatorPanelTabElement" );
								for ( var i=0, il = tabLangElements.length; i < il; i++ ) {
									var tabLangElement = tabLangElements[ i ],
										tabLangElementType = tabLangElement.getAttribute( 'type' );
									switch( tabLangElementType ) {
										case 'label':
											document.getElementById( tabLangElement.getAttribute( 'id' ) ).innerHTML = tabLangElement.textContent;
										break;
										case 'button':
											document.getElementById( tabLangElement.getAttribute( 'id' ) ).value = tabLangElement.textContent;
										break;
									}								}
							},
							onShow : function() {},
							elements : [ { type : 'html', html : annotatorPanelTab.querySelector( "AnnotatorPanelTabHtmlContent" ).textContent } ]
						};
					}
				break;
				case "remove-entity":
					panelDefinition.minWidth = annotatorSpecification.querySelector( "AnnotatorPanel > AnnotatorPanelMinWidth" ).textContent;
					panelDefinition.minHeight = annotatorSpecification.querySelector( "AnnotatorPanel > AnnotatorPanelMinHeight" ).textContent;
					panelDefinition.onLoad = function() {};
					panelDefinition.onShow = function() {
						var teiannRemoveEntityBtnPanelLabel = panelLang.querySelector( "AnnotatorPanelTabElement" ).textContent.replace( /%entityName/, editor.getSelection().getStartElement().getAttribute( 'class' ) ).replace( /%entityContent/, editor.getSelection().getStartElement().getText() );
						document.getElementById( 'teiannRemoveEntityBtnPanelLabel' ).innerHTML = teiannRemoveEntityBtnPanelLabel;
					};
					panelDefinition.onOk = function() {
						var text = editor.getSelection().getStartElement().getText();
						editor.getSelection().getStartElement().remove();
						var textObject = CKEDITOR.dom.element.createFromHtml( text );
						editor.getSelection().getRanges()[0].insertNode( textObject );
						
					};
					panelDefinition.contents[ 0 ] = {
						id : 'teiannRemoveEntityBtnTab1',
						label : panelLang.querySelector( "AnnotatorPanelTabTitle" ).textContent,
						title : panelLang.querySelector( "AnnotatorPanelTabTitle" ).textContent,
						expand : true,
						padding : 15,
						elements : [ { type : 'html', html : annotatorSpecification.querySelector( "AnnotatorPanelTabHtmlContent" ).textContent } ]
					};
				break;
			}
		});
	}
}
CKEDITOR.plugins.add( 'tei-ann', pluginDefinition );