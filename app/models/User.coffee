App = require 'app'
{attr, hasMany, belongsTo} = DS

###*
  Model User

  @class User
  @namespace App
  @extends DS.Model
###
module.exports = App.User = DS.Model.extend
  # put your code here
  first_name: attr 'string'
  last_name: attr 'string'
  email: attr 'string'
  password: attr 'string'

  role: belongsTo 'role'

  isAdmin: (()->
    @get('role.name') is 'admin'
  ).property('role.name').readOnly().volatile()

  isSuper: (()->
    @get('role.name') is 'superadmin'
  ).property('role.name').readOnly().volatile()

  roleName: (()->
    @get('role.name')
  ).property('role.name').readOnly().volatile()

### If any special serializer or adapter is needed for this model, use this code:

App.UserAdapter = DS.RESTAdapter.extend
  # your adapter code here

App.UserSerializer = DS.RESTSerializer.extend
  # your serializer code here

###
