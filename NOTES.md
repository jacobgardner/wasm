
### Uses For Webassembly

 * Non-javascript, isomorphic development
 * Saving the trees
 * Saving some time
 * Videogames
 * Math-heavy applications 

## FAQ

### Could you convert something like lodash to web assembly?

For the most part, not for any real benefit, probably.  Most of lodash's functionality is around javascript arrays/objects.  These data structures are completely foreign to webassembly.  Passing an array to webassembly involves forcing all the elements into an array buffer.  You would need to encode the lengths, the data type, and the value converted to a series of integers.  When that's all done, web assembly could operate on the collection (probably in many cases much quicker than the javascript version), and then you'd have to convert these objects back to javascript.  So in many cases the process and overhead of converting your complex types to/from wasm is going to match or exceed the original operation.  That said, I haven't actually tried it and I'm interested to see what happens.

### What would be good? 

* Math libraries -> Matrix maths
