App = require 'app'

###*
  Route AuthorizedRoute

  @class AuthorizedRoute
  @namespace App
  @extends Ember.Route
###
module.exports = App.AuthorizedRoute = Ember.Route.extend
  ###*
   * Initialize App.Auth
  ###
  init: ()->
    @_super arguments...
    console.log 'Init of AuthorizedRoute'
    App.Auth = App.AuthManager.create() unless App.Auth

  ###*
   * Check user roles
  ###
  beforeModel: (transition)->
    # unless @get 'access'
    #   yes
    # else
    #   unless @get('access').contains App.Auth.get('apiKey.user.role.name')
    #     App.FlashQueue.pushFlash 'error', "You don't have rights for access to route #{this.routeName}"
    #     @transitionTo 'index'
    #   yes

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
