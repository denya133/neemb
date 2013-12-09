# App = require 'app'


# module.exports = App.AuthManager = Ember.Object.extend

#   # Load the current user if the cookies exist and is valid
#   init: () ->
#     @_super arguments...
#     accessToken = $.cookie 'access_token'
#     authUserId  = $.cookie 'auth_user'
#     if (!Ember.isEmpty(accessToken) && !Ember.isEmpty(authUserId))
#       @authenticate accessToken, authUserId

#   # Determine if the user is currently authenticated.
#   isAuthenticated: () ->
#     !Ember.isEmpty(@get('apiKey.accessToken')) && !Ember.isEmpty(@get('apiKey.user'))  

#   # Authenticate the user. Once they are authenticated, set the access token to be submitted with all
#   # future AJAX requests to the server.
#   authenticate: (accessToken, userId) ->
#     $.ajaxSetup
#       headers: { 'Authorization': 'Bearer ' + accessToken }
    
#     # console.log userId
#     # console.log accessToken

#     App.__container__.lookup('route:application').get('store').find('user', userId).then (user) =>
#       # console.log user
    
#       @set 'apiKey', App.Apikey.create
#         accessToken: accessToken
#         user: user

#       # console.log @get 'apiKey'
    

#   # Log out the user
#   reset: () ->
#     App.__container__.lookup("route:application").transitionTo('sessions.new')
#     Ember.run.sync()
#     Ember.run.next @, () ->
#       @set 'apiKey', null
#       $.ajaxSetup
#         headers: { 'Authorization': 'Bearer none' }    

#   # Ensure that when the apiKey changes, we store the data in cookies in order for us to load
#   # the user when the browser is refreshed.
#   apiKeyObserver: (() ->
#     if Ember.isEmpty(@get('apiKey'))
#       $.removeCookie 'access_token'
#       $.removeCookie 'auth_user'
#     else
#       $.cookie 'access_token', @get('apiKey.accessToken')
#       $.cookie 'auth_user', @get('apiKey.user.id')  
#   ).observes('apiKey')


# # Reset the authentication if any ember data request returns a 401 unauthorized error
# DS.rejectionHandler = (reason) ->
#   if (reason.status is 401) 
#     App.Auth.reset()  
#   throw reason

App = require 'app'

module.exports = App.AuthManager = Ember.Object.extend
  # Load the current user if the cookies exist and is valid
  init: () ->
    @_super arguments...
    accessToken = $.cookie 'access_token'
    authUserId  = $.cookie 'auth_user'
    if (!Ember.isEmpty(accessToken) && !Ember.isEmpty(authUserId))
      @authenticate accessToken, authUserId
    else
      App.__container__.lookup("route:application").transitionTo('sessions.new')

  # Determine if the user is currently authenticated.
  isAuthenticated: () ->
    !Ember.isEmpty(@get('apiKey.accessToken')) && !Ember.isEmpty(@get('apiKey.user'))

  # Authenticate the user. Once they are authenticated, set the access token to be submitted with all
  # future AJAX requests to the server.
  authenticate: (accessToken, userId) ->
    $.ajaxSetup
      headers: { 'Authorization': 'Bearer ' + accessToken }

    App.__container__.lookup('route:application').get('store').find('author', userId).then((user) =>
      if user
        @set 'apiKey', App.Apikey.create
          accessToken: accessToken
          user: user
      else
        @reset()
    ).fail (err)=>
      @reset()

  # Log out the user
  reset: () ->
    Ember.run.sync()
    Ember.run.next @, () ->
      @set 'apiKey', null
      $.ajaxSetup
        headers: { 'Authorization': 'Bearer none' }
      App.__container__.lookup("route:application").transitionTo('sessions.new')

  # Ensure that when the apiKey changes, we store the data in cookies in order for us to load
  # the user when the browser is refreshed.
  apiKeyObserver: (() ->
    if Ember.isEmpty(@get('apiKey'))
      $.removeCookie 'access_token'
      $.removeCookie 'auth_user'
    else
      $.cookie 'access_token', @get('apiKey.accessToken')
      $.cookie 'auth_user', @get('apiKey.user.id')
  ).observes('apiKey')


###*
 *
 * This doesn't work because ember-data doesn't call rejectionHandler
 *
###
# Reset the authentication if any ember data request returns a 401 unauthorized error
DS.rejectionHandler = (reason) ->
  if (reason.status is 401)
    App.Auth.reset()
    App.__container__.lookup("route:application").transitionTo('sessions.new')
  throw reason

