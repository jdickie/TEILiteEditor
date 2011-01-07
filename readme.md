TEI Lite Editor
----------
Project Members:
Susan Brown (sbrown@uoguelph.ca), James Chartrand (jc.chartrand@gmail.com), Grant Dickie (jgrantd@gmail.com), Dave Lester (dave.lester@gmail.com)


Uses TEI-Ann plugin with CKEditor

Guide to the docs/ folder
---
INSTALLeXist.txt : 
* Documentation and notes on installing the Ckeditor with TEI-Ann as a plugin in the oXygen and eXist backend framework. 

INSTALL_NoeXist.txt :
* Documentation on installing Ckeditor and TEI-Ann using the README file included in the downloaded .tar file from 
the TEI-Ann page in SourceForge

Thoughts on the process of developing a TEI Editor using Ckeditor and TEI-Ann
---

Simple pro/con list:
* Pros
	* Very easy-to-use interface
	* Ready-made CSS files
	* oXygen and eXist are both powerful tools used by many in the field
	* CKeditor works with jQuery
* Cons
	* Difficult setup 
		* As the code stands now, the setup requires developers to use oXygen and eXist
		as their backend. That can be advantageous for some programmers, but in this case
		we did not have a suitable backend already in place. This meant a lot of work (See
		INSTALLeXist.txt) to get things started. 
		Once started, everything is running great. However, simple things such as not being
		able to batch-transfer files to eXist collections really makes the process tedious.
	* Code is not well documented
		* This may be another issue that can be solved soon with further development. Right now, 
		it seems that the code is for solving a specific problem in the markup community. With 
		time and further API documentation, it can be improved.
		The documentation page for TEI-Ann should have some examples of setups. The example.xml 
		found with the unpacked code does provide some illumination into how to use the tool,
		but for some people there should preferably be a variety of examples to illustrate best
		practices.
		When I got stuck several times with Javascript errors on my index.xml page that used
		TEI-Ann, my instinct was to go to the source code and debug. I noticed that there was 
		not that much in the way of comments in the code - something that I would suggest to 
		improve, just so that programmers can see the logic behind the code.
	

Crafting a plugin for CKEditor
---

This plan turned out to be the best option for us, since it provided the flexibility and control
that we want out of an editor tool. 


Links:
---

Customizing the CKEditor 

* http://www.voofie.com/content/2/ckeditor-plugin-development/

Documentation TEI-Ann

* http://184.72.253.206/rest/db/dma/apps/tei-annotator/docs/index.xq



