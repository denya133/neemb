App = require 'app'
{attr, hasMany, belongsTo} = DS

###*
  Model Session

  @class Session
  @namespace App
  @extends DS.Model
###
module.exports = App.Session = DS.Model.extend
  # put your code here
  email: attr 'string'
  password: attr 'string'

### If any special serializer or adapter is needed for this model, use this code:

App.SessionAdapter = DS.RESTAdapter.extend
  # your adapter code here

App.SessionSerializer = DS.RESTSerializer.extend
  # your serializer code here

###
