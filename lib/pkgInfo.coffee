walkup = require( 'node-walkup' )
path = require( 'path' )
Q = require 'q'
fs = require( 'fs' )

# "denodeify" fs.readFile to return a promise
readFile = Q.denodeify fs.readFile

# We load the package.json asynchronously and parse it with
# JSON.parse. We also add a new field `dirname` to indicate
# the directory where we found this `package.json`
loadPkgFile = ( filename ) ->
  readFile filename
  .then ( data ) ->
    pkg = JSON.parse data
    pkg.dirname = path.dirname filename
    pkg

module.exports = ( dir, cb ) ->
  # `dir` could be a module or a string
  dir = path.dirname( dir.filename or dir.id ) unless typeof(dir) is "string"
  throw new Error( "bad dir" ) unless dir?.length > 0

  # We walk up the directory tree, looking for a `package.json`
  # at each level. There could be multiple levels with
  # `package.json` files (e.g. if installed in `node_modules`)
  # but here we are interested only in the nearest `package.json`
  walkup "package.json", cwd : dir, maxResults : 1
  .then ( res ) ->
    return if res.length is 0
    loadPkgFile path.join res[ 0 ].dir, "package.json"
  .then ( pkg ) ->
    # Invoke the callback if we were supplied with one
    cb null, pkg if cb?
    pkg
  .fail ( err ) ->
    cb err if cb?
    err
  
    



