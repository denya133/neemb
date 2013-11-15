mongoose = require 'mongoose'
User     = mongoose.model 'User'
Apikey   = mongoose.model 'Apikey'
uuid     = require "node-uuid"

exports.session = (req, res) ->
  User.findOne(email: req.body.session.email).populate("apikey").exec (err, user) ->
    return res.json(err)  if err
    return res.json(message: "Incorrect username or password.")  unless user
    User.verifyPassword req.body.session.password, user.password, (err, result) ->
      if result
        res.json user: user
      else
        res.json message: "Incorrect username or password."

exports.index = (req, res) ->
  User.find().exec (err, users) ->
    return res.json error: err  if err
    res.json users: users

exports.create = (req, res) ->
  new_user = new User(req.body.user)
  new_user.save (err, saved_user, num_affected) ->
    new_apikey = new Apikey(
      userId: saved_user._id
      key: uuid.v4()
    )
    new_apikey.save (err, saved_apikey, num_affected) ->
      saved_user.apikey = saved_apikey._id
      saved_user.save (err, updated_user, num_affected) ->
        updated_user.populate "apikey", (err, user) ->
          res.json err  if err
          res.json user: user

exports.show = (req, res) ->
  user = req.profile
  res.json user: user

exports.me = (req, res) ->
  res.json req.user or null

exports.user = (req, res, next, id) ->
  User.findById(id).exec (err, user) ->
    return next(err)  if err
    return next(new Error("Failed to load User " + id))  unless user
    req.profile = user
    next()