App = require 'app'

###*
  Route UserIndexRoute

  @class UserIndexRoute
  @namespace App
  @extends App.AuthorizedRoute
###
module.exports = App.UserIndexRoute = App.AuthorizedRoute.extend
  init: ()->
    @_super arguments...
    console.log 'Init UserIndexRoute'

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  model: (params) ->
    @_super arguments...
    @modelFor 'user'

  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  setupController: (controller, model) ->
    @_super arguments...
