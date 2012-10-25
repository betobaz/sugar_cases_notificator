mongoose = require('mongoose')
Schema = mongoose.Schema
schemas = {}
schemas.Notification = new Schema
	contact_id:
		type: String
	message: 
		type: String
		required: true
	date_entered:
		type: Date
		default: Date.now
	date_modified:
		type: Date
		default: Date.now
	status:
		type: String
		default: "unread"
	type:
		type: String
		default: "caso"
	case_id:
		type: String

schemas.Session = new Schema
	contact_id:
		type: String
	session_id:
		type: String

module.exports = schemas
