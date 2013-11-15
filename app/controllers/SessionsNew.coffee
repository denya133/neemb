App = require 'app'

###*
  Controller SessionsNewController

  @class SessionsNewController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.SessionsNewController = Ember.ArrayController.extend

  actions:
    loginUser: () ->
      console.log 'kajsdhlf asldhfasldhflahksdgf'

      session = @store.createRecord 'session', 
        email: @get 'email'
        password: CryptoJS.MD5(@get 'password').toString()

      @set 'email', ''
      @set 'password', ''

      session.save().then (results) =>
        console.log results.user
      # $.post '/users/session', data, (results) ->
      #   App.AuthManager.authenticate results.user.apikey.key, results.user.apikey.userId
      #   router.transitionTo 'index'


