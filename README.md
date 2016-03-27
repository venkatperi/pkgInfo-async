# PkgInfo
  Returns (async) the nearest `package.json` file from a module or directory by searching up the directory tree.

PkgInfo uses the `node-walkup` library do its dir walk up / glob'ing.

## Installation

Install with npm

```
npm install pkginfo-async
```

## Example

```javascript
var pkgInfo = require("pkginfo-async")

pkgInfo(module, function (err, pkg) {
  // err is an error object or null.
  // pkg is the contents of the package.json or null
})
```

## pkgInfo(start, cb)

* `start` `{String | Object}`
  * `{String}` dirname to start looking (upward) from
  * `{Object}` nodejs module object (uses module.filename or module.id) for starting dir
* `cb` `{Function(err, pkg)}`
  * `err` `{Error | null}`
  * `pkg` `{Object | null}` the contents of `package.json`. Null if none found.

Perform an asynchronous search for `package.json` up the dir tree.
* If no file is found, returns null.
* `pkg.dirname` contains the path to the directory where this `package.json` was located.


