mongoose = require "mongoose"
Schema = mongoose.Schema

apikeySchema = new Schema
  userId: String
  key: String

mongoose.model "Apikey", apikeySchema