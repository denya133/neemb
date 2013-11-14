mongoose = require "mongoose"
bcrypt = require "bcrypt"
Schema = mongoose.Schema

userSchema = new Schema
  first_name: String
  last_name: String
  email: String
  created_at: Date
  updated_at: Date
  password: String
  apikey:
    type: Schema.Types.ObjectId
    ref: "Apikey"


userSchema.pre "save", (next, done) ->
  user = this
  if @isNew
    user.created_at = new Date
    next()
  else
    user.updated_at = new Date
    next()

userSchema.pre "save", (next, done) ->
  user = this
  if user.isModified("password")
    bcrypt.hash user.password, 10, (err, hash) ->
      user.password = hash
      next()
  else
    next()
    
userSchema.statics.verifyPassword = (reqPassword, userPassword, cb) ->
  bcrypt.compare reqPassword, userPassword, (err, res) ->
    return cb(err)  if err
    cb null, res

mongoose.model 'User', userSchema