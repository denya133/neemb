###*
  Handlebars helper checkRights

  @method checkRights
  @for Ember.Handlebars.helpers
  @param {Object} [context]*
  @return {String} HTML string
###
module.exports = Ember.Handlebars.registerHelper 'checkRights', (value, options) ->
  context = (options.contexts && options.contexts[0]) || this
  if App.Auth.get 'apiKey'
    roleName = App.Auth.get('apiKey.user._data.role.name')
    profile = App.RoleRights.getProfile App.Auth.get('apiKey.user._data.role.name')
    if profile.hasRoles value
      options.fn this
    else
      options.inverse this
  else
    options.inverse this