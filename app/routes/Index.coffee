App = require 'app'


###*
  Route IndexRoute

  @class IndexRoute
  @namespace App
  @extends Ember.Route
###
module.exports = App.IndexRoute = Ember.Route.extend
  ###*
    Override this if needed, else remove it

    @inheritDoc
  ###
  init: () ->
    @_super arguments...
    console.log 'init of IndexRoute'
    App.Auth = App.AuthManager.create() unless App.Auth
  ###*
    Our model, just some info message as of example and all the font awesome icons

    @inheritDoc
  ###
  model: (params) ->
    infoMessage: """
      Compiled on branch #{App.CONFIG.BUILD.gitBranch}
      at #{App.CONFIG.BUILD.date.toTimeString()}
      on #{App.CONFIG.BUILD.date.toDateString()}
      <br/>
      with hash #{App.CONFIG.BUILD.gitCommitHash}
      """
    iconNames: Ember.A(App.BsIconComponent.NAMES)
