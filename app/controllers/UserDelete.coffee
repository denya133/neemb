App = require 'app'

###*
  Controller UserDeleteController

  @class UserDeleteController
  @namespace App
  @extends Ember.ObjectController
###
module.exports = App.UserDeleteController = Ember.ObjectController.extend
  ###*
    Holds our model

    @property content
    @type Object
  ###
  content: null

  # needs: 'client'

  # actions:
  #   delete: () ->
  #     user = @get 'model'
  #     client = @get('controllers.client.model')

  #     Ember.run.next () ->
  #       client.get('users').removeObject(user)
  #       client.save()

  #     client.on 'didUpdate', this, () ->
  #       user.deleteRecord()
  #       user.save()
  #       @transitionToRoute 'users.index', client
