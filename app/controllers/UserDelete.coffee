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

  actions:
    delete: () ->
      user = @get 'model'
      user.deleteRecord()
      user.save()
      @transitionToRoute 'users.index'
