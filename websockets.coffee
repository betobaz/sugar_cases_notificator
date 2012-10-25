connect = require('connect')
_ = require("underscore")

schemas = require('./schemas')

module.exports = (io, mongoose) ->
	GLOBAL.clients = []
	io.sockets.on 'connection', (socket) ->
		#console.log "id socket", socket
		socket.emit 'news', {myMessages:['world']}

		socket.on 'storeClientInfo', (data) ->
			if data.contact_id 
				GLOBAL.clients.push 
					socket_id: socket.id
					contact_id: data.contact_id
			NotificacionModel = mongoose.model 'Notification', schemas.Notification
			NotificacionModel.find().where('contact_id').equals(data.contact_id).select().exec( (err, notifications) ->
				if !err 
					socket.emit 'nuevas_notificaciones', {notificaciones: notifications}
				else
					console.log err
			)
			console.log "clients", clients
			


		socket.on 'disconnect', (data)->
			clients = _.filter clients, (item) ->
				item.socket_id != socket.id
				console.log "el cliente del socket #{socket.id} se ha desconectado"
			console.log "clients", clients


		socket.on 'my other event', (data)->
			if data.message
				messageBuffer.push 
					message: data.message
					status: 'unread'
					date_entered: new Date

			if messageBuffer.length == 3
				console.log messageBuffer
				io.sockets.emit 'nuevas_notificaciones', {notificaciones: messageBuffer}
				messageBuffer = []
			console.log data