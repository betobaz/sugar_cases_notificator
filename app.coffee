express = require('express')
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.set 'view options', 
	layout: false
app.use "/stylesheets", express.static(__dirname + '/public/stylesheets')
app.use "/javascripts", express.static(__dirname + '/public/javascripts')
app.use "/images", express.static(__dirname + '/public/images')

server.listen 3000
#fs = require('fs')
app.get '/', (req, res) ->
	res.render 'index', 
		title: 'Betobaz socket io'
		content: "Contenido de betobaz"
	
messageBuffer = []
io.sockets.on 'connection', (socket) ->
	socket.emit 'news', {myMessages:['world']}
	socket.on 'my other event', (data)->
		if data.message
			messageBuffer.push data.message
		if messageBuffer.length == 3
			console.log messageBuffer
			io.sockets.emit 'news', {myMessages: messageBuffer}
			messageBuffer = []
		console.log data

console.log 'Server started'

