App = require 'app'

###*
  Controller UserEditController

  @class UserEditController
  @namespace App
  @extends Ember.ObjectController
###
module.exports = App.UserEditController = Ember.ObjectController.extend
  ###*
    Holds our model

    @property content
    @type Object
  ###
  content: null

  actions:
    save: () ->
      user = @get 'model'

      user.save()

      # Transition to the user route after the client is updated
      user.on 'didUpdate', this, () ->
        @transitionToRoute 'user.index', user

    cancel: () ->
      user = @get 'model'
      user.rollback()
      @transitionToRoute 'user.index', user
