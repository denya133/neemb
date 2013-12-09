###*
 * To start server please type this in the console: PORT=3030 coffee start.coffee
###
console.log('Starting server ...');

port = process.env.PORT || 3000
app = require './express'
app.listen port

console.log('Listening on port ' + port);