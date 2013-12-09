App = require 'app'

###*
  Controller UsersCreateController

  @class UsersCreateController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.UsersCreateController = Ember.ObjectController.extend
  ###*
    Holds our model

    @property content
    @type Object
  ###
  content: null

  # needs: 'client'

  actions:
    save: () ->
      controller = this
      user = @get 'model'
      # client = @get('controllers.client.model')
      @get('store').find('role', {name: 'user'}).then (roles)->
        user.set 'password', CryptoJS.MD5(user.get 'pass').toString()
        # user.set 'client', client.get 'id'
        user.set 'role', roles.get('content')[0]
        user.save().then (user) ->
          # client.get('users').pushObject user
          # client.save().then (client) ->
          controller.transitionToRoute 'user.index', user


    cancel: () ->
      @get('model').deleteRecord()
      @transitionToRoute 'index'