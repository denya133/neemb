App = require 'app'

###*
  Controller UsersNewController

  @class UsersNewController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.UsersNewController = Ember.ArrayController.extend
  # put your code here
  actions:
    createUser: () ->
      console.log 'createUser'

      data = 'user':
        first_name: @get 'first_name'
        last_name: @get 'last_name'
        email: @get 'email'
        password: CryptoJS.MD5(@get 'password').toString()

      @set 'first_name', ''
      @set 'last_name', ''
      @set 'email', ''
      @set 'password', ''
    
      $.post '/rest-api/users', data, (results) ->
        App.Auth.authenticate(results.user.apikey.key, results.user.apikey.userId).then () =>
      @transitionToRoute 'index'