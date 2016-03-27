should = require( "should" )
assert = require( "assert" )
pkgInfo = require '..'
path = require "path"

fixturesDir = path.join __dirname, "fixtures"

describe "pkgInfo", ->

  it "walks up dir tree and returns contents of first package.json it finds", ( done ) ->
    pkgInfo fixturesDir, ( err, pkg ) ->
      pkg.name.should.equal "fixtures"
      done()

  it "walks up dir tree and returns contents of first package.json it finds, take 2", ( done ) ->
    pkgInfo path.join( fixturesDir, "dir" ), ( err, pkg ) ->
      pkg.name.should.equal "dir"
      done()

  it "walks up dir tree and returns contents of first package.json it finds, take 3", ( done ) ->
    pkgInfo path.join( fixturesDir, "dir", "dir2" ), ( err, pkg ) ->
      pkg.name.should.equal "dir"
      done()

  it "returns undefined if no package.json is found in the dir hierarchy", ( done ) ->
    pkgInfo "/blahafasdfas-asdfasdfas", ( err, pkg ) ->
      assert.equal pkg, undefined
      done()

