mongoose  = require 'mongoose'
roles     = require '../config/roles'

Role      = mongoose.model 'Role'

module.exports = (app, passport, config)->
  app.get '/rest-api/roles', roles.middleware("neemb/view"), (req, res)->
    Role.findOne req.query, (err, roles)->
      res.json 500, { error: err }  if err
      res.json 200,
        roles: [
          roles
        ]
  app.get '/rest-api/roles/:roleId', roles.middleware("neemb/view"), (req, res)->
    Role.findById req.params.roleId, (err, role)->
      res.json 500, { error: err }  if err
      res.json 200,
        role: role
