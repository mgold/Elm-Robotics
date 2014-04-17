var port = process.argv[2] || 8000

var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')
  , five = require("johnny-five")
  , board = new five.Board()

app.listen(port);
io.set('log level', 1); // don't pring socket.io's debug messages

//webserver
function handler (req, res) {
  if (req.url == "/"){
      req.url = "/index.html"
  }
  fs.readFile(__dirname + req.url,
  function (err, data) {
    if (err) {
      //console.log(err);
      res.writeHead(500);
      return res.end('Error loading '+req.url);
    }
    res.writeHead(200);
    res.end(data);
  });
}

// don't stall motors
function threshhold(x){
    x = Math.abs(x);
    if (x < 48){ // change magic number experimentally
        return 0;
    }else{
        return x;
    }
}


board.on("ready", function() {
    // my robot has two motors and a proximity sensor
    // change pins and add other Johnny-Five devices as necessary
    var left = new five.Motor([5,4])
    var right = new five.Motor([6,7])
    var proxy = new five.Sensor("A0");

    left.brake();
    right.brake();

    io.sockets.on('connection', function (socket) {
        //The connection event fires every time the webpage is reloaded
        //So that fixes any problem of the ready callbacks being out of order

        proxy.on("data", function(){
            socket.emit("proxy", this.value);
        })

        socket.on('control', function (control) {
            if (control["enabled"]){
                if (control["drive"][0] > 0){
                    left.rev(threshhold(control["drive"][0]));
                }else{
                    left.fwd(threshhold(control["drive"][0]));
                }
                if (control["drive"][1] > 0){
                    right.rev(threshhold(control["drive"][1]));
                }else{
                    right.fwd(threshhold(control["drive"][1]));
                }
            }else{
                left.brake();
                right.brake();
            }
        });

    });
});


