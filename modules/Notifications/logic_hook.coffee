_ = require("underscore")
module.exports = {
	before_create:[
		{
			name: "primer logic hook before create notification"
			callback: (bean) ->
				console.log "Ejecutando un logic hook before", bean
		}
	],
	after_create: [
		{		
			name: "primer logic hook after create notification"
			callback: (bean, io) -> 
				console.log "Ejecutando un logic hook after", bean				
				_.map GLOBAL.clients, (client) ->
					if client.contact_id == bean.contact_id
						io.sockets.socket(client.socket_id).emit 'nuevas_notificaciones', {notificaciones: [bean]}
		},
		{		
			name: "segundo logic hook after create notification"
			callback: (bean, io) -> 
				console.log "Ejecutando segundo logic hook after", bean			
		}
	]
}