roles = require 'roles'
mongoose = require 'mongoose'

User = mongoose.model 'User'

if not roles.getApplication "neemb"
  roles.setSeparator "/"
  roles.addApplication 'neemb', [
    "view"
    "create.user"
    "edit.profile"
    "edit.user"
    "delete.user"
  ]
  roles.addProfile "user", [
    "neemb/view"
  ]
  roles.addProfile "admin", [
    "neemb/view"
    "neemb/create.user"
    "neemb/edit.user"
    "neemb/delete.user"
  ]
  roles.addProfile "superadmin", [
    "neemb/*"
  ]

middleware = ()->
  rolesArr = arguments
  (req, res, next)->
    if req.cookies.auth_user
      User.findById(req.cookies.auth_user).populate('role').exec (err, user)->
        if err
          res.send 401,
            error: true
            message: "Please, sign in first"
        profile = roles.getProfile(user.role.name)
        if profile.hasRoles.apply profile, rolesArr
          next()
        else
          res.send 403,
            error: true
            message: "You don't have rights to view requested page"
    else
      res.send 401,
        error: true
        message: "Please, sign in first"

module.exports =
  middleware: middleware
  roles: roles
