# ###
# Module dependencies.
# ###
express = require("express")
helpers = require("view-helpers")
{join}    = require 'path'
routes    = require '../routes'

module.exports = (app, config, passport) ->

  console.log config.config.view.engine
  allowCrossDomain = (req, res, next) ->
    res.header "Access-Control-Allow-Origin", "*"
    res.header "Access-Control-Allow-Methods", "GET,PUT,POST,DELETE"
    res.header "Access-Control-Allow-Headers", "Content-Type, Authorization"
    if "OPTIONS" is req.method
      res.send 200
    else
      next()

  hackDeleteHeaders = (req, res, next) ->
    delete req.headers["transfer-encoding"]  if req.method is "DELETE"
    next()

  app.configure 'production', ->
    app.use express.limit '5mb'

  app.set 'views', join __dirname, '..', 'views'
  app.set 'view engine', config.config.view.engine

  app.enable "jsonp callback"

  app.configure ->
    app.use express.favicon()
    app.use express.logger 'dev'
    app.use express.cookieParser(config.config.cookie.secret)
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.compress()
    app.use express.session()
    # app.use express.csrf() # из за него не работает $.post в эмберном приложении при кросс доменном запросе
    app.use allowCrossDomain
    app.use hackDeleteHeaders
    app.use passport.initialize()
    app.use passport.session()
    app.use app.router
    app.use express.static join __dirname, '..', '..', 'public'
    #Assume "not found" in the error msgs is a 404. this is somewhat silly, but valid, you can do whatever you like, set properties, use instanceof etc.
    app.use (err, req, res, next) ->
      #Treat as 404
      return next()  if ~err.message.indexOf("not found")
      #Log it
      console.error err.stack
      #Error page
      res.status(500).render "500",
        error: err.stack

    #Assume 404 since no middleware responded
    app.use (req, res, next) ->
      res.status(404).render "404",
        url: req.originalUrl
        error: "Not found"

  app.configure 'development', ->
    app.use express.errorHandler()
    app.locals.pretty = true

  app.get '/', routes.index('NEEMB', express.version)
  app.get '/test', routes.test('Mocha Tests')

  ### Default 404 middleware ###
  app.use routes.error('Page not found :(', 404)