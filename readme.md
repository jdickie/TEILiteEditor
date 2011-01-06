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







