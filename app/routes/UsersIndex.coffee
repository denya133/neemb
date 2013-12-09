App = require 'app'

###*
  Route UsersIndexRoute

  @class UsersIndexRoute
  @namespace App
  @extends App.AuthorizedRoute
###
module.exports = App.UsersIndexRoute = App.AuthorizedRoute.extend
  init: ()->
    @_super arguments...
    console.log 'Init UsersIndexRoute'

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  model: (params) ->
    @_super arguments...
    @get('store').findAll 'user'

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  setupController: (controller, model) ->
    @_super arguments...
