App = require 'app'

###*
  Controller FlashController

  @class FlashController
  @namespace App
  @extends Ember.Object
###
module.exports = App.FlashController = Ember.Object.create(
  content: null
  clearContent: (content, view) ->
    view.hide ->
      App.FlashQueue.removeObject content
)

App.FlashController.addObserver "view", ->
  if @get 'content'
    if @get "view"
      @get("view").show()
      setTimeout @clearContent, 4000, @get("content"), @get("view")
