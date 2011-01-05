A. SCOPE
1. Description
tei-ann is a plugin for CKEditor (http://ckeditor.com/) designated to annotate texts in TEI format.
It works by converting the TEI elements to tei-ann "elements" (span elements having appropriate attributes),
so that the user can easily recognise TEI elements already presented in text and annotate the text using 
new TEI elements. The plugin can be easily extended in order to use new TEI elemets.
This plugin was originally developed for the U.S. Department of State, Office of the Historian, 
and released as open source for the benefit of commnuity.

2. Plugin's languages
The plugin's default language is English. For other languages, copy the 
$CKEDITOR_HOME/plugins/tei-ann/config/lang/en.xml file with a new name, of type
<language abbreviation>.xml, and add the new language's abbreviation
to "availableLangs" section of $CKEDITOR_HOME/plugins/tei-ann/config/generalConfigOptions.xml file.


B. INSTALLATION
1. Prerequisites
a. Install the XSLTForms processor (http://agencexml.com/xsltforms.htm).
b. Install CKEditor (http://ckeditor.com/).
c. Install eXSLTForms (http://sourceforge.net/projects/extxsltforms/).
Notes:
a. XSLTForms processor is needed as the tei-ann annotator is meant to be used in XForms forms.
b. eXSLTForms integrates CKEditor into the XSLTForms processor.
c. CKEditor is needed to actually annotate the TEI documents.

2. Installation of the plugin
a. Copy the tei-ann folder from the plugin's archive to $CKEDITOR_HOME/plugins.
b. Edit $CKEDITOR_HOME/plugins/tei-ann/config/generalConfigOptions.xml file, in order to
provide the absolute path to Annotator-Specifications.xml file, which contains detailed
description of each TEI annotator.
c. Edit $CKEDITOR_HOME/plugins/tei-ann/config/generalConfigOptions.xml file, in order to
provide the absolute path to tei-entities.css file, which contains detailed
description of each TEI annotator' style (how it will be rendered within the editor).
d. Based on the indications given by CKEditor's documentation on how to configure the editor,
and by eXSLTForms' documentations on how to use CKEditor, one should include in each page
designated to host an editor with tei-ann plugin the configuration option (see $CKEDITOR_HOME/example.xml
for an example). One should pay attention that each TEI annotator is represented within the editor
as a button. Thus, the configuration options in each page should contain, as elements of 'toolbar'
array, the id for each needed annotator (the annotator ids are referenced to in Annotator-Specifications.xml).


C. DESCRIPTION OF ANNOTATORS
1. Generalities
a. The annotators are defined in $CKEDITOR_HOME/plugins/tei-ann/config/Annotator-Specifications.xml
file.
b. The user interface elements are defined in $CKEDITOR_HOME/plugins/tei-ann/config/lang/en.xml, or other file, according to
choosen language - for examples of usage, see below.
c. One has to provide for each annotator an unique id (@id), a name (@name), which is the corresponding TEI
element name, and a type code (@typeCode), which is the type of the respective annotator.
In order to provide a correct order of resulting TEI elements, one has to provide for each annotator the
name of the parent and preceding sibling TEI elements (AnnotatorPossibleParentElementNames and
AnnotatorPossiblePrecedingSiblingElementNames).
Also, for each annotator has to be provided the description of each attribute of the respective TEI
element (if any), according to examples, and the name for annotator's icon (this is the icon that will
appear on the CKEditor's toolbar; the respective file should be located into 
$CKEDITOR_HOME/plugins/tei-ann/images folder).
In case when the annotator pops up to user a dialog panel, the respective panel and its tabs has to
be defined according to the examples below. Principially speaking, this plugin allows user, by means
of an panel (for certain annotators), to attach desired fragments of text to the respective TEI element's
attributes. For this, each panel has text fields and/or lists, having their values as result of a query
to a server or not; each text field/list is thus attached to a TEI element's attribute and its content
can be validated against a regular expression contained by AnnotatorPanelFieldValidationRegex element.
The labels for each text fiels/list are defined in the respective language file.
Note that the annotators of "selected-wrap-server" type have a common panel definition, which is
entered separately into Annotator-Specifications.xml file.
d. The annotators' user interface elements have to closely follow the annotator definition, namely to have
the same id (@id). Also, one has to define the text that will appear when user hovers over the annotator's
button (ToolbarButtonTitle).

2. Types of annotators
a. insert
b. insert-parametrized
c. selected-wrap
d. selected-wrap-parameterized
e. selected-wrap-server
f. insert-split

3. Description of annotator types
a. Annotator of "insert" type. This type of annotator include the TEI elements that are simply inserted into
text.
Example of annotator definition:
    <Annotator id="teiannLineBreakBtn" name="lb" typeCode="insert">
        <AnnotatorPossibleParentElementNames>teiHeader p div</AnnotatorPossibleParentElementNames>
        <AnnotatorPossiblePrecedingSiblingElementNames/>
        <AnnotatorAttribute/>
        <AnnotatorIconName>lineBreak.gif</AnnotatorIconName>
        <InsertEntityKey/>
        <ClearEntityKey/>
    </Annotator>
Example of annotator's UI definition:
    <Annotator id="teiannLineBreakBtn">
        <ToolbarButtonTitle>Insert a line break.</ToolbarButtonTitle>
    </Annotator>

b. Annotator of "insert-parametrized" type. This type of annotator is similar to "insert" type annotators,
with the difference that the corresponding TEI element has attributes, which are the annotator's parameters;
these parameters can be set in a dialog panel.
Example of annotator definition:
    <Annotator id="teiannPageBreakBtn" name="pb" typeCode="insert-parametrized">
        <AnnotatorPossibleParentElementNames>teiHeader p div</AnnotatorPossibleParentElementNames>
        <AnnotatorPossiblePrecedingSiblingElementNames/>
        <AnnotatorIconName>pageBreak.gif</AnnotatorIconName>
        <AnnotatorAttribute>n</AnnotatorAttribute>
        <AnnotatorAttribute>xml:id</AnnotatorAttribute>
        <AnnotatorAttribute>facs</AnnotatorAttribute>
        <InsertEntityKey/>
        <ClearEntityKey/>
        <AnnotatorPanel>
            <AnnotatorPanelMinHeight>500px</AnnotatorPanelMinHeight>
            <AnnotatorPanelMinWidth>500px</AnnotatorPanelMinWidth>
            <AnnotatorPanelTab id="teiannPageBreakBtnTab1">
                <AnnotatorPanelField id="teiannPageBreakN">
                    <AnnotatorPanelFieldRef>@n</AnnotatorPanelFieldRef>
                    <AnnotatorPanelFieldValidationRegex/>
                </AnnotatorPanelField>
                <AnnotatorPanelField id="teiannPageBreakID">
                    <AnnotatorPanelFieldRef>@xml:id</AnnotatorPanelFieldRef>
                    <AnnotatorPanelFieldValidationRegex/>
                </AnnotatorPanelField>
                <AnnotatorPanelField id="teiannPageBreakFacs">
                    <AnnotatorPanelFieldRef>@facs</AnnotatorPanelFieldRef>
                    <AnnotatorPanelFieldValidationRegex/>
                </AnnotatorPanelField>
            </AnnotatorPanelTab>
        </AnnotatorPanel>
    </Annotator>
Example of annotator's UI definition:
    <Annotator id="teiannPageBreakBtn">
	    <ToolbarButtonTitle>Insert a page break with three attributes.</ToolbarButtonTitle>
	    <AnnotatorPanel>
		    <AnnotatorPanelTitle>Page Break Attributes</AnnotatorPanelTitle>
		    <AnnotatorPanelTab id="teiannPageBreakBtnTab1">
			    <AnnotatorPanelTabTitle>Page Break Attributes</AnnotatorPanelTabTitle>
			    <AnnotatorPanelField>
				    <AnnotatorPanelTabElement id="teiannPageBreakNLabel" for="teiannPageBreakN" type="label">N</AnnotatorPanelTabElement>
				    <AnnotatorPanelTabElement id="teiannPageBreakIDLabel" for="teiannPageBreakID" type="label">XML ID</AnnotatorPanelTabElement>
				    <AnnotatorPanelTabElement id="teiannPageBreakFacsLabel" for="teiannPageBreakFacs" type="label">FACS</AnnotatorPanelTabElement>
			    </AnnotatorPanelField>
		    </AnnotatorPanelTab>
	    </AnnotatorPanel>
    </Annotator>

c. Annotator of "selected-wrap" type. This type of annotator is used for the TEI elements needed for styling
(bold, italic, etc.).
Example of annotator definition:
    <Annotator id="teiannBoldBtn" name="hi" typeCode="selected-wrap">
        <AnnotatorPossibleParentElementNames>teiHeader p div</AnnotatorPossibleParentElementNames>
        <AnnotatorPossiblePrecedingSiblingElementNames/>
        <AnnotatorIconName>bold.gif</AnnotatorIconName>
        <AnnotatorAttribute name="rend" value="strong"/>
        <InsertEntityKey/>
        <ClearEntityKey/>
    </Annotator>
Example of annotator's UI definition:
    <Annotator id="teiannBoldBtn">
        <ToolbarButtonTitle>Insert bold style.</ToolbarButtonTitle>
    </Annotator>

d. Annotator of "selected-wrap-parameterized" type. This type of annotator is similar to "selected-wrap" type
annotators, with the difference that the corresponding TEI element has attributes, which are the annotator's
parameters; these parameters can be set in a dialog panel.
Example of annotator definition:
    <Annotator id="teiannDateBtn" name="date" typeCode="selected-wrap-parameterized">
        <AnnotatorIconName>calendar.png</AnnotatorIconName>
        <AnnotatorPossibleParentElementNames>teiHeader p div</AnnotatorPossibleParentElementNames>
        <AnnotatorPossiblePrecedingSiblingElementNames/>
        <AnnotatorAttribute name="when" value=""/>
        <AnnotatorAttribute name="when2" value=""/>
        <InsertEntityKey/>
        <ClearEntityKey/>
        <AnnotatorPanel>
            <AnnotatorPanelMinWidth>400</AnnotatorPanelMinWidth>
            <AnnotatorPanelMinHeight>200</AnnotatorPanelMinHeight>
            <AnnotatorPanelTab id="teiannDateBtnTab1">
                <AnnotatorPanelField id="teiannDateWhen">
                    <AnnotatorPanelFieldRef>@when</AnnotatorPanelFieldRef>
                    <AnnotatorPanelFieldValidationRegex>^\d{4}\-\d{2}\-\d{2}$</AnnotatorPanelFieldValidationRegex>
                </AnnotatorPanelField>
                <AnnotatorPanelTabHtmlContent>
			&lt;style type="text/css"&gt; 
			#teiannDateBtnDiv {width:100%;height:200px;} 
			#teiannDateBtnDiv label {float:left;font-weight:bold;width:25%;} 
			#teiannDateWhen {float:left;border:1px solid #a0a0a0;width:50%;background-color: white;margin-right:40px;} 
			&lt;/style&gt; 
			&lt;div id="teiannDateBtnDiv"&gt; 
			&lt;label for="teiannDateWhen" id="teiannDateWhenLabel"&gt;&lt;/label&gt; 
			&lt;input id="teiannDateWhen" type="text"/&gt; 
			&lt;/div&gt;
		</AnnotatorPanelTabHtmlContent>
            </AnnotatorPanelTab>
            <AnnotatorPanelTab id="teiannDateBtnTab2">
                <AnnotatorPanelField id="teiannDateWhen2">
                    <AnnotatorPanelFieldRef>@when2</AnnotatorPanelFieldRef>
                    <AnnotatorPanelFieldValidationRegex/>
                </AnnotatorPanelField>
                <AnnotatorPanelTabHtmlContent>
			    &lt;style type="text/css"&gt; 
			    #teiannDateBtnDiv2 {width:100%;height:200px;} 
			    #teiannDateBtnDiv2 label {float:left;font-weight:bold;width:25%;} 
			    #teiannDateWhen2 {float:left;border:1px solid #a0a0a0;width:50%;background-color: white;margin-right:40px;} 
			    &lt;/style&gt; 
			    &lt;div id="teiannDateBtnDiv2"&gt; 
			    &lt;label for="teiannDateWhen2" id="teiannDateWhen2Label"&gt;&lt;/label&gt; 
			    &lt;input id="teiannDateWhen2" type="text"/&gt; 
			    &lt;/div&gt;
		    </AnnotatorPanelTabHtmlContent>
            </AnnotatorPanelTab>
        </AnnotatorPanel>
    </Annotator>
Example of annotator's UI definition:
    <Annotator id="teiannDateBtn">
        <ToolbarButtonTitle>Date</ToolbarButtonTitle>
        <AnnotatorPanel>
            <AnnotatorPanelTitle>Enter date in format YYYY-MM-DD</AnnotatorPanelTitle>
            <AnnotatorPanelTab id="teiannDateBtnTab1">
                <AnnotatorPanelTabTitle>Date</AnnotatorPanelTabTitle>
                <AnnotatorPanelTabElement id="teiannDateWhenLabel" for="teiannDateWhen" type="label">Enter date: </AnnotatorPanelTabElement>
            </AnnotatorPanelTab>
            <AnnotatorPanelTab id="teiannDateBtnTab2">
                <AnnotatorPanelTabTitle>Date2</AnnotatorPanelTabTitle>
                <AnnotatorPanelTabElement id="teiannDateWhen2Label" for="teiannDateWhen2" type="label">Enter date2: </AnnotatorPanelTabElement>
            </AnnotatorPanelTab>
        </AnnotatorPanel>
    </Annotator>
Note: Each annotator has to have a definition of the dialog panel's content, which is to
be contained by "AnnotatorPanelTabHtmlContent" element, as encoded html markup.

e. Annotator of "selected-wrap-server" type. This type of annotator is similar to "selected-wrap-parameterized"
type annotators, with the difference that the values of the corresponding TEI elements' attributes are set based
upon a query sent to a server.
Example of annotator definition:
    <Annotator id="teiannPersonBtn" name="persName" typeCode="selected-wrap-server">
        <AnnotatorIconName>person.png</AnnotatorIconName>
        <AnnotatorIDServiceURI>http://localhost:8080/webApps/suggest-person.xql?test=</AnnotatorIDServiceURI>
        <AnnotatorPossibleParentElementNames>teiHeader p div</AnnotatorPossibleParentElementNames>
        <AnnotatorPossiblePrecedingSiblingElementNames/>
        <AnnotatorAttribute name="corresp" value=""/>
        <InsertEntityKey/>
        <ClearEntityKey/>
    </Annotator>
Example of annotator's UI definition:
    <Annotator id="teiannPersonBtn">
        <ToolbarButtonTitle>Person</ToolbarButtonTitle>
        <AnnotatorPanel>
            <AnnotatorPanelTitle>Person</AnnotatorPanelTitle>
        </AnnotatorPanel>
    </Annotator>
Notes:
i. The dialog panel for this type of annotator has a standard format, which is definned by the "selected-wrap-server"
element in Annotator-Specifications.xml file. Thus, one has only to define the annotator's UI definition.
ii. In Annotator-Specifications.xml, the first attribute for annotators of this type, will automatically receive
the value selected by user from the results returned by server.

e. Annotator of "insert-split" type. This type of annotator is used for the TEI elements that are inserted
into text by "splitting" an existing TEI element, thus resulting two of such existing TEI elements.
Example of annotator definition:
    <Annotator id="teiannParagraphBtn" name="p" typeCode="insert-split">
        <AnnotatorPossibleParentElementNames>teiHeader p div</AnnotatorPossibleParentElementNames>
        <AnnotatorPossiblePrecedingSiblingElementNames/>
        <AnnotatorAttribute/>
        <AnnotatorIconName>paragraph.gif</AnnotatorIconName>
        <InsertEntityKey/>
        <ClearEntityKey/>
    </Annotator>
Example of annotator's UI definition:
    <Annotator id="teiannParagraphBtn">
        <ToolbarButtonTitle>Insert a paragraph.</ToolbarButtonTitle>
    </Annotator>