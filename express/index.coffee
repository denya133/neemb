express   = require 'express'
fs        = require 'fs'
{join}    = require 'path'
config  = require './config'
routes    = require './routes'
passport  = require 'passport'

# Load configurations
env       = process.env.NODE_ENV || 'development'
# console.log env
config_new    = require('./config/config')[env]
mongoose  = require 'mongoose'

if mongoose.connection.db is undefined
  # db connection
  db = mongoose.connect config_new.db
  # Models
  models_path = __dirname + '/models'
  fs.readdirSync(models_path).forEach (file)->
    require models_path + '/' + file

# Passport config
require('./config/passport')(passport, config_new)

app = express()

# Express settings
require('./config/express')(app, config, passport)

# Routes
require('./config/routes')(app, passport, config_new)

###*
 * Enable debuggind for Mongoose
###
# if env in ['development', 'local']
#   mongoose.set 'debug', (collectionName, method, query, doc)->
#     console.log 'Collection', collectionName
#     console.log 'Method', method
#     console.log 'Query', query
#     console.log ''
#     console.log ''

module.exports = exports = app