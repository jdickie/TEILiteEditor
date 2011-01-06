xquery version "1.0";

(:~   This module uses XQuery 'typeswitch' to do all of the FRUS TEI-to-HTML 
 :      conversion that we previously did with an XSLT stylesheet (frusteidoc2html.xsl).
 :      
 :      To use this, include the module, i.e. 
            import module namespace render = "http://history.state.gov/ns/tei-render" at "/db/history/includes/tei-render.xqm";
 :      and pass the TEI fragment to render:render() as
            render:render($teiFragment, $options)
 :      where $options contains parameters and other info in an element like:
            <parameters>
                <param name="volume" value="{$volume}"/>
                <param name="relativeimagepath" value="{$relativeimagepath}"/>
                <param name="abs-site-uri" value="{$abs-site-uri}"/>
            </parameters>
 :
 :      Author: Joe Wicentowski
 :      Version: 1.0 (Mar 6, 2009)
 :)

(: 
    TODO write a 'test suite' demonstrating each TEI element
    TODO adapt & update comments from the old XSLT
    TODO make function type declarations more uniform
    TODO investigate using html namespace and an XQuery equivalent to the XSL @exclude-result-prefixes
    TODO investigate ways to time which is faster, this or the XSLT
    TODO reexamine cardinality of each function, see if we can't catch coding errors with schema
:)

module namespace render = "http://danmccreary.com/tei-to-html";

(: default namespaces :)
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

(: a helper function in case no options are passed to the function :)
declare function render:render($content as node()*) as element() {
    render:render($content, ())
};

(: creates a document div for fitting TEI into history.state.gov template :)
declare function render:render($content as node()*, $options) as element() {
    <div class="document">
        {
        render:main($content, $options),
        render:note-end($content, $options)
        }
    </div>
};

(: main routine :)
declare function render:main($content as node()*, $options) as item()* {
    for $node in $content/node()
    return 
        typeswitch($node)
            case text() return $node
            case element(tei:TEI) return render:recurse($node, $options)
            case element(tei:text) return render:recurse($node, $options)
            case element(tei:front) return render:recurse($node, $options)
            case element(tei:body) return render:recurse($node, $options)
            case element(tei:back) return render:recurse($node, $options)
            case element(tei:div) return render:div($node, $options)
            case element(tei:head) return render:head($node, $options)
            case element(tei:p) return render:p($node, $options)
            case element(tei:q) return render:q($node, $options)
            case element(tei:hi) return render:hi($node, $options)
            case element(tei:del) return render:del($node, $options)
            case element(tei:list) return render:list($node, $options)
            case element(tei:item) return render:item($node, $options)
            case element(tei:label) return render:label($node, $options)
            case element(tei:ref) return render:ref($node, $options)
            case element(tei:note) return render:note($node, $options)
            case element(tei:dateline) return render:dateline($node, $options)
            case element(tei:persName) return render:persName($node, $options)
            case element(tei:placeName) return render:placeName($node, $options)
            case element(tei:orgName) return render:orgName($node, $options)
            case element(tei:term) return render:term($node, $options)
            case element(tei:closer) return render:closer($node, $options)
            case element(tei:signed) return render:signed($node, $options)
            case element(tei:listBibl) return render:listBibl($node, $options)
            case element(tei:bibl) return render:bibl($node, $options)
            case element(tei:said) return render:said($node, $options)
            case element(tei:listPerson) return render:listPerson($node, $options)
            case element(tei:lb) return <br/>
            case element(tei:figure) return render:figure($node, $options)
            case element(tei:graphic) return render:graphic($node, $options)
            case element(tei:table) return render:table($node, $options)
            case element(tei:row) return render:row($node, $options)
            case element(tei:cell) return render:cell($node, $options)
            case element(tei:geo) return ()
            case element(tei:pb) return render:pb($node, $options)
            default return render:recurse($node, $options)
};

(: just recurses back to render:main() :)
(: DS: live code actually does various stuff here before it recurses :)
declare function render:recurse($node as node(), $options) as item()* {
  render:main($node, $options)
};

declare function render:div($node as element(tei:div), $options) {
        if ($node/@xml:id) then render:xmlid($node, $options) else (),
        if ($node/@type = 'theme-highlight') then <div class="searchformcolor">{render:recurse($node, $options)}</div>
        else render:recurse($node, $options)
};

