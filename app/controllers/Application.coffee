App = require 'app'

###*
  Controller ApplicationController

  @class ApplicationController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.ApplicationController = Ember.Controller.extend

  currentUser: (() ->
    App.Auth.get 'apiKey.user'
  ).property('App.Auth.apiKey')

  isAuthenticated: (() ->
    App.Auth.isAuthenticated()
  ).property('App.Auth.apiKey')

  actions: 
    logout: () ->
      App.Auth.reset()
      @transitionToRoute 'index'