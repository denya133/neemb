App = require 'app'


App.Router.map ->
  # Session Routes
  @resource 'sessions', () ->
    @route 'new'

  # User Routes
  @resource 'users', () ->
    @route 'create'

  @resource 'user', { path: 'user/:user_id' }, () ->
    @route 'edit'
    @route 'delete'