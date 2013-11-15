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
      console.log 'sldkgadsjkgh'
      # router = @get('target')
      # data   = @getProperties('first_name', 'last_name', 'email', 'password')
      # user   = @get('model')
      user = @store.createRecord('user', {
        first_name: @get 'first_name'
        last_name: @get 'last_name'
        email: @get 'email'
        password: @get 'password'
      })

      @set 'first_name', ''
      @set 'last_name', ''
      @set 'email', ''
      @set 'password', ''

      user.save()
      # $.post '/users', { user: data }, (results) ->
      #   App.AuthManager.authenticate results.user.apikey.key, results.user.apikey.userId
      #   router.transitionTo 'index'
    
