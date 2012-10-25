express = require('express')
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)
mongoose = require('mongoose')


mongoose.connect('mongodb://localhost/casos')

app.use require('connect').bodyParser()
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

websockets = require('./websockets')(io, mongoose)

api = require('./api')(app, mongoose, io)

console.log 'Server started'

