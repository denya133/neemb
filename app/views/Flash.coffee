App = require 'app'

###*
  View FlashView

  @class FlashView
  @namespace App
  @extends Ember.View
###
module.exports = App.FlashView = Ember.View.extend(
  contentBinding: "App.FlashController.content"
  classNameBindings: ["isNotice", "isWarning", "isError"]
  isNoticeBinding: "content.isNotice"
  isWarningBinding: "content.isWarning"
  isErrorBinding: "content.isError"
  didInsertElement: ->
    @$("#message").hide()
    App.FlashController.set "view", this

  show: (callback) ->
    @$("#message").css(top: "-40px").animate
      top: "+=40"
      opacity: "toggle"
    , 500, callback

  hide: (callback) ->
    @$("#message").css(top: "0px").animate
      top: "-39px"
      opacity: "toggle"
    , 500, callback
)