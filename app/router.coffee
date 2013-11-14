App = require 'app'


App.Router.map ->
  # put your routes here
  @resource 'sessions', () ->
    @route 'new'

  @resource 'users', () ->
    @route 'new'