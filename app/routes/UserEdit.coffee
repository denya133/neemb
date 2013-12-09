App = require 'app'

###*
  Route UserEditRoute

  @class UserEditRoute
  @namespace App
  @extends App.AuthorizedRoute
###
module.exports = App.UserEditRoute = App.AuthorizedRoute.extend
  init: ()->
    @_super arguments...
    console.log 'Init UserEditRoute'

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
