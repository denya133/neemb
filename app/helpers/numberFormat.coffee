###*
  Handlebars helper numberFormat

  @method numberFormat
  @for Ember.Handlebars.helpers
  @param {Object} [context]*
  @return {String} HTML string
###
module.exports = Ember.Handlebars.registerBoundHelper 'numberFormat', (value, options) ->
  decimals = 2
  dec_point = ","
  thousands_sep = " "
  i = parseInt(value = (+value or 0).toFixed(decimals)) + ""
  if (j = i.length) > 3
    j = j % 3
  else
    j = 0
  km = ((if j then i.substr(0, j) + thousands_sep else ""))
  kw = i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands_sep)
  
  kd = ((if decimals then dec_point + Math.abs(value - i).toFixed(decimals).replace(/-/, 0).slice(2) else ""))
  km + kw + kd