# Application bootstrapper

###*
  The application object

  @class App
  @extends Ember.Application
###
module.exports = App = Ember.Application.create
  ###*
    Name of the application

    @property name
    @type String
  ###
  name: 'NEEMB'

  # ###*
  #   We want to log transitions

  #   @property LOG_TRANSITIONS
  #   @type String
  #   @final
  # ###
  # LOG_TRANSITIONS: yes

window.App = App