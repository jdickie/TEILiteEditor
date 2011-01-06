TEI Lite Editor
Project Members:
Susan Brown (sbrown@uoguelph.ca), James Chartrand (jc.chartrand@gmail.com), Grant Dickie (jgrantd@gmail.com), Dave Lester (dave.lester@gmail.com)


Uses TEI-Ann plugin with CKEditor

I. Installing TEI-Ann using oXygen and eXist

Downloaded Dan McCreary's demo setup for eXist. URL (http://www.danmccreary.com/downloads/tei-annotator.zip)

Install eXist Database (http://exist.sourceforge.net/)
* Comes in a jar file that is run with Java (MacOSX wants to use Java Launcher)
* Double-click from Desktop and followed wizard
	* Create password for eXist admin: WORTsich3r
	* Final task: Go to the directory where you installed eXist and call bin/startup.sh.
	* Dir: /Applications/eXist
	* Go to http://localhost:8080/exist/
Next step is to create a 'collection' - not sure what this is and what I'm supposed to do
* first did research by doing all the steps outlined in the Quick Start Guide for eXist

Need to set up oXygen on MacOS and hook it up with eXist:
(Instructions from http://www.oxygenxml.com/doc/ug-oxygen/tasks/configure-exist-datasource.html)
	1.	Go to menu Preferences > Data Sources .
	2.	Click the New button in the Data Sources panel.
	3.	Enter a unique name for the data source.
	4.	Select eXist from the Driver type combo box.
	5.	Press the Add button to add the eXist driver files. The following driver files should be added in the dialog box for setting up the eXist datasource. They are found in the installation directory of the eXist database server. Please make sure you copy the files from the installation of the eXist server where you want to connect from Oxygen.
	◦	exist.jar
	◦	lib/core/xmldb.jar
	◦	lib/core/xmlrpc-client-3.1.1.jar
	◦	lib/core/xmlrpc-common-3.1.1.jar
	◦	lib/core/ws-commons-util-1.0.2.jar
	6.	The version number from the driver file names may be different for your eXist server installation.
	7.	Click the OK button to finish the data source configuration.

THEN:
	1.	Go to menu Preferences > Data Sources .
	2.	Click the New button in the Connections panel.
	3.	Enter a unique name for the connection.
	4.	Select one of the previously configured data sources from the Data Source combo box.
	5.	Fill-in the connection details.
	a.	Set the URI to the installed eXist engine in the XML DB URI field.
	b.	Set the user name in the User field.
	c.	Set the password in the Password field.
	d.	Enter the start collection in the Collection field. eXist organizes all documents in hierarchical collections. Collections are like directories. They are used to group related documents together. This text field allows the user to set the default collection name.
	6.	Click the OK button to finish the connection configuration.

Talk with Dan McCreary:

Wallkthrough for setting up eXist and oXygen

** Admin data input correctly; Needed to include in Connections for eXist the xmldb: prefix and also to have the path be: xmldb:exist://localhost:8080/exist/xmlrpc

- Then, the connection shows up in left-hand corner of oXygen (navigational view for external resources)
-Can create collections from there. A collection is pretty much just a folder to put stuff in 
- Single-add items from HD to the collection in oXygen - can also use program 'Transfer'
*******
Now set up and ready to run in eXist as a webservice on your local machine
*******

II. Setting up TEI-Ann using the README.txt file located in the tei-ann download (http://sourceforge.net/projects/teiann/)
------
Following the instructions included in the INSTALL.html for ckeditor/ and the install.html in tei-ann/
------
After setting up the TEI-Ann plugin inside of ckeditor/, following instructions for the TEI-Ann code found at the TEI-Ann
site under:
http://184.72.253.206/rest/db/dma/apps/tei-annotator/docs/index.xq
------


