mongoose = require "mongoose"
Schema = mongoose.Schema

roleSchema = new Schema
  name: String


mongoose.model "Role", roleSchema