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
      console.log 'loginUser'

      data = 'session':
        email: @get 'email'
        password: CryptoJS.MD5(@get 'password').toString()

      @set 'email', ''
      @set 'password', ''

      $.post '/rest-api/sessions', data, (results) ->
        App.Auth.authenticate(results.user.apikey.key, results.user.apikey.userId).then () =>
          console.log 'laskdjf'
      @transitionToRoute 'index'