declare function render:head($node as element(tei:head), $options) as element() {
    if ($node/parent::tei:div) then
        let $type := $node/parent::tei:div/@type
        return
            if ($type = ('section', 'appendix', 'compilation') ) then
                <h6>{render:recurse($node, $options)}</h6>
            else if ($type = ('document', 'subchapter', 'attachment') ) then
                <h6 class="small">{render:recurse($node, $options)}</h6>
            else if ($type = 'attachment') then 
                (<hr/>, render:recurse($node, $options) )
            else (: if ($type = 'timeline') then :)
                <strong>{render:recurse($node, $options)}</strong>
    else if ($node/parent::tei:figure) then
        if ($node/parent::tei:figure/parent::tei:p) then
            <strong>{render:recurse($node, $options)}</strong>
        else (: if ($node/parent::tei:figure/parent::tei:div) then :)
            <p><strong>{render:recurse($node, $options)}</strong></p>
    else if ($node/parent::tei:list) then
        if ($node/parent::tei:list/@type = ('participants', 'subject', 'from', 'references', 'to') ) then
            <li class="subjectallcaps">{render:recurse($node, $options)}</li>
        else if ($node/ancestor::tei:list/@type = ('participants', 'subject', 'from', 'references', 'to') ) then
            <li class="subjectallcaps">{render:recurse($node, $options)}</li>
        else 
            <li>{render:recurse($node, $options)}</li>
    else
        render:recurse($node, $options)
};

(: TODO: Look for instances in the XML of the weird old 'participantcol129' :)
declare function render:p($node, $options) as element() {
    let $rend := $node/@rend
    return 
        if ($rend = (
                    'subjectentry', 'sectiontitleital', 'subjectallcaps',
                    'sourceheadcenterboldbig', 'sourcearchiveboldbig', 'sourceparagraphspaceafter',
                    'sourceparagraphtightspacing', 'sourceparagraphfullindent',
                    'flushleft', 'right', 'center') 
                    ) then
            <p>{ attribute class {data($rend)} }{ render:recurse($node, $options) }</p>
        else if ($rend = 'italic') then
            <p><em>{render:recurse($node, $options)}</em></p>
      (: TODO: Try to handle multi-paragraph footnotes for Forrest 
        else if ($node/parent::tei:note and not($node/preceding-sibling::tei:p)) then
            render:recurse($node, $options)
            :)  
        else
            <p>{render:recurse($node, $options)}</p>
};

declare function render:q($node, $options) as element()* {
    let $rend := $node/@rend
    return 
        if ($rend = 'blockquote') then
            <blockquote>{render:recurse($node, $options)}</blockquote>
        else ()
};

(: known types: italic, strong :)
declare function render:hi($node, $options) as element()* {
    let $rend := $node/@rend
    return
        if ($rend = 'italic') then
            <em>{render:recurse($node, $options)}</em>
        else if ($rend = 'strong') then
            <strong>{render:recurse($node, $options)}</strong>
        else 
            render:recurse($node, $options)
};

declare function render:del($node, $options) as element() {
	let $rend := $node/@rend
	return
		if ($rend = 'strikethrough') then
			<span class="strikethrough">{render:recurse($node, $options)}</span>
		else 
			<span class="strikethrough">{render:recurse($node, $options)}</span>
};

declare function render:list($node, $options) as element() {
    let $type := $node/@type
    return
        if ($type = ('participants', 'subject', 'from', 'to', 'references', 'simple') ) then
            <ul class="subject">{render:recurse($node, $options)}</ul>
        else if ($type = 'index') then
            <ul class="index">{render:recurse($node, $options)}</ul>
        else if ($type = 'indexentry') then
            <ul class='indexentry'>{render:recurse($node, $options)}</ul>
        else if ($type = 'ordered') then (: TODO fix list/label and list/item :)
            <dl class="customorder">{render:recurse($node, $options)}</dl>
        else 
            <ul>{render:recurse($node, $options)}</ul>
};

declare function render:item($node, $options) as element() {
    if ($node/@xml:id) then render:xmlid($node, $options) else (),
    if ($node/parent::tei:list/@type eq 'subject' and $node/parent::tei:list/@rend eq 'flushleft') then 
        (: handles flush left subject lines in 1952-54 volumes, TODO - test when receive first volume :)
        <li class="subjectflushleft">{render:recurse($node, $options)}</li>
    else 
        <li>{render:recurse($node, $options)}</li>
};

