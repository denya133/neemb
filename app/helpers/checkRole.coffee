###*
  Handlebars helper checkRole

  @method checkRole
  @for Ember.Handlebars.helpers
  @param {Object} [context]*
  @return {String} HTML string
###
module.exports = Handlebars.registerHelper 'checkRole', (roles, options)=>
  roles = roles.split(',')

  if App.Auth.isAuthenticated()
    userRole = App.Auth.get 'apiKey.user._data.role.name'
    for role in roles
      if userRole is role
        return options.fn this
  options.inverse this