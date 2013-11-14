App = require 'app'

###*
  Controller ApplicationController

  @class ApplicationController
  @namespace App
  @extends Ember.Controller
###
module.exports = App.ApplicationController = Ember.Controller.extend
  # put your code here
  # currentUser: (() ->
  #   return App.Auth.get 'apiKey.user'
  # ).property('App.Auth.apiKey')

  # isAuthenticated: (() ->
  #   return App.Auth.isAuthenticated()
  # ).property('App.Auth.apiKey')
