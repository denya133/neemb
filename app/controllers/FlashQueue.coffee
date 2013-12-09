App = require 'app'

###*
  Controller FlashQueue

  @class FlashQueue
  @namespace App
  @extends Ember.ArrayProxy
###
module.exports = App.FlashQueue = Ember.ArrayProxy.create
  content: []
  contentChanged: ()->
    current = App.FlashController.get "content"
    if current isnt this.objectAt 0
      App.FlashController.set "content", this.objectAt 0
  pushFlash: (type, message)->
    @pushObject App.FlashMessage.create(
      message: message
      type: type
    )

App.FlashQueue.addObserver 'length', ()->
  @contentChanged()
