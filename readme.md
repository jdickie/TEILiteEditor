TEI Lite Editor
Project Members:
Susan Brown (sbrown@uoguelph.ca), James Chartrand (jc.chartrand@gmail.com), Grant Dickie (jgrantd@gmail.com), Dave Lester (dave.lester@gmail.com)


Uses TEI-Ann plugin with CKEditor

Note: We successfully attempted to install the program using oXygen and eXist, but 
decided that the best way forward was for a more web-friendly version that didn't 
require Java. 
For information on installing a TEI-Ann framework in eXist and oXygen, take a look at docs/INSTALLeXist.txt

------
Setting up TEI-Ann using the README.txt file located in the tei-ann download (http://sourceforge.net/projects/teiann/)
------
Following the instructions included in the INSTALL.html for ckeditor/ and the install.html in tei-ann/

After setting up the TEI-Ann plugin inside of ckeditor/, following instructions for the TEI-Ann code found at the TEI-Ann
site under:
http://184.72.253.206/rest/db/dma/apps/tei-annotator/docs/index.xq

* Download the tei-annotator.zip from danmccreary.com
* Copy the files from tei-annotator/utils/* into TEILiteEditor/plugins/


* Index.html needs to be converted in Xhtml
- Copied and pasted from the index.xq page of instructions in 'Customizing the textarea'
- Analyzing examples from tei-ann folder - copied over elements for <body> and header options
	from tei-ann/example.xml
	* Going to customize the example.xml

* Installing xforms 
	- Installed on Firefox 3.6.13
	- Searched for Add-ons 'Xforms' - installed and restarted
	- Now some textareas appear on the index.xml

* Reached error in Firefox: 
Error loading stylesheet: A network error occured loading an XSLT stylesheet:http://localhost:8888/rest/db/dma/apps/tei-annotator/utils/exsltforms/exsltforms.xsl
	* Possible Solution: Have to edit the Annotator-Specifications.xml
		* For each <AnnotatorIDServiceURI>, have to change URI from REST format to localhost format: /rest/db/dma/apps/ to http://localhost:8888/TEILiteEditor/
		* May need to copy over tei-annotator/ files into root directory
	* Also found REST URI in the TEILiteEditor/plugins/exsltforms/eXSLTFormsConfigOptions.xml
	* Also found REST URI in TEILiteEditor/plugins/xsltforms/xsltforms.xsl

* Add <script> reference to plugins/ckeditor in index.xml
	





