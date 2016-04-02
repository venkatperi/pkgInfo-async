walkup = require( 'node-walkup' )
path = require( 'path' )
fs = require( 'fs' )
Q = require 'q'

readJsonFile = ( filename ) ->
  d = Q.defer()
  fs.readFile filename, ( err, data )  ->
    return d.reject err if err?
    pkg = JSON.parse data
    pkg.dirname = path.dirname filename
    d.resolve pkg
    
  d.promise

module.exports = ( dir, cb ) ->
  dir = path.dirname( dir.filename or dir.id ) unless typeof(dir) is "string"
  throw new Error( "bad dir" ) unless dir?.length > 0
  walkup "package.json", cwd : dir, maxResults : 1
  .then ( res ) ->
    return undefined  if res.length is 0
    readJsonFile path.join res[ 0 ].dir, "package.json"
  .then ( pkg ) ->
    cb null, pkg if cb?
    pkg
  .fail ( err ) ->
    cb err if cb?
    err
  
    



