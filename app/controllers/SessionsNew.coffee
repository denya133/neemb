App = require 'app'

###*
  Controller SessionsNewController

  @class SessionsNewController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.SessionsNewController = Ember.ArrayController.extend

  # actions:
  #   loginUser: () ->
  #     console.log 'loginUser'

  #     data = 'session':
  #       email: @get 'email'
  #       password: CryptoJS.MD5(@get 'password').toString()

  #     @set 'email', ''
  #     @set 'password', ''

  #     $.post '/rest-api/sessions', data, (results) ->
  #       App.Auth.authenticate(results.user.apikey.key, results.user.apikey.userId).then () =>
  #         console.log 'laskdjf'
  #     @transitionToRoute 'index'

  content: null
  actions:
    loginUser: () ->
      controller = this
      session = @store.createRecord 'session',
        email: @get 'email'
        password: CryptoJS.MD5(@get 'password').toString()

      @set 'email', ''
      @set 'password', ''

      session.save()
      session.on 'didCreate', this, (results) ->
        key = results.get('_data.apikey.key')
        userId = results.get('_data.apikey.userId')
        App.Auth.authenticate(key, userId).then (auth) ->
          console.log 'App.Auth.authenticate successful'          
          # apiKey = auth.get 'apiKey'
          # role = apiKey.get 'user._data.role.name'
          # switch role
          #   when 'superadmin'
          #     controller.transitionToRoute 'tomato'
          #   when 'admin', 'user'
          #     controller.transitionToRoute 'cucumber'
          #   else
          #     return
        @transitionToRoute 'index'