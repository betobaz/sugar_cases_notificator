schemas = require('./schemas')
logic_hooks = require("./modules/Notifications/logic_hook")

_ = require("underscore")

module.exports = (app, mongoose, io)->
	NotificacionModel = mongoose.model 'Notification', schemas.Notification
	app.get '/api/notifications', (req, res) ->
		return NotificacionModel.find (err, notifications) ->
			if !err
				console.log notifications
				return res.send(notifications)
			else
				console.log(err)
				return res.send([])

	app.post '/api/notifications', (req, res) ->
		notification = null
		console.log "POST: "
		console.log req.body
		notification = new NotificacionModel
			message: req.body.message
			contact_id: req.body.contact_id
			case_id: req.body.case_id
		notification.save (err)->
			if !err
				return console.log "created"
			else
				return console.log err
		_.map logic_hooks.after_create, (item)->
			try				
				console.log "api::notification::POST ", item.name
				item.callback notification, io
			catch e
				console.log(e)
		res.send notification

	app.get '/api/notifications/:id', (req, res)->
		NotificacionModel.findById req.params.id, (err, notification)->
			if !err 
				return res.send notification
			else
				console.log err
				return {}

	app.put '/api/notifications/:id', (req, res) ->
		NotificacionModel.findById req.params.id, (err, notification) ->			
			notification.status = req.body.status
			notification.save (err)->
				if !err
					console.log "updated"
				else
					console.log err
				return res.send notification