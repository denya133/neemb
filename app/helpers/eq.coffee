###*
  Handlebars helper eq

  @method eq
  @for Ember.Handlebars.helpers
  @param {Object} [context]*
  @return {String} HTML string
###
module.exports = Ember.Handlebars.registerHelper 'eq', (value1, value2, options) ->
  value1Arr = value1.split '.'
  keyword = value1Arr.splice(0,1)
  if value1Arr.length
    value1 = options.data.keywords[keyword].get(value1Arr.join '.')
  else if options.data.keywords[keyword]
    value1 = options.data.keywords[keyword]
  value2Arr = value2.split '.'
  keyword = value2Arr.splice(0,1)
  if value2Arr.length
    value2 = options.data.keywords[keyword].get(value2Arr.join '.')
  else if options.data.keywords[keyword]
    value2 = options.data.keywords[keyword]
  if value1 is value2
    options.fn this
  else
    options.inverse this