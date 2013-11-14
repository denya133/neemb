App = require 'app'

###*
  Route ApplicationRoute

  @class ApplicationRoute
  @namespace App
  @extends Ember.Route
###
module.exports = App.ApplicationRoute = Ember.Route.extend
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
