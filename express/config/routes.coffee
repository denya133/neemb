express   = require 'express'

module.exports = (app, passport) ->
  # User Routes
  users = require "../controllers/users_controller"
  # Setting up the users api
  app.post "/rest-api/users", express.bodyParser(), users.create
  app.post "/rest-api/sessions", express.bodyParser(), users.session
  app.get "/rest-api/users", users.index
  app.get "/rest-api/users/me", passport.authenticate("bearer",
    session: false
  ), users.me
  app.get "/rest-api/users/:userId", passport.authenticate("bearer",
    session: false
  ), users.show

  # Finish with setting up the userId param
  app.param "userId", users.user

  # # Home route
  # index = require "../controllers/index_controller"
  # app.get "/", index.render