declare function render:label($node, $options) as element() {
    if ($node/parent::tei:list) then 
        (
        <dt>{$node/text()}</dt>,
        <dd>{$node/following-sibling::tei:item[1]}</dd>
        )
    else render:recurse($node, $options)
};

declare function render:xmlid($node as element(), $options) as element() {
    <a name="{$node/@xml:id}"/>
};

declare function local:index-of($seq as node()*, $n as node()) as xs:integer* {
    local:index-of($seq, $n, 1)
};

declare function local:index-of($seq as node()*, $n as node(), $i as xs:integer) as xs:integer* {
    if ( empty($seq) ) then
        ()
    else if ( $seq[1] is $n ) then
        ( $i, local:index-of(remove($seq, 1), $n, $i + 1) )
    else
        local:index-of(remove($seq, 1), $n, $i + 1)
};

(: TODO Add handling for <note place="margin"> :)
declare function render:note($node as element(tei:note), $options ) as item()* {
    if ($node/@rend='inline') then
        (: display inline notes inline :)
        (
        if ($node/@xml:id) then render:xmlid($node, $options) else (), 
        <p>{$node}</p>
        )
    else if ($node/@type='summary') then 
        (: suppress ePub summary notes from being displayed :)
        ()
    else if ($node/@n = '0') then
        <a href="{concat('#fn', '-source')}" name="{concat('fnref', '-source')}" class="source-note">
            <sup>Source</sup>
            <span class="footnoteinline">
                {data($node)}
            </span>
        </a>
    else
        let $incr := 
            if ($node/ancestor::tei:div[1][@type='timeline'] | $node/descendant-or-self::tei:div[@type='timeline']) then
                (: check to see if we're in a timeline TEI file, which we display all at once 
                TODO - come up with a better way to 'type' TEI files, perhaps via $options? :)
                xs:integer(local:index-of($node/ancestor::tei:body//tei:note, $node))
            else 
                (: all other files :)
                xs:integer(local:index-of($node/ancestor::tei:div[1]//tei:note, $node))
        return
        <a href="{concat('#fn', $incr)}" name="{concat('fnref', $incr)}">
            <sup>
                {data($node/@n)}
            </sup>
            <span class="footnoteinline">
                {data($node/@n)}.&#160;{data($node) (: TODO find a way to use render:recurse() 
                    that doesn't make the CSS hiccup on span/a/em. Until then we lose styling on 
                    inline footnotes :)} 
            </span>
        </a>, ' ' (: this trailing space is needed until whitespace issues are fully dealt with :)
};

declare function render:note-end($content, $options) as element()* {
    if (exists($content//tei:note[@n])) then 
        <div class="footnotes">
            {
            for $note at $incr in $content//tei:note[@n]
            return 
                if ($note/@type = 'summary') then 
                    (: suppress ePub summary notes from being displayed :)
                    () 
                else if ($note/@n = '0') then
                    <p>
                        <a href="{concat('#fnref', '-source')}" name="{concat('fn', '-source')}" title="Return to text" class="source-note">
                            <sup>*</sup>
                        </a>&#160;{render:recurse($note, $options)}
                    </p>
                else 
                    <p>
                        <a href="{concat('#fnref', $incr)}" name="{concat('fn', $incr)}" title="Return to text">
                            <sup>
                                {data($note/@n)}
                            </sup>
                        </a>&#160;{render:recurse($note, $options)}
                    </p>
            }
        </div>
    else ()
};

declare function render:ref($node, $options) {
    let $target := $node/@target
    let $volume := $options/*:param[@name='volume']/@value
    let $abs-site-uri := $options/*:param[@name='abs-site-uri']/@value
    let $show-page-breaks := $options/*:param[@name='show-page-breaks']/@value
    let $persistent-view := if ($show-page-breaks = 'true') then '/pb' else ()
    let $type := 
        (: added to support class='mini-doc' for theme doc links :)
        if ($node/@type) then attribute class { $node/@type } else ()
    return
        (: catch refs without text :)
        if ($node eq '') then
            let $newnode := element tei:ref { attribute target {$node/@target}, data($node/@target) }
            return
                render:ref($newnode, $options)
        (: route external links through disclaimer :)
        else if (starts-with($target, 'http')) then 
        	(: is it in state.gov domain? :)
            if (matches($target, '^https?://[^.]*?.state.gov')) then
            	element a { 
                    attribute href { $target },
                    attribute title { $target },
                    $type,
                    render:recurse($node, $options) 
                }
            (: otherwise show disclaimer :)
            else 
            	element a { 
                    attribute href { concat('/redirect?url=', xmldb:encode($target)) },
                    attribute title { $target },
                    $type,
                    render:recurse($node, $options) 
                    }
        (: cross-ref to a target in the index :)
        else if (starts-with($target, '#in')) then
            element a { 
                attribute href { concat($abs-site-uri, '/', $volume, '/index', $target, $persistent-view) }, 
                $type,
                render:recurse($node, $options) 
                }
        (: ref to footnote in another document in the same volume:)
        else if (starts-with($target, '#') and contains($target, 'fn')) then
            element a { 
                attribute href { concat($abs-site-uri, $volume, '/', concat(substring-before(substring-after($target, '#'), 'fn'), '#fn', substring-after($target, 'fn'), $persistent-view)) },
                $type,
                render:recurse($node, $options) 
                }
        (: ref to a document/section in the same volume  :)
        else if (starts-with($target, '#')) then
            element a { 
                attribute href { concat($abs-site-uri, $volume, '/', substring-after($target, '#'), $persistent-view) }, 
                $type,
                render:recurse($node, $options) 
                }
        (: ref to a footnote in another volume :)
        else if (contains($target, '#') and contains($target, 'fn')) then
            element a { 
                attribute href { concat($abs-site-uri, $volume, '/', concat(substring-before(substring-after($target, '#'), 'fn'), '#fn', substring-after($target, 'fn')), $persistent-view) }, 
                $type,
                render:recurse($node, $options) 
                }
        (: ref to a subsection of another document :)
        else if (contains($target, '#')) then
            element a { 
                attribute href { concat($abs-site-uri, substring-before($target, '#'), '/', substring-after($target, '#'), $persistent-view) }, 
                $type,
                render:recurse($node, $options) 
                }
        (: just a ref to another volume :)
        else if (starts-with($target, 'frus')) then
            element a { 
                attribute href { concat($abs-site-uri, $target) }, 
                $type,
                render:recurse($node, $options) 
                }
        (: most likely a ref to another section of the website :)
        else 
            element a { 
                attribute href { $target }, 
                $type,
                render:recurse($node, $options) 
                } 
};

declare function render:dateline($node, $options) as element() {
    <p class="dateline">{render:recurse($node, $options)}</p>
};

declare function render:persName($node, $options) {
    if ($node/@xml:id) then render:xmlid($node, $options) else (), 
    render:recurse($node, $options)
};

declare function render:orgName($node, $options) {
    if ($node/@xml:id) then render:xmlid($node, $options) else (), 
    render:recurse($node, $options)
};

declare function render:placeName($node, $options) as item()+ {
    if ($node/@xml:id) then render:xmlid($node, $options) else (), 
    render:recurse($node, $options)
};

declare function render:term($node, $options) {
    if ($node/@xml:id) then render:xmlid($node, $options) else (), 
    render:recurse($node, $options)
};

declare function render:closer($node, $options) as element() {
    <p class="closer">{render:recurse($node, $options)}</p>
};

declare function render:signed($node, $options) as element() {
	<span class="signed">{render:recurse($node, $options)}</span>
};

declare function render:listBibl($node, $options) as element() {
    <ul class="bibl">{render:recurse($node, $options)}</ul>
};

declare function render:bibl($node, $options) as element() {
    <li>{render:recurse($node, $options)}</li>
};

declare function render:said($node, $options) as element() {
    <p class="said">{data($node/@who)}: {render:recurse($node, $options)}</p>
};

declare function render:listPerson($node, $options) as element() {
    let $type := $node/@type
    return
        if ($node/tei:person) then
            <ul>{render:recurse($node, $options)}</ul>
        else 
            <ul><li>{data($type)}: {render:recurse($node, $options)}</li></ul>
};

declare function render:person($node, $options) as element() {
    <li>{render:recurse($node, $options)}</li>
};

declare function render:figure($node, $options) {
    let $class := if ($node/@rend = 'smallfloatinline') then 'image-smallfloatinline' else 'image-wide'
    return
        if ($node/parent::tei:p) then 
            <span class="{$class}">{render:recurse($node, $options)}</span>
        else
            <div class="{$class}">{render:recurse($node, $options)}</div>
};

declare function render:graphic($node, $options) {
    let $url := $node/@url
    let $head := $node/following-sibling::tei:head
    let $relativeimagepath := $options/*:param[@name='relativeimagepath']/@value
    return
        (
        <img src="{concat($relativeimagepath, $url)}" alt="{normalize-space($head)}" class="image_border"/>,
        render:recurse($node, $options)
        )
};
declare function render:table($node, $options) as element() {
    <table>{render:recurse($node, $options)}</table>
};

declare function render:row($node, $options) as element() {
    let $label := $node/@role[. = 'label']
    return
        <tr>{if ($label) then attribute class {'label'} else ()}{render:recurse($node, $options)}</tr>
};

declare function render:cell($node, $options) as element() {
    let $label := $node/@role[. = 'label']
    return
        <td>{if ($label) then attribute class {'label'} else ()}{render:recurse($node, $options)}</td>
};

declare function render:pb($node as element(tei:pb), $options) {
    if ($options/*:param[@name='show-page-breaks']/@value = 'true') then
        let $volume := $options/*:param[@name='volume']/@value
        let $abs-site-uri := $options/*:param[@name='abs-site-uri']/@value
        let $pagenumber := data($node/@n)
        let $facs := data($node/@facs)
        return 
            <span class="pagenumber">
                {
                if ($facs) then
                    element a {
                    attribute href {concat($abs-site-uri, $volume, '/media/medium/', $facs, '.png')},
                    attribute title {concat('Page ', $pagenumber)},
                    (: attribute class {"thickbox"},
                    attribute rel {"inline"}, :)
                    <img src="/images/mag-glass.gif" height="16px" />,
                    concat('Page ', $pagenumber)
                    }
                else concat('Page ', $pagenumber)
                }
            </span>
    else ()
};

(: render:create-toc(): Some additional functions to create the TOC for use in left sidebars :)

(: create the TOC for use by the left sidebar :)
declare function render:create-toc($tei-text, $web-path-to-page-view, $view, $id) {
    <div id="toc" class="bordered">
        <ul>{render:toc-recurse($tei-text, $web-path-to-page-view, $view, $id)}</ul>
    </div>
};

(: the central recursive typeswitch function for handling TOCs :)
declare function render:toc-recurse($node, $web-path-to-page-view, $view, $id) {
    for $node in $node/node()
    return 
        typeswitch($node)
            case element(tei:div) return render:toc-div($node, $web-path-to-page-view, $view, $id)
            case element(tei:head) return render:toc-head($node, $web-path-to-page-view, $view, $id)
            default return render:toc-recurse($node, $web-path-to-page-view, $view, $id)
};

(: handles divs for TOCs :)
declare function render:toc-div($node as element(tei:div), $web-path-to-page-view, $view, $id) {
      (: we only show divs that have @xml:id attributes :)
      if ($node/@xml:id) then
           (: check the $id to see if it was passed the 'show!first!div' parameter, 
              in which case we want to highlight the first div, so
              we set $id to the value of the first div's @xml:id attribute :)
           let $id := if ($id eq 'show!first!div') then ($node/ancestor::tei:text//tei:div[@xml:id])[1]/@xml:id else $id
           (: highlight the div if it matches $id :)
           let $highlight := if ($node/@xml:id eq $id or ($node/@xml:id eq 'foreword' and not($id) and $view ne 'about')) then attribute class {'highlight'} else ()
           return
                (: handle funky milestones toc, aka 'accordion' toc :)
                if (contains(util:collection-name($node), 'milestones')) then 
                    (: milestones landing page - just show article titles :)
                    if ($view eq 'about') then 
                          (: the article titles are the div nodes whose xml:id is 'foreword' :)
                          if ($node/@xml:id eq 'foreword') then
                              <li>
                                  <a href="{concat($web-path-to-page-view, replace(util:document-name($node), '.xml$', ''))}">{$highlight}
                                      {render:toc-recurse($node, $web-path-to-page-view, $view, $id)}
                                  </a>
                              </li>
                          else 
                              ()
                    (: interior pages, showing the contents of the period defined in $view :)
                    else
                       let $period := replace(util:document-name($node), '.xml$', '')
                       let $article := 
                            (: suppress 'foreward' from being appended to the URL:)
                            if ($node/@xml:id/string() eq 'foreword') then () 
                            else $node/@xml:id/string()
                       return
                       <li>
                           <a href="{concat($web-path-to-page-view, $period, '/', $article)}">{$highlight}
                               {render:toc-recurse($node, $web-path-to-page-view, $view, $id)}
                           </a>
                       </li>
                
                (: this is unused code for a collection-wide accordion TOC view, 
                   instead of the single-doc accordion TOC view used in the milestones section :)
                (: else 
                        if ($node/parent::tei:front) then 
                          (: override the highlight so it's just for the current tei doc, not all :)
                          let $highlight := if (not($id) and $view eq replace(util:document-name($node), '.xml$', '')) then attribute class {'highlight'} else ()
                          return
                               <li>
                                   <a href="{concat($web-path-to-page-view, replace(util:document-name($node), '.xml$', ''))}">{$highlight}
                                       {render:toc-recurse($node, $web-path-to-page-view, $view, $id)}
                                   </a>
                                   {
                                   if ($view eq replace(util:document-name($node), '.xml$', '')) then 
                                       <ul>
                                           {render:toc-recurse($node/ancestor::tei:text/tei:body, $web-path-to-page-view, $view, $id)}
                                       </ul>
                                   else ()
                                   }
                               </li>
                        (: if the div doesn't contain child divs, just show the single list item :)
                        else 
                               <li>
                                   <a href="{concat($web-path-to-page-view, replace(util:document-name($node), '.xml$', ''), '/', $node/@xml:id/string())}">{$highlight}
                                       {render:toc-recurse($node, $web-path-to-page-view, $view, $id)}
                                   </a>
                               </li>
                :)
                
                
                (: the top level of our TOC should only contain the top level divs :)
                else if ($node = $node/ancestor::tei:text/(tei:front | tei:body | tei:back)/tei:div) then
                    (: if the div contains child divs, nest them into a new list :)
                    if ($node/tei:div[@xml:id]) then 
                        <li>
                            <a href="{concat($web-path-to-page-view, $view, '/', $node/@xml:id/string())}">{$highlight}
                                {$node/tei:head/text()}
                            </a>
                            <ul>
                                {render:toc-recurse($node, $web-path-to-page-view, $view, $id)}
                            </ul>
                        </li>
                    (: if the div doesn't contain child divs, just show the single list item :)
                    else 
                        <li>
                            <a href="{concat($web-path-to-page-view, $view, '/', $node/@xml:id/string())}">{$highlight}
                                {render:toc-recurse($node, $web-path-to-page-view, $view, $id)}
                            </a>
                        </li>
                (: show non-top level divs as leaf-level list items :)
                else
                    <li>
                        <a href="{concat($web-path-to-page-view, $view, '/', $node/@xml:id/string())}">{$highlight}
                            {render:toc-recurse($node, $web-path-to-page-view, $view, $id)}
                        </a>
                    </li>
       (: don't show divs that don't have @xml:id attributes :)
       else ()
};

(: handles heads for TOCs :)
declare function render:toc-head($node as element(tei:head), $web-path-to-page-view, $view, $id) {
       (: only handle heads whose parent is a div :)
       if ($node/parent::tei:div) then 
            (: handle funky milestones toc, aka 'accordion' toc :)
            if (contains(util:collection-name($node), 'milestones')) then
                (: milestones landing page should only show the date :)
                if ($view eq 'about') then 
                    $node/tei:date/text()
                (: milestones entries should show the full title :)
                else 
                    data($node)
            (: don't bother showing the head "again" in the case where its parent div has already shown it :)
            else if ($node/parent::tei:div/child::tei:div/@xml:id) then 
                ()
            (: MOST CASES: show the text of the head :)
            else 
                $node/text()
       (: don't show heads whose parents aren't divs, e.g. graphics and figures :)
       else ()
};