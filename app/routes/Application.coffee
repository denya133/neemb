App = require 'app'
# AuthManager = require '../models/AuthManager'

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
  init: () ->
    @_super arguments...
    console.log 'init of ApplicationRoute'

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
