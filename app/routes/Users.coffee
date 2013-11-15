App = require 'app'
# User = App.User #require '../models/User'

###*
  Route UsersRoute

  @class UsersRoute
  @namespace App
  @extends Ember.Route
###
module.exports = App.UsersRoute = Ember.Route.extend
  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  model: (params) ->
    @get('store').findAll 'user'

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  setupController: (controller, model) ->
    @_super arguments...
