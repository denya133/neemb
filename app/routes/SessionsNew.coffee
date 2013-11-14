App = require 'app'

###*
  Route SessionsNewRoute

  @class SessionsNewRoute
  @namespace App
  @extends Ember.Route
###
module.exports = App.SessionsNewRoute = Ember.Route.extend
  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  model: (params) ->
    @_super arguments...
    # Ember.Object.create()

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  setupController: (controller, model) ->
    @_super arguments...
