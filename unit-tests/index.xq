xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

let $title := 'Unit Tests for TEI Annotator '

let $unit-test-collection := concat($style:db-path-to-app, '/unit-tests')
let $test-comments := doc(concat($unit-test-collection, '/test-comments.xml'))//test

let $content := 
<div class="content">
      <style type="text/css"><![CDATA[
         thead tr {color: blue; background-color: lightblue; font-weight: bold;}
         .pass, .fail, .unknown {font-weight: bold;}
         .pass {color: green; background-color: white;}
         .fail {color: red; background-color: white;}
         .unknown {color: purple; background-color: white;}
         td {padding: 5px;}
      ]]></style>
      <p>Welcome to the {$title}.</p>
      <p>Test codes: Green=Pass, Red=Fail, Purple=Unknown</p>
      <p>Please test under all browsers and let us know of any browser specific problems.</p>
      <table>
         <thead>
            <tr>
               <th></th>
               <th></th>
               <th colspan="6" style="text-align: center;">Browser Test Results</th>
            </tr>
            <tr>
               <th>Test Name</th>
               <th>Description</th>
               <th>FireFox</th>
               <th>IE 7</th>
               <th>IE 8</th>
               <th>Chrome</th>
               <th>Safari</th>
               <th>Opera</th>
            </tr>
         </thead>
         <tbody>
      {
      for $child in xmldb:get-child-resources($unit-test-collection)
         let $comment := $test-comments[id/text() = $child]/description/text()
         let $status := $test-comments[id/text() = $child]/status
         order by $child
         return
            if (ends-with($child, 'xq') and not($child = 'index.xq')) then 
            <tr>
               <td><a href="{$child}">{$child}</a></td>
               <td>{$comment}</td>
               {for $browser in $status/*
                  return
                  <td>{$browser}</td>
               }
            </tr>
            else ()
      }
      </tbody>
      </table>
</div>

return 
    style:assemble-page($title, $content)
