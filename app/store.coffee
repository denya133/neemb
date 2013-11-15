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
