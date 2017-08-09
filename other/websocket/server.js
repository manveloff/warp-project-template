////=============================================////
////                                             ////
////            Nodejs websocket seerver         ////
////																			       ////
////=============================================////

	// 1. Require http and socket.io modules
	const app 				= require('http').createServer(handler);
	const io 					= require('socket.io')(app);
  const co 					= require('co');
	const log 				= require('winston');
  const Redis       = require('ioredis');

	// 2. Require ioredis module
	// - And create new Redis connection
	var redis = new Redis({
		host: 'redis',
		port: '6379',
    password: '1234567890'
	});

	// 3. Listen to HTTP-port 6001
	// - Clients will use it when connect
	app.listen(6001, function() {
		//console.log('Server is running!');
	});

	// 4. Assign handler
	// - Срабатывает, когда в любой канал Redis'а поступает новое сообщение
	redis.on('pmessage', function(subscribed, channel, message) {

		// Notify that handler is invoking
		//console.log('Handler is working! Channel: '+channel+'. Message: '+message);	

    // Add message to log
    //log.info(message);
    
		// Parse message
		// - message.event  | contains even name in Laravel with full namespace
		// - message.data   | contains data to send clients
		message = JSON.parse(message);

		// Send the data to all subscribed on channel clients
		io.emit(channel, message.data);

	});