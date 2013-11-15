mongoose = require 'mongoose'
User     = mongoose.model 'User'
Apikey   = mongoose.model 'Apikey'
uuid     = require "node-uuid"

exports.session = (req, res) ->
  console.log 'to exports.session'
  User.findOne(email: req.body.session.email).populate("apikey").exec (err, user) ->
    return res.json(err)  if err
    return res.json(message: "Incorrect username or password.")  unless user
    User.verifyPassword req.body.session.password, user.password, (err, result) ->
      if result
        res.json user: user
      else
        res.json message: "Incorrect username or password."

exports.index = (req, res) ->
  console.log 'to exports.index'
  User.find().exec (err, users) ->
    return res.json error: err  if err
    res.json users: users

exports.create = (req, res) ->
  console.log 'to exports.create'
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
  console.log 'to exports.show'
  user = req.profile
  res.json user: user

exports.me = (req, res) ->
  console.log 'to exports.me'
  res.json req.user or null

exports.user = (req, res, next, id) ->
  console.log 'to exports.user'
  console.log id
  User.findById(id).exec (err, user) ->
    return next(err)  if err
    return next(new Error("Failed to load User " + id))  unless user
    console.log user
    user.populate "apikey", (err, user) ->
      res.json err  if err
      res.json user: user
    # res.profile = user
    # next()
    # res.json user: user