App = require 'app'
{attr, hasMany, belongsTo} = DS

###*
  Model FlashMessage

  @class FlashMessage
  @namespace App
  @extends Ember.Object
###
module.exports = App.FlashMessage = Ember.Object.extend
  type: "notice"
  message: null
  isNotice: (->
    @get("type") is "notice"
  ).property("type").cacheable()
  isWarning: (->
    @get("type") is "warning"
  ).property("type").cacheable()
  isError: (->
    @get("type") is "error"
  ).property("type").cacheable()
  

### If any special serializer or adapter is needed for this model, use this code:

App.FlashMessageAdapter = DS.RESTAdapter.extend
  # your adapter code here

App.FlashMessageSerializer = DS.RESTSerializer.extend
  # your serializer code here

###
