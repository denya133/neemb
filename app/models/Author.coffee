App = require 'app'
{attr, hasMany, belongsTo} = DS

###*
  Model Author

  @class Author
  @namespace App
  @extends DS.Model
###
module.exports = App.Author = DS.Model.extend
  # put your code here
  first_name: attr 'string'
  last_name: attr 'string'
  email: attr 'string'
  password: attr 'string'


### If any special serializer or adapter is needed for this model, use this code:

App.AuthorAdapter = DS.RESTAdapter.extend
  # your adapter code here

App.AuthorSerializer = DS.RESTSerializer.extend
  # your serializer code here

###
