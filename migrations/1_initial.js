var
  bcrypt  = require('bcrypt'),
  md5     = require('md5'),
  uuid    = require("node-uuid");
exports.migrate = function(client, done) {
  var db = client.db;
  db.collection('roles').insert([{name: 'user'}, {name: 'admin'}, {name: 'superadmin'}], function(err, roles) {
    if (err) done(err);
    db.collection('roles').findOne({
      name: 'superadmin'
    }, function(err, role) {
      if (err) done(err);
      db.collection('users').insert({
        first_name: "Admin",
        last_name: "Adminovich",
        email: "admin@neemb.org",
        created_at: new Date(),
        updated_at: new Date(),
        password: bcrypt.hashSync(md5.digest_s("123"), 10),
        apikey: null,
        userType: null,
        role: role._id
      }, function(err, users) {
        var user = users[0];
        if (err) done(err);
        db.collection('apikeys').insert({
          userId: user._id,
          key: uuid.v4()
        }, function(err, apikeys) {
          var apikey = apikeys[0];
          user.apikey = apikey._id;
          db.collection('users').save(user, function() {
            done();
          });
        });
      });
    });
  });
};

exports.rollback = function(client, done) {
  var db = client.db;
  db.collection('users').remove({email: 'admin@neemb.org'}, function(err) {
    if (err) done(err);
    db.collection('roles').remove();
    done();
  });
};
