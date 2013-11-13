mongoose = require("mongoose")
BearerStrategy = require("passport-http-bearer").Strategy
User = mongoose.model("User")
Apikey = mongoose.model("Apikey")

module.exports = (passport, config) ->
  passport.use new BearerStrategy((token, done) ->
    Apikey.findOne(key: token).exec (err, apikey) ->
      return done(err)  if err
      return done(null, false)  unless apikey
      User.findById(apikey.userId).exec (err, user) ->
        return done(err)  if err
        return done(null, false)  unless user
        done null, user,
          scope: "all"
  )