editAreaLoader.load_syntax["xquery"] = {
	'DISPLAY_NAME' : 'XQuery'
	,'COMMENT_SINGLE' : {}
	,'COMMENT_MULTI' : {'(:' : ':)'}
	,'QUOTEMARKS' : {1: "'", 2: '"'}
	,'KEYWORD_CASE_SENSITIVE' : true
	,'KEYWORDS' : {
		'types' : [
			'xs:yearMonthDuration','xs:unsignedLong','xs:time','xs:string','xs:short','xs:QName','xs:Name','xs:long','xs:integer','xs:int','xs:gYearMonth','xs:gYear','xs:gMonthDay','xs:gDay','xs:float','xs:duration','xs:double','xs:decimal','xs:dayTimeDuration','xs:dateTime','xs:date','xs:byte','xs:boolean','xs:anyURI','xf:yearMonthDuration'
		]
		,'functions' : [
			'example:echo', 'ext:post', 'ext:pre', 'ext:xproc', 'ext:xsltforms', 'ft:optimize', 'ft:query', 'ft:score', 'functions:system-property', 'http-client:decode-content-type', 'http-client:do-send-request', 'http-client:get-response-header', 'http-client:make-attribute', 'http-client:make-body', 'http-client:make-content-items', 'http-client:make-header', 'http-client:make-type-header', 'http-client:send-request', 'httpclient:clear-all', 'httpclient:delete', 'httpclient:get', 'httpclient:head', 'httpclient:options', 'httpclient:post', 'httpclient:post-form', 'httpclient:put', 'json:contents-to-json', 'json:element-helper', 'json:node-to-json', 'json:xml-to-json', 'kwic:callback', 'kwic:display-text', 'kwic:expand', 'kwic:get-context', 'kwic:get-matches', 'kwic:get-summary', 'kwic:string-length', 'kwic:substring', 'kwic:summarize', 'kwic:truncate-following', 'kwic:truncate-previous', 'naming:explicitnames', 'naming:fixup', 'naming:generate-component', 'naming:generate-step', 'naming:get-step', 'naming:pipeline-step-sort', 'naming:preparse-input-bindings', 'naming:preparse-options', 'naming:preparse-output-bindings', 'naming:type', 'ngram:contains', 'ngram:ends-with', 'ngram:filter-matches', 'ngram:starts-with', 'opt:exec', 'opt:hash', 'opt:uuid', 'opt:validate', 'opt:www-form-urldecode', 'opt:www-form-urlencode', 'opt:xquery', 'opt:xsl-formatter', 'request:attribute-names', 'request:exists', 'request:get-attribute', 'request:get-context-path', 'request:get-cookie-names', 'request:get-cookie-value', 'request:get-data', 'request:get-effective-uri', 'request:get-header', 'request:get-header-names', 'request:get-hostname', 'request:get-method', 'request:get-parameter', 'request:get-parameter-names', 'request:get-path-info', 'request:get-query-string', 'request:get-remote-addr', 'request:get-remote-host', 'request:get-remote-port', 'request:get-server-name', 'request:get-server-port', 'request:get-servlet-path', 'request:get-uploaded-file', 'request:get-uploaded-file-data', 'request:get-uploaded-file-name', 'request:get-uploaded-file-size', 'request:get-uri', 'request:get-url', 'request:set-attribute', 'response:exists', 'response:redirect-to', 'response:set-cookie', 'response:set-header', 'response:set-status-code', 'response:stream-binary', 'sequences:filter', 'sequences:fold', 'sequences:map', 'session:clear', 'session:create', 'session:encode-url', 'session:exists', 'session:get-attribute', 'session:get-attribute-names', 'session:get-id', 'session:invalidate', 'session:remove-attribute', 'session:set-attribute', 'session:set-current-user', 'std:add-attribute', 'std:add-xml-base', 'std:compare', 'std:count', 'std:delete', 'std:directory-list', 'std:error', 'std:escape-markup', 'std:filter', 'std:http-request', 'std:identity', 'std:insert', 'std:label-elements', 'std:load', 'std:make-absolute-uris', 'std:namespace-rename', 'std:pack', 'std:parameters', 'std:rename', 'std:replace', 'std:set-attributes', 'std:sink', 'std:split-sequence', 'std:store', 'std:string-replace', 'std:unescape-markup', 'std:unwrap', 'std:wrap', 'std:wrap-sequence', 'std:xinclude', 'std:xslt', 'system:as-user', 'system:clear-trace', 'system:count-instances-active', 'system:count-instances-available', 'system:count-instances-max', 'system:enable-tracing', 'system:ft-index-lookup', 'system:get-build', 'system:get-exist-home', 'system:get-index-statistics', 'system:get-memory-free', 'system:get-memory-max', 'system:get-memory-total', 'system:get-module-load-path', 'system:get-revision', 'system:get-running-jobs', 'system:get-running-xqueries', 'system:get-scheduled-jobs', 'system:get-version', 'system:kill-running-xquery', 'system:restore', 'system:shutdown', 'system:trace', 'system:tracing-enabled', 'system:trigger-system-task', 'system:update-statistics', 'text:filter', 'text:filter-nested', 'text:fuzzy-index-terms', 'text:fuzzy-match-all', 'text:fuzzy-match-any', 'text:groups', 'text:groups-regex', 'text:highlight-matches', 'text:index-terms', 'text:kwic-display', 'text:make-token', 'text:match-all', 'text:match-any', 'text:match-count', 'text:matches-regex', 'text:text-rank', 'transform:stream-transform', 'transform:transform', 'util:add-attribute-matching-elements', 'util:add-attributes-matching-elements', 'util:add-ns-node', 'util:assert', 'util:attrHandler', 'util:base-to-integer', 'util:binary-doc', 'util:binary-doc-available', 'util:binary-to-string', 'util:boolean', 'util:call', 'util:call', 'util:catch', 'util:collations', 'util:collection-name', 'util:comp-available', 'util:compile', 'util:copy-filter-elements', 'util:declare-namespace', 'util:declare-ns', 'util:declare-option', 'util:declare-used-namespaces', 'util:declarens', 'util:deep-copy', 'util:deep-equal-seq', 'util:delete-matching-elements', 'util:describe-function', 'util:disable-profiling', 'util:doctype', 'util:document-id', 'util:document-name', 'util:dynamicError', 'util:enable-profiling', 'util:enum-ns', 'util:eval', 'util:eval', 'util:eval-inline', 'util:eval-with-context', 'util:evalXPATH', 'util:exclusive-lock', 'util:expand', 'util:extract-docs', 'util:filter', 'util:final-result', 'util:function', 'util:get-comp', 'util:get-fragment-between', 'util:get-module-description', 'util:get-option', 'util:get-primary', 'util:get-secondary', 'util:get-sequence-type', 'util:get-step', 'util:hash', 'util:hash', 'util:import-module', 'util:index-key-documents', 'util:index-key-occurrences', 'util:index-keys', 'util:index-keys-by-qname', 'util:index-type', 'util:insert-matching-elements', 'util:integer-to-base', 'util:is-binary-doc', 'util:is-module-registered', 'util:label-matching-elements', 'util:list-used-namespaces', 'util:list-used-namespaces1', 'util:log', 'util:log-app', 'util:log-system-err', 'util:log-system-out', 'util:map', 'util:mapped-modules', 'util:node-by-id', 'util:node-id', 'util:node-xpath', 'util:outputResultElement', 'util:parse', 'util:parse-html', 'util:parse-string', 'util:printstep', 'util:qname-index-lookup', 'util:random', 'util:random', 'util:registered-functions', 'util:registered-modules', 'util:rename-inline-element', 'util:rename-matching-elements', 'util:replace-matching-elements', 'util:safe-evalXPATH', 'util:serialize', 'util:serialize', 'util:shared-lock', 'util:staticError', 'util:step-fold', 'util:stepError', 'util:string-replace-matching-elements', 'util:string-to-binary', 'util:strip-namespace', 'util:system-date', 'util:system-dateTime', 'util:system-property', 'util:system-time', 'util:textHandler', 'util:trace', 'util:treewalker', 'util:treewalker-add-attribute', 'util:type', 'util:unescape-uri', 'util:uniqueid', 'util:unparsed-data', 'util:unwrap-matching-elements', 'util:uuid', 'util:uuid', 'util:validate', 'util:wait', 'util:wrap-matching-elements', 'util:xprocxqError', 'util:xquery', 'util:xquery-with-context', 'util:xslt', 'validation:clear-grammar-cache', 'validation:jaxp', 'validation:jaxp-parse', 'validation:jaxp-report', 'validation:jaxv', 'validation:jaxv-report', 'validation:jing', 'validation:jing-report', 'validation:pre-parse-grammar', 'validation:show-grammar-cache', 'validation:validate', 'validation:validate-report', 'versioning:annotate', 'versioning:apply-patch', 'versioning:diff', 'versioning:doc', 'versioning:find-newer-revision', 'versioning:history', 'versioning:revisions', 'versioning:versions', 'xmldb:authenticate', 'xmldb:change-user', 'xmldb:chmod-collection', 'xmldb:chmod-resource', 'xmldb:collection-available', 'xmldb:copy', 'xmldb:create-collection', 'xmldb:create-user', 'xmldb:created', 'xmldb:decode', 'xmldb:decode-uri', 'xmldb:defragment', 'xmldb:delete-user', 'xmldb:document', 'xmldb:document-has-lock', 'xmldb:encode', 'xmldb:encode-uri', 'xmldb:exists-user', 'xmldb:get-child-collections', 'xmldb:get-child-resources', 'xmldb:get-current-user', 'xmldb:get-current-user-attribute', 'xmldb:get-group', 'xmldb:get-mime-type', 'xmldb:get-owner', 'xmldb:get-permissions', 'xmldb:get-user-groups', 'xmldb:get-user-home', 'xmldb:is-admin-user', 'xmldb:is-authenticated', 'xmldb:last-modified', 'xmldb:login', 'xmldb:move', 'xmldb:permissions-to-string', 'xmldb:register-database', 'xmldb:reindex', 'xmldb:remove', 'xmldb:rename', 'xmldb:set-collection-permissions', 'xmldb:set-resource-permissions', 'xmldb:size', 'xmldb:store', 'xmldb:store-files-from-pattern', 'xmldb:update', 'xmldb:xcollection', 'xproc:catch', 'xproc:choose', 'xproc:declare-step', 'xproc:enum-namespaces', 'xproc:eval-options', 'xproc:eval-outputs', 'xproc:eval-primary', 'xproc:eval-secondary', 'xproc:evalstep', 'xproc:explicitbindings', 'xproc:for-each', 'xproc:generate-component-binding', 'xproc:generate-declare-step-binding', 'xproc:generate-explicit-input', 'xproc:generate-explicit-options', 'xproc:generate-explicit-output', 'xproc:generate-step-binding', 'xproc:genstepnames', 'xproc:get-step', 'xproc:group', 'xproc:library', 'xproc:output', 'xproc:parse_and_eval', 'xproc:pipeline', 'xproc:replace-matching-elements', 'xproc:resolve-data-binding', 'xproc:resolve-document-binding', 'xproc:resolve-empty-binding', 'xproc:resolve-external-bindings', 'xproc:resolve-inline-binding', 'xproc:resolve-non-primary-input-binding', 'xproc:resolve-pipe-binding', 'xproc:resolve-port-binding', 'xproc:resolve-primary-input-binding', 'xproc:resolve-stdin-binding', 'xproc:run', 'xproc:run-step', 'xproc:try', 'xproc:type', 'xproc:viewport', 'xqdm:scan', 'seconds-from-time', 'subsequence', 'string-pad', 'reverse', 'substring', 'substring-after', 'string', 'string-to-codepoints', 'remove', 'round-half-to-even', 'starts-with', 'QName', 'prefix-from-QName', 'position', 'one-or-more', 'number', 'not', 'normalize-unicode', 'normalize-space', 'sum', 'node-name', 'hours-from-duration', 'replace', 'months-from-duration', 'resolve-QName', 'seconds-from-dateTime', 'name', 'month-from-dateTime', 'month-from-date', 'minutes-from-time', 'timezone-from-date', 'minutes-from-duration', 'timezone-from-dateTime', 'true', 'upper-case', 'year-from-date', 'years-from-duration', 'timezone-from-time', 'lower-case', 'local-name-from-QName', 'local-name', 'last', 'lang', 'item-at', 'iri-to-uri', 'insert-before', 'index-of', 'in-scope-prefixes', 'implicit-timezone', 'idref', 'id', 'hours-from-time', 'namespace-uri', 'hours-from-dateTime', 'resolve-uri', 'exactly-one', 'exists', 'namespace-uri-for-prefix', 'escape-uri', 'escape-html-uri', 'error', 'equals', 'ends-with', 'encode-for-uri', 'empty', 'document-uri', 'document', 'doctype', 'doc-available', 'doc', 'distinct-values', 'default-collation', 'deep-equal', 'days-from-duration', 'day-from-dateTime', 'day-from-date', 'dateTime', 'data', 'current-time', 'current-dateTime', 'current-date', 'count', 'contains', 'concat', 'false', 'compare', 'collection', 'codepoints-to-string', 'codepoint-equal', 'ceiling', 'boolean', 'base-uri', 'floor', 'tokenize', 'trace', 'round', 'translate', 'substring-before', 'seconds-from-duration', 'static-base-uri', 'avg', 'adjust-time-to-timezone', 'adjust-dateTime-to-timezone', 'adjust-date-to-timezone', 'abs', 'string-join', 'minutes-from-dateTime', 'string-length', 'nilled', 'unordered', 'min', 'xcollection', 'max', 'year-from-dateTime', 'matches', 'zero-or-one', 'match-any', 'match-all', 'namespace-uri-from-QName', 'root'
		]
 		,'keywords' : [
			'xquery','where','version','variable','union','typeswitch','treat','to','then','text','stable','sortby','some','self','schema','satisfies','returns','return','ref','processing-instruction','preceding-sibling','preceding','precedes','parent','only','of','node','namespace','module','let','item','intersect','instance','in','import','if','function','for','follows','following-sibling','following','external','except','every','else','element','descending','descendant-or-self','descendant','define','default','declare','comment','child','cast','case','before','attribute','assert','ascending','as','ancestor-or-self','ancestor','after'
		]
	}
	,'OPERATORS' :[
		'+', '/', '*', '=', '<', '>', '%', '!', '?', '&'
	]
	,'DELIMITERS' :[
		'(', ')', '{', '}', '[', ']'
	]
	,'REGEXPS' : {
		/*'xml' : {
			'search' : '()(<\\?[^>]*?\\?>)()'
			,'class' : 'xml'
			,'modifiers' : 'g'
			,'execute' : 'before' 
		}
		/*,'cdatas' : {
			'search' : '()(<!\\[CDATA\\[.*?\\]\\]>)()'
			,'class' : 'cdata'
			,'modifiers' : 'g'
			,'execute' : 'before' 
		}
		,*/'tags' : {
			'search' : '(<)(/?[a-z][^ \r\n\t>]*)([^>]*>)'
			,'class' : 'tags'
			,'modifiers' : 'gi'
			,'execute' : 'before' 
		}
		/*,'attributes' : {
			'search' : '( |\n|\r|\t)([^ \r\n\t=]+)(=)'
			,'class' : 'attributes'
			,'modifiers' : 'g'
			,'execute' : 'before' 
		}*/
		,'vars' : {
			'search' : '()(\\$[^\\s|/)};,]+)()'
			,'class' : 'vars'
			,'modifiers' : 'g'
			,'execute' : 'before' 
		}
	}
	,'STYLES' : {
		'COMMENTS': 'color: #aaa;'
		,'QUOTESMARKS': 'color: #0c0;'
		,'KEYWORDS' : {
			'types' : 'color: #2b91af;'
			,'functions' : 'color: #f00;'
			,'keywords' : 'color: #00f;'
			,'vars' : 'color: #900;'
			,'tags' : 'color: #f0f;'
			,'attributes' : 'color: yellow;'
		}
		,'OPERATORS' : 'color: #000;'
		,'DELIMITERS' : 'color: #000;'
		
	},
	'AUTO_COMPLETION': {
		"default": {	// the name of this definition group. It's posisble to have different rules inside the same definition file
		"REGEXP": { "before_word": "[^a-zA-Z0-9_]|^"	// \\s|\\.|
					,"possible_words_letters": "[a-zA-Z0-9_]+"
					,"letter_after_word_must_match": "[^a-zA-Z0-9_]|$"
					,"prefix_separator": "\\.|->"
				}
		,"CASE_SENSITIVE": true
		,"MAX_TEXT_LENGTH": 100		// the length of the text being analyzed before the cursor position
		,"KEYWORDS": [
				// [ 
				// 0 : the keyword the user is typing
				// 1 : the string inserted in code ("{_@_}" being the new position of the cursor)
				// 2 : the needed prefix
				// 3 : the text the appear in the suggestion box (if empty, the string to insert will be displayed
	    		['Array', 'Array()', '', 'alert( String message )']
	    		,['alert', 'alert({_@_})', '', 'alert(message)']
	    		,['ascrollTo', 'scrollTo({_@_})', '', 'scrollTo(x,y)']
	    		,['alert', 'alert({_@_},bouh);', '', 'alert(message, message2)']
	    		,['aclose', 'close({_@_})', '', 'alert(message)']
	    		,['aconfirm', 'confirm({_@_})', '', 'alert(message)']
	    		,['aonfocus', 'onfocus', '', '']
	    		,['aonerror', 'onerror', '', 'blabla']
	    		,['aonerror', 'onerror', '', '']
	    		,['window', '', '', '']
	    		,['location', 'location', 'window', '']
	    		,['document', 'document', 'window', '']
	    		,['href', 'href', 'location', '']
			]
		}
	}
};
