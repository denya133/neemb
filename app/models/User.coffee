App = require 'app'

###*
  Model User

  @class User
  @namespace App
  @extends DS.Model
###
module.exports = App.User = DS.Model.extend
  # put your code here
  first_name: DS.attr('string')
  last_name: DS.attr('string')
  email: DS.attr('string')

### If any special serializer or adapter is needed for this model, use this code:

App.UserAdapter = DS.RESTAdapter.extend
  # your adapter code here

App.UserSerializer = DS.RESTSerializer.extend
  # your serializer code here

###
