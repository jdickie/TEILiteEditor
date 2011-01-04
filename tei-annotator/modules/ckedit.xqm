module namespace ckedit = "http://danmccreary.com/ckedit";

declare namespace util = "http://exist-db.org/xquery/util";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare function functx:change-element-ns-deep($nodes as node()*, $newns as xs:string, $prefix as xs:string )  as node()* {    
  for $node in $nodes
  return if ($node instance of element())
         then (element
               {QName ($newns,
                          concat($prefix,
                                    if ($prefix = '')
                                    then ''
                                    else ':',
                                    local-name($node)))}
               {$node/@*,
                functx:change-element-ns-deep($node/node(),
                                           $newns, $prefix)})
         else if ($node instance of document-node())
         then functx:change-element-ns-deep($node/node(),
                                           $newns, $prefix)
         else $node
 } ;

(: this is used to copy in instance but escape the nodes with a given element name such as 'answer' :)
declare function ckedit:copy-filter-elements($node as element(), $element-name as xs:string) as item() {
   if (string(name($node))=$element-name)
      then
         (: create an element that contains an escaped div as the root and all the nodes inside this escapted :)
         element {node-name($node)} 
                 { string-join( ('&lt;div&gt;',
                           for $n in $node/(* | text()) return ckedit:escape-node($n),
                           '&lt;/div&gt;')
                          , '')
                 }
         
      else
      element {node-name($node)}
              { $node/@*,
               for $child in $node/node()
                  return if ($child instance of element())
                    then ckedit:copy-filter-elements($child, $element-name)
                    else $child           
           }
};

declare function ckedit:escape-node($n as node()) as xs:string {
   typeswitch($n)
      case $e as element()
         return
            string-join(
               ('&lt;', local-name($e), 
               for $a in $e/@*
                  return concat(' ', local-name($a), '="', $a, '"'),
               '&gt;',
               for $c in $e/(* | text())
                  return ckedit:escape-node($c),
                 '&lt;/', local-name($e), '&gt;'
                ), '')   
      default return $n
 };

(: this function will remove the front <div> tag and the trailing </div> tag from an input string and return another string :)
declare function ckedit:strip-div-wrapper($input as xs:string) as xs:string {
let $prefix := substring($input, 1, 5)
return 
   if (contains($prefix, '<div>'))
      then
         let $skip-prefix := substring($input, 6)
         let $skip-prefix-length := string-length($skip-prefix)
         return substring($skip-prefix, 1, $skip-prefix-length - 6)
      else $input
};

(: this is a safe version of the util:parse() function that will not crash the server. It should be not be used after the update function has been fixed.  :)
declare function ckedit:parse($input as xs:string) as node() {
   util:parse(concat('<dummy>', $input, '</dummy>'))/dummy/*
};

(: this function will remove the front <div> tag and the trailing </div> tag from an input string and return another string :)
declare function ckedit:convert-to-tei-namespace($input-nodes as node()*) as node()* {
  functx:change-element-ns-deep($input-nodes, 'http://www.tei-c.org/ns/1.0', 'tei' )
};