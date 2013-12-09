express   = require 'express'

module.exports = (app, passport, config) ->
  require("../controllers/users_controller")(app, passport, config)
  require('../controllers/roles_controller')(app, passport, config)