var Q, fs, path, readJsonFile, walkup;

walkup = require('node-walkup');

path = require('path');

fs = require('fs');

Q = require('q');

readJsonFile = function(filename) {
  var d;
  d = Q.defer();
  fs.readFile(filename, function(err, data) {
    var pkg;
    if (err != null) {
      return d.reject(err);
    }
    pkg = JSON.parse(data);
    pkg.dirname = path.dirname(filename);
    return d.resolve(pkg);
  });
  return d.promise;
};

module.exports = function(dir, cb) {
  if (typeof dir !== "string") {
    dir = path.dirname(dir.filename || dir.id);
  }
  if (!((dir != null ? dir.length : void 0) > 0)) {
    throw new Error("bad dir");
  }
  return walkup("package.json", {
    cwd: dir,
    maxResults: 1
  }).then(function(res) {
    if (res.length === 0) {
      return void 0;
    }
    return readJsonFile(path.join(res[0].dir, "package.json"));
  }).then(function(pkg) {
    if (cb != null) {
      cb(null, pkg);
    }
    return pkg;
  }).fail(function(err) {
    if (cb != null) {
      cb(err);
    }
    return err;
  });
};
