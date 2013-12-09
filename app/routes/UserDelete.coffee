App = require 'app'

###*
  Route UserDeleteRoute

  @class UserDeleteRoute
  @namespace App
  @extends App.AuthorizedRoute
###
module.exports = App.UserDeleteRoute = App.AuthorizedRoute.extend
  init: ()->
    @_super arguments...
    console.log 'Init UserDeleteRoute'

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
