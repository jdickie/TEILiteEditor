/*
Copyright (C) 2010 kuberam.ro - Claudius Teodorescu. All rights reserved.
 
Released under LGPL License - http://gnu.org/licenses/lgpl.html.
*/

eXSLTForms.rte = {
  	//function to register editors
	registerEditors : function() {
		eXSLTForms.utils.pollingConditions[ 'textarea2rte_register' ] = {
			testedValue: function() { return ( xforms.body != null ) },
			executedFunction: function() {
				var textareas = document.getElementsByTagName("textarea");
				for (var i=0; i < textareas.length; ++i) {
					var textarea = textareas[i];
					if ( textarea.attributes[ 'appearance' ] ) {
						if ( textarea.attributes[ 'appearance' ].nodeValue.substring(0, 5) == 'exfk:') {
							var editorID = textarea.attributes[ 'id' ].nodeValue;
							if ( editorID in eXSLTForms.registry.textarea2rte ) {
								} else {
									var clonedEditorID = textarea.attributes[ 'oldid' ].nodeValue;
									eXSLTForms.registry.textarea2rte[ editorID ] = {};
									eXSLTForms.registry.textarea2rte[ editorID ].editorType = eXSLTForms.registry.textarea2rte[ clonedEditorID ].editorType;
									eXSLTForms.registry.textarea2rte[ editorID ].id = editorID;
									eXSLTForms.registry.textarea2rte[ editorID ].XFtextareaID = textarea.parentNode.parentNode.parentNode.parentNode.attributes[ 'id' ].nodeValue;
									eXSLTForms.registry.textarea2rte[ editorID ].incremental = eXSLTForms.registry.textarea2rte[ clonedEditorID ].incremental;
									eXSLTForms.registry.textarea2rte[ editorID ].editorContentModified = 'no';
									eXSLTForms.registry.textarea2rte[ editorID ].processContentOnSave = eXSLTForms.rte.generalFunctions.processContentOnSave;
									eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate = eXSLTForms.rte.generalFunctions.processContentOnUpdate;
									eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject = eXSLTForms.registry.textarea2rte[ clonedEditorID ].nativeConfigOptionsObject;
									eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsString = eXSLTForms.registry.textarea2rte[ clonedEditorID ].nativeConfigOptionsString;
							}
							if ( eXSLTForms.registry.textarea2rte[ editorID ].editorType in { Xinha: 1, DojoEditor: 1, YUIEditor: 1 } ) {
								} else {
									eXSLTForms.rte.specificFunctions[ eXSLTForms.registry.textarea2rte[ editorID ].editorType ].beforeRendering( eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject );
									eXSLTForms.rte.generateEditor( eXSLTForms.registry.textarea2rte[ editorID ].editorType, editorID, eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject, eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsString );
							}
						}
					}
				}

				eXSLTForms.utils.pollTestedValues[ 'textarea2rte_registered' ] = true;
			}
		}
		eXSLTForms.utils.poll( 'textarea2rte_register' );
	},
	//function to generate and render editors in a single pass
	generateEditors : function( generatedEditorType ) {
			for (var editorID in eXSLTForms.registry.textarea2rte) {
				if ( eXSLTForms.registry.textarea2rte[ editorID ].editorType == 'YUIEditor' ) {
					switch ( eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject.YUIeditorType ) {
						case "Editor":
							new YAHOO.widget.Editor( editorID, eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject );
						break;
						case "SimpleEditor":
							new YAHOO.widget.SimpleEditor( editorID, eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject );
						break;
					}
					eXSLTForms.rte.generateEditor( 'YUIEditor', editorID, eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject, '' );
					eXSLTForms.rte.generalFunctions.addXFupdateListener( editorID );
				}
			}
	}, 
	//function to generate and render editors one by one
	generateEditor : function( editorType, editorID, nativeConfigOptionsObject, nativeConfigOptionsString ) {
				switch ( editorType ) {
					case "CKEditor":
						CKEDITOR.replace( document.getElementById( editorID ), nativeConfigOptionsObject );
						CKEDITOR.instances[ editorID ].on("instanceReady", function() {
							this.on("blur", function() { eXSLTForms.rte.generalFunctions.saveEditorContent( editorID, this.document.$.activeElement.innerHTML ); } );
							if ( eXSLTForms.registry.textarea2rte[ editorID ].incremental == 'true' ) {
								this.on("key", function() { eXSLTForms.rte.generalFunctions.saveEditorContent( editorID, this.document.$.activeElement.innerHTML );});
								this.on("paste", function() { eXSLTForms.rte.generalFunctions.saveEditorContent( editorID, this.document.$.activeElement.innerHTML );});
							}
						});
					break;
					case "TinyMCE":
						var editorGenerator = new tinymce.Editor( editorID, nativeConfigOptionsObject );
						if ( eXSLTForms.registry.textarea2rte[ editorID ].incremental == 'true' ) {
							editorGenerator.onChange.add(function() { eXSLTForms.rte.generalFunctions.saveEditorContent( editorID, this.contentDocument.activeElement.innerHTML );});
						}
						editorGenerator.onPostRender.add(function() { eXSLTForms.rte.specificFunctions.saveTinyMCEContent( this ); });
						eXSLTForms.rte.specificFunctions[ eXSLTForms.registry.textarea2rte[ editorID ].editorType ].beforeRendering( eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject );
						editorGenerator.render();
					break;
					case "EditArea":
						var nativeConfigOptionsStringProcessed = nativeConfigOptionsString.substring(nativeConfigOptionsString.indexOf('{') + 1, nativeConfigOptionsString.lastIndexOf('}'));
						eXSLTForms.rte.specificFunctions[ eXSLTForms.registry.textarea2rte[ editorID ].editorType ].beforeRendering( eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject );
						editAreaLoader.init(eval('(' + '{ id:\"' + editorID + '\", ' + nativeConfigOptionsStringProcessed + ', save_callback: "eXSLTForms.rte.specificFunctions.saveEditAreaContent"}' + ')'));
					break;
					case "YUIEditor":
// 					eXSLTForms.utils.pollingConditions[ 'generateYUIEditors' ] = {
// 						testedValue: function() { return typeof YAHOO.widget.EditorInfo != 'undefined' },
// 						executedFunction: function() {
						new YAHOO.widget.Editor( editorID, eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject );
						YAHOO.widget.EditorInfo._instances[ editorID ].on( 'editorWindowBlur', function() { eXSLTForms.rte.generalFunctions.saveEditorContent( editorID, this._getDoc().body.innerHTML ); } );
						if ( eXSLTForms.registry.textarea2rte[ editorID ].incremental == 'true' ) {
							YAHOO.widget.EditorInfo._instances[ editorID ].on('afterNodeChange', function() { eXSLTForms.rte.generalFunctions.saveEditorContent( editorID, this._getDoc().body.innerHTML ); } );
						}
						eXSLTForms.rte.specificFunctions[ eXSLTForms.registry.textarea2rte[ editorID ].editorType ].beforeRendering( eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject );
						YAHOO.widget.EditorInfo._instances[ editorID ].render();
// 						}
// 					}
// 					eXSLTForms.utils.poll( 'generateYUIEditors' );
					break;
					case "DojoEditor":
						dojo.addOnLoad(function() {
							new dijit.Editor( eXSLTForms.registry.textarea2rte[ editorID ].nativeConfigOptionsObject, dojo.byId( editorID ));
							dojo.connect(dijit.byId( editorID ), "onBlur", function( editorContent ) { eXSLTForms.rte.generalFunctions.saveEditorContent( this.id, dijit.registry._hash[ this.id ].document.activeElement.innerHTML ); });
							if ( eXSLTForms.registry.textarea2rte[ editorID ].incremental == 'true' ) {
								dojo.connect( dijit.byId( editorID ), "onNormalizedDisplayChanged", function( event ) { eXSLTForms.rte.generalFunctions.saveEditorContent( this.id, dijit.registry._hash[ this.id ].document.activeElement.innerHTML ); } );
							}
						});
					break;
				}
				eXSLTForms.rte.generalFunctions.addXFupdateListener( editorID );
	},
	//specific functions for editors
	specificFunctions : {
		DojoEditor : {
			setEditorContent : function( editorID, editorContent ) { dijit.byId( editorID ).setValue( eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate( editorContent ) ); },
			beforeRendering : function( nativeConfigOptionsObject ) {}
		},
		CKEditor : {
			setEditorContent : function( editorID, editorContent ) { CKEDITOR.instances[ editorID ].setData( eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate( editorContent ) ); },
			beforeRendering : function( nativeConfigOptionsObject ) {}
		},
		EditArea : {
			setEditorContent : function( editorID, editorContent ) { editAreaLoader.setValue( editorID, eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate( editorContent ) ); },
			beforeRendering : function( nativeConfigOptionsObject ) {}
		},
		TinyMCE : {
			setEditorContent : function( editorID, editorContent ) { tinymce.editors[ editorID ].setContent( eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate( editorContent ) ); },
			beforeRendering : function( nativeConfigOptionsObject ) {}
		},
		YUIEditor : {
			setEditorContent : function( editorID, editorContent ) { YAHOO.widget.EditorInfo._instances[ editorID ].setEditorHTML( eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate( editorContent ) ); },
			beforeRendering : function( nativeConfigOptionsObject ) {}
		},
		Xinha : {
			setEditorContent : function( editorID, editorContent ) { xinha_editors[ editorID ].setHTML( eXSLTForms.registry.textarea2rte[ editorID ].processContentOnUpdate( editorContent ) ); },
			beforeRendering : function( nativeConfigOptionsObject ) {}
		},
		saveEditAreaContent : function( editorID, editorContent ) {
			eXSLTForms.rte.generalFunctions.saveEditorContent( editorID, editorContent );
		},
		saveTinyMCEContent : function( editor ) {
			if (tinymce.isIE) {
				tinymce.dom.Event.add(editor.getWin(), 'blur', function(e) { eXSLTForms.rte.generalFunctions.saveEditorContent( editor.editorId, editor.contentDocument.activeElement.innerHTML ); });
				} else {
					tinymce.dom.Event.add(editor.getDoc(), 'blur', function(e) { eXSLTForms.rte.generalFunctions.saveEditorContent( editor.editorId, editor.contentDocument.activeElement.innerHTML ); });
			}
		},
		saveDojoContent : function( editorID ) {
			alert( editorID );
		}
	},
	//general functions for editors
	generalFunctions : {
		processContentOnSave	: function( editorContent ) {return editorContent.replace(/&nbsp;/gi, "&#160;");},
		processContentOnUpdate	: function( editorContent ) {return editorContent;},
		addXFupdateListener	: function( editorID ) {
			new Listener( document.getElementById( eXSLTForms.registry.textarea2rte[ editorID ].XFtextareaID ), "xforms-value-changed", null, function( evt ) {
				eXSLTForms.rte.generalFunctions.updateEditorContent( editorID );
			});
		},
		updateEditorContent	: function( editorID ) {
			if ( eXSLTForms.registry.textarea2rte[ editorID ].editorContentModified == 'yes' ) {
				eXSLTForms.registry.textarea2rte[ editorID ].editorContentModified = 'no';
			} else {
				eXSLTForms.rte.specificFunctions[ eXSLTForms.registry.textarea2rte[ editorID ].editorType ].setEditorContent( editorID, document.getElementById( eXSLTForms.registry.textarea2rte[ editorID ].id ).value );
				}
		},
		saveEditorContent	: function( editorID, editorContent ) {
			var textareaContent = document.getElementById( editorID ).value;
			setTimeout(
				function() {
					if ( textareaContent !== editorContent ) {
						eXSLTForms.registry.textarea2rte[ editorID ].editorContentModified = 'yes';
						var XFtextareaXFElement = document.getElementById( eXSLTForms.registry.textarea2rte[ editorID ].XFtextareaID ).xfElement;
						var editorContentProcessedOnSave = eXSLTForms.registry.textarea2rte[ editorID ].processContentOnSave( editorContent );
						xforms.openAction();
						XFtextareaXFElement.valueChanged( editorContentProcessedOnSave || "" );
						xforms.closeAction();
					};
				},
			0);
		}
	}	
};