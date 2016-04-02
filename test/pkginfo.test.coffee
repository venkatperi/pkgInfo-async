should = require( "should" )
assert = require( "assert" )
pkgInfo = require '../index'
lib = require '../lib/pkgInfo'
path = require "path"

fixturesDir = path.join __dirname, "fixtures"
dir = path.join __dirname, "fixtures", "dir"
dir2 = path.join __dirname, "fixtures", "dir", "dir2"

describe "pkgInfo", ->

  it "walks up dir tree and returns contents of first package.json it finds", ( done ) ->
    pkgInfo fixturesDir, ( err, pkg ) ->
      pkg.name.should.equal "fixtures"
      pkg.dirname.should.equal fixturesDir
      done()

  it "returns a promise", ( done ) ->
    pkgInfo fixturesDir
    .then ( pkg ) ->
      pkg.name.should.equal "fixtures"
      pkg.dirname.should.equal fixturesDir
      done()
    .fail done

  it "walks up dir tree and returns contents of first package.json it finds, take 2", ( done ) ->
    pkgInfo dir, ( err, pkg ) ->
      pkg.name.should.equal "dir"
      pkg.dirname.should.equal dir
      done()

  it "walks up dir tree and returns contents of first package.json it finds, take 3", ( done ) ->
    pkgInfo dir2, ( err, pkg ) ->
      pkg.name.should.equal "dir"
      done()

  it "returns the location of the package.json file in the dirname field", ( done ) ->
    pkgInfo dir2, ( err, pkg ) ->
      pkg.dirname.should.equal dir
      done()

  it "returns undefined if no package.json is found in the dir hierarchy", ( done ) ->
    pkgInfo "/blahafasdfas-asdfasdfas", ( err, pkg ) ->
      assert.equal pkg, undefined
      done()

  it "accepts a module", ( done ) ->
    pkgInfo module
    .then (pkg) ->
      pkg.name.should.equal "pkginfo-async"
      done()
    .fail done
    .done()

