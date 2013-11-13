path = require("path")
rootPath = path.normalize(__dirname + "/..")

module.exports =
  development:
    db: "mongodb://192.168.2.35/clvr-admin-server-dev"
    root: rootPath
    app:
      name: "neem"

  test:
    db: "mongodb://192.168.2.35/clvr-admin-server-test"
    root: rootPath
    app:
      name: "neem"

  production:
    db: "mongodb://192.168.2.35/clvr-admin-server"
    root: rootPath
    app:
      name: "neem"