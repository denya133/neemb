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
    
#     # user = App.User.find(userId).then =>
#     # @set 'apiKey', App.ApiKey.create
#     #   accessToken: accessToken
#     #   user: user
#     @set 'apiKey', Ember.Object.create
#       accessToken: 'accessToken'
#       user: 'user'
    

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
#     App.AuthManager.reset()  
#   throw reason

