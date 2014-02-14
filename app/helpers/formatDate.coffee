###*
  Handlebars helper formatDate

  @method formatDate
  @for Ember.Handlebars.helpers
  @param {Object} [context]*
  @return {String} HTML string
###
module.exports = Ember.Handlebars.registerBoundHelper 'formatDate', (date, format, options) ->
  moment(date).format(format)