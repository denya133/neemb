App = require 'app'

###*
  Controller UsersNewController

  @class UsersNewController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.UsersNewController = Ember.ObjectController.extend
  # put your code here
  actions:
    createUser: () ->
      console.log 'sldkgadsjkgh'
      # router = @get('target')
      # data   = @getProperties('first_name', 'last_name', 'email', 'password')
      # user   = @get('model')

      # $.post '/users', { user: data }, (results) ->
      #   App.AuthManager.authenticate results.user.apikey.key, results.user.apikey.userId
      #   router.transitionTo 'index'
    
