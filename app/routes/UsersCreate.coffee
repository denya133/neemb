App = require 'app'

###*
  Route UsersCreateRoute

  @class UsersCreateRoute
  @namespace App
  @extends App.AuthorizedRoute
###
module.exports = App.UsersCreateRoute = App.AuthorizedRoute.extend
  init: ()->
    @_super arguments...
    console.log 'Init UsersCreateRoute'

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  model: (params) ->
    @_super arguments...
    @store.createRecord 'user'

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  setupController: (controller, model) ->
    @_super arguments...
