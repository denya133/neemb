###*
  Handlebars helper prettyTime

  @method prettyTime
  @for Ember.Handlebars.helpers
  @param {Number} Time in seconds
  @return {String} HTML string
###
module.exports = Ember.Handlebars.registerBoundHelper 'prettyTime', (seconds)->
  if typeof seconds is 'undefined'
    ''
  else
    displayHours = Math.floor seconds / 3600
    displayMinutes = Math.floor seconds / 60
    displaySeconds = Math.floor seconds % 60

    if displayMinutes < 10 and displayHours > 0
      displayMinutes = '0' + displayMinutes

    if displayHours is 0
      displayHours = ''
    else
      displayHours = displayHours + ':'

    if displaySeconds < 10
      displaySeconds = '0' + displaySeconds

    displayHours + displayMinutes + ':' + displaySeconds