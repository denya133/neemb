roles = require 'roles'
mongoose = require 'mongoose'

User = mongoose.model 'User'

if not roles.getApplication "neemb"
  roles.setSeparator "/"
  roles.addApplication 'neemb', [
    "view"
    "create.embed"
    "create.phone"
    "create.campaign"
    "create.address"
    "create.user"
    "create.client"
    "edit.profile"
    "edit.embed"
    "edit.phone"
    "edit.campaign"
    "edit.address"
    "edit.user"
    "edit.client"
    "delete.embed"
    "delete.phone"
    "delete.campaign"
    "delete.address"
    "delete.user"
    "delete.client"
  ]
  roles.addProfile "user", [
    "neemb/view"
    "neemb/create.embed"
    "neemb/create.phone"
    "neemb/edit.profile"
    "neemb/edit.embed"
    "neemb/edit.phone"
    "neemb/delete.embed"
    "neemb/delete.phone"
  ]
  roles.addProfile "admin", [
    "neemb/view"
    "neemb/create.embed"
    "neemb/create.phone"
    "neemb/create.campaign"
    "neemb/create.address"
    "neemb/create.user"
    "neemb/edit.profile"
    "neemb/edit.embed"
    "neemb/edit.phone"
    "neemb/edit.campaign"
    "neemb/edit.address"
    "neemb/edit.user"
    "neemb/delete.embed"
    "neemb/delete.phone"
    "neemb/delete.campaign"
    "neemb/delete.address"
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
