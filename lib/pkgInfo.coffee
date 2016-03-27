walkup = require( 'node-walkup' )
path = require( 'path' )
fs = require( 'fs' )

readJsonFile = ( filename, cb ) ->
  fs.readFile filename, ( err, data )  ->
    return cb err if err?
    pkg = JSON.parse data
    pkg.dirname = path.dirname filename
    cb null, pkg

module.exports = ( dir, cb ) ->
  dir = dir.filename or dir.id unless typeof(dir) is "string"
  throw new Error( "bad dir" ) unless dir?.length > 0
  walkup "package.json", cwd : dir, maxResults : 1, ( err, res ) ->
    return cb err if err?
    return cb undefined if res.length is 0
    readJsonFile path.join( res[ 0 ].dir, "package.json" ), cb
    
    
  
