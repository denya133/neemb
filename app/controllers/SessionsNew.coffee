App = require 'app'

###*
  Controller SessionsNewController

  @class SessionsNewController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.SessionsNewController = Ember.ObjectController.extend

  actions:
    loginUser: () ->
      console.log 'kajsdhlf asldhfasldhflahksdgf '
      # router = @get('target')
      # data = @getProperties('email', 'password')

      # $.post '/users/session', data, (results) ->
      #   App.AuthManager.authenticate results.user.apikey.key, results.user.apikey.userId
      #   router.transitionTo 'index'


