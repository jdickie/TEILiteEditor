/*

Copyright (C) 2009-2010 kuberam.ro - Claudius Teodorescu
Contact at : claud108@yahoo.com

Copyright (C) 2008-2009 <agenceXML> - Alain COUTHURES
Contact at : <info@agencexml.com>

Copyright (C) 2006 AJAXForms S.L.
Contact at: <info@ajaxforms.com>

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

*/
function dataViewer_getModelsIDs()
	{
	var showViewerButtonValue = document.getElementById('showViewerButton').childNodes[0];
	var dataInstancesViewerDiv = document.getElementById('dataInstancesViewerDiv');

	if (showViewerButtonValue.nodeValue == 'Expand Data Instances Viewer')
		{
		showViewerButtonValue.nodeValue = 'Collapse Data Instances Viewer';
		var models = xforms.models;
	
		var modelsOptionString = '';
		var instancesDivString = '';
	
		for (var i=0; i < models.length; ++i)
			{
			var model = models[i];
			var modelId = model.element.id;
			if (modelId != 'xf-model-config' && modelId != 'xf-model-extensions')
				{
				modelsOptionString += '<option value=' + modelId + '>' + modelId + '</option>';
				var modelHTML = document.getElementById(modelId);
				var modelHTMLChildren = modelHTML.getElementsByTagName("span");
				var instancesOptionString = '';
				for (var j=0; j < modelHTMLChildren.length; ++j)
					{
					var instance = modelHTMLChildren[j];
					var instanceType = instance.attributes['class'].nodeValue;
					if (instanceType == 'xforms-instance')
						{
						var instanceId = instance.attributes['id'].nodeValue;
						instancesOptionString += '<option value=' + instanceId + '>' + instanceId + '</option>';
						}
					}
				instancesDivString +=
					'<div id=instancesDiv_' + modelId + '>' +
						'<select id=instancesSelect_' + modelId + ' width="70" onchange="dataViewer_getInstance(this);">' +
							'<option value="selectInstanceId">Select instance id ...</option>' +
							instancesOptionString +
						'</select>' +
					'</div>';
				}
			}
	
		dataInstancesViewerDiv.innerHTML =
			'<div id="modelsSelectDiv">' +
				'<select id="modelsSelect" name="modelsSelect" width="70" onchange="dataViewer_getInstancesIDs(this);">' +
					'<option value="selectModelId">Select model id ...</option>' +
					modelsOptionString +
				'</select>' +
			'</div>' +
			'<div id="instancesDiv">' +
				'<select id="instancesSelect" width="70" onchange="dataViewer_getInstance(this);">' +
					'<option value="selectInstanceId">Select instance id ...</option>' +
				'</select>' + 
			'</div>' +
			'<div id="refreshButtonDiv">' +
				'<button type="button" onclick="var instancesSelect = document.getElementById(\'instancesDiv\').getElementsByTagName(\'select\')[0]; dataViewer_getInstance(instancesSelect);">Refresh data</button>' +
			'</div>' +
			'<div id="showDataInstanceDiv"></div>' +
			'<div id="hiddenInstancesSelectDiv">' +
				instancesDivString
			'</div>';
		dataInstancesViewerDiv.style.display = 'inline';
		}
		else
			{
			dataInstancesViewerDiv.style.display = 'none';
			dataInstancesViewerDiv.innerHTML = '';
			showViewerButtonValue.nodeValue = 'Expand Data Instances Viewer';
			}
	}

function dataViewer_getInstancesIDs(object)
	{
	document.getElementById('showDataInstanceDiv').innerHTML = '';
	var selectedModelId = object.options[object.selectedIndex].value;
	var selectedInstancesDiv = document.getElementById('instancesDiv_' + selectedModelId);
	document.getElementById('instancesDiv').innerHTML = selectedInstancesDiv.innerHTML;
	}

function dataViewer_getInstance(object)
	{
	var modelsSelect = document.getElementById('modelsSelect');
	var selectedModelId = modelsSelect.options[modelsSelect.selectedIndex].value;

	var instanceID = object.options[object.selectedIndex].value;

	var xmlXNode = document.getElementById(instanceID).xfElement.doc;
	var xmlString = Writer.toString(xmlXNode);

	var xsltResult = eXSLTForms_xslt(xmlString, eXSLTForms.utils.baseURI + 'dataInstancesViewer/indentingXSLT.xsl', null);

	if (!Core.isIE)
		{
		var serializer = new XMLSerializer();
		var xsltResult = serializer.serializeToString(xsltResult);
		}
		else {}

	var showDataInstanceDiv = document.getElementById('showDataInstanceDiv');
	showDataInstanceDiv.innerHTML = xsltResult;
	}

eXSLTForms.utils.poll( 'dataInstancesViewerRendering' );