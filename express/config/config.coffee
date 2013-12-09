path = require("path")
rootPath = path.normalize(__dirname + "/..")

module.exports =
  development:
    db: "mongodb://192.168.2.35/neemb-server-dev"
    root: rootPath
    # app:
    #   name: "neemb"

  test:
    db: "mongodb://192.168.2.35/neemb-server-test"
    root: rootPath
    # app:
    #   name: "neemb"

  production:
    db: "mongodb://192.168.2.35/neemb-server"
    root: rootPath
    # app:
    #   name: "neemb"