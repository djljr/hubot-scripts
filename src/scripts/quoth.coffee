# Description:
#   Post to a ticket quote board
#
# Dependencies:
#   socket.io-client 0.9.x
#
# Commands:
#   hubot quoth <author> <quote> - add a quote to the quoteboard
#
# Author:
#   djljr

io = require('socket.io-client')

module.exports = (robot) ->
	socket = io.connect 'quotes.markdrago.com', {port:80}
	robot.respond /quoth ([^"]+) "(.*)"$/i, (msg) ->
		newid = Math.floor(Math.random() * 1000000000); # wtf
		dt = new Date()
		now = dt.getTime()
		phraseobj = 
			ids: [newid]
			phrases: {}
		phraseobj.phrases[newid] = 
			phrase: msg.match[2]
			author: msg.match[1]
			created_time: now
		socket.emit('new_phrase', phraseobj)
		msg.send("So quoted.")