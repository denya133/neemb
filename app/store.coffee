App = require 'app'

###
# Remove this return to enable a store with a REST adapter on your app
# if you're migrating, https://github.com/emberjs/data/blob/master/TRANSITION.md is a good help
###
# return

###*
  Our store

  @class Store
  @namespace App
  @extends DS.Store
###
module.exports = App.Store = DS.Store.extend()
  # revision: 13
  # adapter: DS.RESTAdapter.create()


###*
  The application adapter

  @class ApplicationAdapter
  @namespace App
  @extends DS.ActiveModelAdapter
###
App.ApplicationAdapter = DS.RESTAdapter.extend #DS.ActiveModelAdapter.extend #DS.RESTAdapter.extend()
  ###*
    Put the host of your API here

    @inheritDoc
  ###
  host: App.CONFIG.API.host

  ###*
    Put the path/namespace of your API here

    @inheritDoc
  ###
  namespace: App.CONFIG.API.namespace

  serializer: App.ApplicationSerializer

  ajaxError: (jqXHR)->
    error = @_super jqXHR
    if jqXHR
      response = JSON.parse(jqXHR.responseText)
      switch jqXHR.status
        when 401
          App.FlashQueue.pushFlash 'error', response.message
          App.__container__.lookup('router:main').transitionTo('sessions.new')
        when 403
          App.FlashQueue.pushFlash 'error', response.message
          App.__container__.lookup('router:main').transitionTo('index')
        when 404
          console.log 'Not found'
        when 500
          console.log 'Server error'
        else
          console.log 'Unhandled error', jqXHR.status
    error

  ajax: (url, type, hash)->
    adapter = this

    new Ember.RSVP.Promise( (resolve, reject)->
      hash = hash || {}
      hash.url = url
      hash.type = type
      hash.dataType = 'json'
      hash.context = adapter

      if hash.data and type isnt 'GET'
        hash.contentType = 'application/json; charset=utf-8'
        hash.data = JSON.stringify hash.data

      if adapter.headers isnt undefined
        headers = adapter.headers
        hash.beforeSend = (xhr)->
          forEach.call(Ember.keys(headers), (key)->
            xhr.setRequestHeader key, headers[key]
          )

      hash.success = (json, status, jqXHR)->
        if json.error
          App.FlashQueue.pushFlash 'error', json.message
          Ember.run null, resolve, {}
        else
          Ember.run null, resolve, json

      hash.error = (jqXHR, textStatus, errorThrown)=>
        Ember.run null, reject, adapter.ajaxError(jqXHR)

      Ember.$.ajax hash
    )


###*
  If you need to customize the serializer for any reason, here is where it should go:

  @class ApplicationSerializer
  @namespace App
  @extends DS.ActiveModelSerializer
###
App.ApplicationSerializer = DS.RESTSerializer.extend #DS.ActiveModelSerializer.extend #DS.RESTSerializer.extend
  # youre code here
  primaryKey: '_id'

  serializeId: (id) ->
    id.toString()
