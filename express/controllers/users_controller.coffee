mongoose  = require 'mongoose'
uuid      = require "node-uuid"
_         = require 'lodash'
roles     = require '../config/roles'

User      = mongoose.model 'User'
Apikey    = mongoose.model 'Apikey'
Role      = mongoose.model 'Role'

module.exports = (app, passport, config)->
  app.post "/rest-api/sessions", (req, res) ->
    console.log 'to users.exports.session'
    User.findOne(email: req.body.session.email)
    .populate("apikey").populate("role").exec (err, user) ->
      return res.json err  if err
      unless user
        return res.json 401,
          message: "Incorrect username or password."
      User.verifyPassword req.body.session.password, user.password
      , (err, result) ->
        if result
          res.json session: user
        else
          res.send 401, "Incorrect username or password."

  app.get "/rest-api/users", roles.middleware("neemb/view"), (req, res) ->
    console.log 'to users.exports.index'
    params = {}
    if req.query.ids
      params =
        _id:
          $in: req.query.ids
    User.find(params).exec (err, users) ->
      return res.json error: err  if err
      role_ids = []
      _.each users, (user)->
        role_ids.push user.role
      Role.find _id: {$in: role_ids}, (err, roles)->
        return res.json error: err  if err
        res.json 200,
          users: users
          roles: roles

  app.post "/rest-api/users", roles.middleware("neemb/view"), (req, res) ->
    console.log 'to users.exports.create'
    role = Role.findById req.body.user.role, (err, role)->
      new_user = new User(req.body.user)
      new_user.role = role._id
      new_user.save (err, saved_user, num_affected) ->
        new_apikey = new Apikey(
          userId: saved_user._id
          key: uuid.v4()
        )
        new_apikey.save (err, saved_apikey, num_affected) ->
          saved_user.apikey = saved_apikey._id
          saved_user.save (err, updated_user, num_affected) ->
            res.json err  if err
            res.json user: updated_user

  app.put "/rest-api/users/:userId", passport.authenticate("bearer",
      session: false
  ), roles.middleware("neemb/view"), (req, res) ->
    console.log 'to users.exports.update'
    User.findById req.params.userId, (err, user)->
      res.json 500, {error: err}  if err
      # console.log user
      user.email = req.body.user.email
      user.first_name = req.body.user.first_name
      user.last_name = req.body.user.last_name
      user.password = req.body.user.password

      user.save (err, user_updated)->
        res.json 500, {error: err}  if err
        res.json 200, {user: user_updated}

  app.delete "/rest-api/users/:userId", passport.authenticate("bearer",
      session: false
  ), roles.middleware("neemb/view"), (req, res)->
    console.log 'to users.exports.delete'
    User.findByIdAndRemove req.params.userId, (err, user)->
      res.json 500, {error: err}  if err
      res.send 200, ''


  app.get "/rest-api/users/me", passport.authenticate("bearer",
      session: false
  ), roles.middleware("neemb/view"), (req, res) ->
    console.log 'to users.exports.me'
    res.json req.user or null

  app.get "/rest-api/users/:userId", roles.middleware("neemb/view"), (req, res) ->
    console.log 'to users.exports.user'
    User.findById req.params.userId, (err, user) ->
      return res.json err  if err
      Role.findById user.role, (err, role)->
        return res.json err  if err
        res.json
          roles: [role]
          user: user

  app.get "/rest-api/authors/:userId", (req, res) ->
    console.log 'to authors.exports.user'
    User.findById req.params.userId, (err, user) ->
      return res.json err  if err
      unless user
        return res.json 200,
          author: null
      user.populate('apikey').populate 'role', (err, user)->
        res.json 500, err  if err
        res.json author: user