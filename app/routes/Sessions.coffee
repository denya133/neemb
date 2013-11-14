App = require 'app'

###*
  Route SessionsRoute

  @class SessionsRoute
  @namespace App
  @extends Ember.Route
###
module.exports = App.SessionsRoute = Ember.Route.extend
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
