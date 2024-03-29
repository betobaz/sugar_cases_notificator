// Generated by CoffeeScript 1.3.3
(function() {
  var _;

  _ = require("underscore");

  module.exports = {
    before_create: [
      {
        name: "primer logic hook before create notification",
        callback: function(bean) {
          return console.log("Ejecutando un logic hook before", bean);
        }
      }
    ],
    after_create: [
      {
        name: "primer logic hook after create notification",
        callback: function(bean, io) {
          console.log("Ejecutando un logic hook after", bean);
          return _.map(GLOBAL.clients, function(client) {
            if (client.contact_id === bean.contact_id) {
              return io.sockets.socket(client.socket_id).emit('nuevas_notificaciones', {
                notificaciones: [bean]
              });
            }
          });
        }
      }, {
        name: "segundo logic hook after create notification",
        callback: function(bean, io) {
          return console.log("Ejecutando segundo logic hook after", bean);
        }
      }
    ]
  };

}).call(this);
