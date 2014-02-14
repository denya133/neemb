###*
  Handlebars helper prettyPercent

  @method prettyPercent
  @for Ember.Handlebars.helpers
  @param {Number} Complete percentage. Possible values: 0 <= decimal <= 1
  @return {String} HTML string
###
module.exports = Ember.Handlebars.registerBoundHelper 'prettyPercent', (decimal) ->
  if typeof decimal is 'undefined'
    ''
  else
    Math.round( decimal * 100 ) + '%'