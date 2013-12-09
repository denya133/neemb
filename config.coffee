sysPath = require 'path'
fs = require 'fs'
DIR_SEP = sysPath.sep

objectify = ->
  o = {}
  for k, i in arguments by 2
    o[k] = arguments[i + 1]
  o


#TODO: find a method to do this in a cleaner way
gitHead = -> fs.readFileSync(sysPath.join('.git', 'HEAD')).toString().replace(/^\s*ref\:\s*/g, '').replace(/\s*$/g, '')
gitBranch = ->
  head = gitHead().split /\//g
  branch = head.slice()
  branch.shift()
  branch.shift()
  branch.join '/'
gitCommitHash = -> fs.readFileSync(sysPath.join('.git',
  gitHead().split(/\//g).join(DIR_SEP))).toString().replace(/^\s*/g, '').replace(/\s*$/g, '')

exports.config =
# See http://brunch.io/#documentation for documentation.
  files:
    javascripts:
      joinTo: objectify(
        "javascripts#{DIR_SEP}app.min.js", (path) -> /^app/.test(path) and not /\.prod\./.test(path)
        "javascripts#{DIR_SEP}head.min.js", (path) -> /^vendor(\/|\\)head/.test(path) and not /\.prod\./.test(path)
        "javascripts#{DIR_SEP}vendor.min.js", (path) -> /^vendor/.test(path) and not /\.prod\./.test(path) and not /.*(\/|\\)head(\/|\\).*/.test(path) and not /^vendor(\/|\\)test(\/|\\).*/.test(path) and not /.*[_].*/.test(path)
        # "test#{DIR_SEP}javascripts#{DIR_SEP}test-vendor.js", /^test(\/|\\)(?=vendor)/

        "test#{DIR_SEP}javascripts#{DIR_SEP}test-vendor.js", (path) -> /^vendor(\/|\\)test(\/|\\)scripts(\/|\\)(?!blanket|mocha-blanket)/.test(path) and not /\.prod\./.test(path)
        "test#{DIR_SEP}javascripts#{DIR_SEP}blanket.js", (path) -> /^vendor(\/|\\)test(\/|\\)scripts(\/|\\)(blanket|mocha-blanket)/.test(path) and not /\.prod\./.test(path)
        "test#{DIR_SEP}javascripts#{DIR_SEP}test.js", (path) -> /^test/.test(path) and not /\.prod\./.test(path)
      )

      order: jsOrder =
        before: [
          "vendor#{DIR_SEP}scripts#{DIR_SEP}console-polyfill.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}jquery.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}handlebars-1.0.0.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}ember.dev.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}ember.prod.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}ember-data.dev.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}ember-data.prod.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}bootstrap#{DIR_SEP}tooltip.js"

          "vendor#{DIR_SEP}scripts#{DIR_SEP}bootstrap#{DIR_SEP}*.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}bootstrap-for-ember#{DIR_SEP}bs-core.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}bootstrap-for-ember#{DIR_SEP}*.js"
        ]
        after: [
          "vendor#{DIR_SEP}scripts#{DIR_SEP}ember-bootstrap.js"

          "vendor#{DIR_SEP}test#{DIR_SEP}scripts#{DIR_SEP}blanket-1.1.1.js"
          "vendor#{DIR_SEP}test#{DIR_SEP}scripts#{DIR_SEP}mocha-blanket-1.1.1.js"
          "vendor#{DIR_SEP}test#{DIR_SEP}scripts#{DIR_SEP}test-helper.js"
          "vendor#{DIR_SEP}scripts#{DIR_SEP}brunch-reload.js"
        ]

    stylesheets:
      joinTo: objectify(
        "stylesheets#{DIR_SEP}app.css", (path) ->
          # we need to exclude bootstrap files since they're included in the application.styl
          /^(app|vendor)/.test(path) and not /^vendor(\/|\\)styles(\/|\\)(bootstrap|font\-awesome)(\/|\\)/.test(path) and not /^app(\/|\\)styles(\/|\\)(old_server)(\/|\\)/.test(path)
        "test#{DIR_SEP}stylesheets#{DIR_SEP}test.css", (path) ->/^test|vendor(\/|\\)test/.test(path)
        "stylesheets#{DIR_SEP}main.css", (path) -> /^app(\/|\\)styles(\/|\\)(old_server)(\/|\\)main.css/.test(path)
        "stylesheets#{DIR_SEP}responsive.css", (path) -> /^app(\/|\\)styles(\/|\\)(old_server)(\/|\\)responsive.css/.test(path)
      )
      order:
        before: [
          "vendor#{DIR_SEP}styles#{DIR_SEP}normalize.css"
        ]

      modules:
        addSourceURLs: true

    templates:
    # for smaller builds, disable the pre-compilation of tempaltes
      precompile: true
      root: 'templates'
      joinTo: objectify(
        "javascripts#{DIR_SEP}app.min.js", /^app/
        "javascripts#{DIR_SEP}app.js", /^app/
      )

# CoffeeScript easy-debugging
  sourceMaps: true

# keyword-brunch plugin
  keyword:
    map:
      git_commit_hash: gitCommitHash
      git_short_commit_hash: -> gitCommitHash().substr 0, 7
      git_branch: gitBranch


  overrides:
    production:
      optimize: yes
      sourceMaps: no
      files:
        javascripts:
          joinTo: objectify(
            "javascripts#{DIR_SEP}app.js", (path) -> /^app/.test(path) and not /\.dev\./.test(path)
            "javascripts#{DIR_SEP}vendor.min.js", (path) -> /^vendor/.test(path) and not /\.dev\./.test(path) and not /\brunch-reload\./.test(path) and not /.*(\/|\\)head(\/|\\).*/.test(path) and not /^vendor(\/|\\)test(\/|\\).*/.test(path) and not /.*[_].*/.test(path)
            "javascripts#{DIR_SEP}head.min.js", (path) -> /^vendor(\/|\\)head/.test(path) and not /\.dev\./.test(path)
          )
          order: jsOrder
      plugins:
        autoreload:
          enabled: no


# allow _ prefixed templates so partials work
  conventions:
    ignored: (path) ->
      startsWith = (string, substring) ->
        string.indexOf(substring, 0) is 0
      if path.indexOf("app#{DIR_SEP}templates#{DIR_SEP}") is 0
        no
      else
        startsWith sysPath.basename(path), '_'

# configs for start server
  server:
    path: 'server.coffee'
    port: process.env.PORT or 3333
    #listen: process.env.IP or 'localhost'
    base: '/'
    app: 'express'
    debug: 'brunch:server'
    persistent: true
    interval: 100
    watched: ['public', 'express']
    ignore: /(^[.#]|(?:~)$)/
    source: /.*\.coffee$/
    linter:
      enabled: on
      coffeelint:
        pattern: /.*\.coffee$/
        options:
          indentation:
            value: 2
            level: "warn"
    tester:
      enabled: on
      mocha:
        pattern: /^.*_test\.coffee$/
        options:
          reporter:'spec'
