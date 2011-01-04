xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Reindex Data Collection'

(: to test this copy 

(
xmldb:login('/db/dma/apps/tei-annotator/data', 'admin', 'admin123'),
xmldb:reindex('/db/dma/apps/tei-annotator/data')
)

into the sandbox.  It should return, true(), true()

:)

let $dp-path := substring-after($style:db-path-to-app-data, 'xmldb:exist://')

let $path-to-config := concat(request:get-context-path(), '/rest/db/system/config', $dp-path, '/collection.xconf')

let $start-time := util:system-time()

let $login-result := xmldb:login('/db/', 'admin', 'admin123')
let $reindex-result := xmldb:reindex($dp-path)

let $end-time := util:system-time()
let $runtime := ($end-time - $start-time)
let $time-in-seconds := substring-before(substring-after(string($runtime), 'PT'), 'S')

let $content :=
<div class="content">

Admin Login Result: {$login-result}<br/>

Reindex Result: {$reindex-result}<br/>

Reindex of data in <a href="{request:get-context-path()}/rest{$dp-path}">{$dp-path}</a> complete in <b>{$time-in-seconds}</b> seconds.<br/>

View index configuration file: <a href="{$path-to-config}">{$path-to-config}</a><br/>
<br/>

</div>

return style:assemble-page($title, $content)