App = require 'app'

###*
  Model Apikey

  @class Apikey
  @namespace App
  @extends Ember.Object
###
module.exports = App.Apikey = Ember.Object.extend
  # put your code here
  access_token: ''
  user: null
