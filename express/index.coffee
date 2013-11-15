express   = require 'express'
fs        = require 'fs'
{join}    = require 'path'
{config}  = require './config'
routes    = require './routes'
passport  = require 'passport'

# Load configurations
env       = process.env.NODE_ENV || 'development'
config_new    = require('./config/config')[env]
mongoose  = require 'mongoose'

# db connection
db = mongoose.connect config_new.db

# Models
models_path = __dirname + '/models'
fs.readdirSync(models_path).forEach (file)->
  require models_path + '/' + file

# Passport config
require('./config/passport')(passport, config_new)

app = express()

# # Express settings
# require('./config/express')(app, config_new, passport)

# Routes
require('./config/routes')(app, passport)

app.configure 'production', ->
  app.use express.limit '5mb'

# allowCrossDomain = (req, res, next) ->
#   res.header 'Access-Control-Allow-Origin', "*"
#   res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
#   res.header 'Access-Control-Allow-Headers', 'Content-Type'
#   next()

app.configure ->
  app.set 'views', join __dirname, 'views'
  app.set 'view engine', config.view.engine
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.cookieParser(config.cookie.secret)
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.compress()
  # app.use allowCrossDomain
  app.use express.session()
  app.use express.csrf()
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router
  app.use express.static join __dirname, '..', 'public'

app.configure 'development', ->
  app.use express.errorHandler()
  app.locals.pretty = true

app.get '/', routes.index('NEEMB', express.version)
app.get '/test', routes.test('Mocha Tests')

### Default 404 middleware ###
app.use routes.error('Page not found :(', 404)



module.exports = exports = app