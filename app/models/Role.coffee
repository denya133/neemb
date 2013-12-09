App = require 'app'
{attr, hasMany, belongsTo} = DS

###*
  Model Role

  @class Role
  @namespace App
  @extends DS.Model
###
module.exports = App.Role = DS.Model.extend
  # put your code here
  name: attr 'string'
  

### If any special serializer or adapter is needed for this model, use this code:

App.RoleAdapter = DS.RESTAdapter.extend
  # your adapter code here

App.RoleSerializer = DS.RESTSerializer.extend
  # your serializer code here

###
