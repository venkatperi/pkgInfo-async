var Q, fs, loadPkgFile, path, readFile, walkup;

walkup = require('node-walkup');

path = require('path');

Q = require('q');

fs = require('fs');

readFile = Q.denodeify(fs.readFile);

loadPkgFile = function(filename) {
  return readFile(filename).then(function(data) {
    var pkg;
    pkg = JSON.parse(data);
    pkg.dirname = path.dirname(filename);
    return pkg;
  });
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
      return;
    }
    return loadPkgFile(path.join(res[0].dir, "package.json"));
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
