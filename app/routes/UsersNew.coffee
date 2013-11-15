App = require 'app'

###*
  Route UsersNewRoute

  @class UsersNewRoute
  @namespace App
  @extends Ember.Route
###
module.exports = App.UsersNewRoute = Ember.Route.extend
  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  init: () ->
    @_super arguments...
    console.log 'init of UsersNewRoute'
    App.Auth = App.AuthManager.create() unless App.Auth
    
  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  model: (params) ->
    @_super arguments...
    

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  setupController: (controller, model) ->
    @_super arguments...
    #@controller.set 'model', App.User.createRecord()
