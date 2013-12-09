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

  isAdmin: (()->
    user = App.Auth.get 'apiKey.user'
    unless (user and typeof user isnt "undefined")
      false
    else
      user.get('_data.role.name') is 'admin'
  ).property('App.Auth.apiKey')

  isSuper: (()->
    user = App.Auth.get 'apiKey.user'
    unless (user and typeof user isnt "undefined")
      false
    else
      user.get('_data.role.name') is 'superadmin'
  ).property('App.Auth.apiKey')

  delRights: (()->
    user = App.Auth.get 'apiKey.user'
    unless (user and typeof user isnt "undefined")
      false
    else
      role = user.get('_data.role.name')
      if (role is "superadmin" or role is "admin") then true else false
  ).property('App.Auth.apiKey')

  actions:
    logout: () ->
      App.Auth.reset()
      @transitionToRoute 'sessions.new'