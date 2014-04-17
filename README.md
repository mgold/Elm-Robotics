Elmduino
========
_A starter kit to programming [Arduino](http://arduino.cc)-based robots in [Elm](http://elm-lang.org)._

Powered by [Node.js](http://nodejs.org), including [Johnny-Five](http://github.com/rwaldron/johnny-five) and [socket.io](http://socket.io), as well as [Firmata](http://firmata.org) and [Elm ports](http://elm-lang.org/learn/Ports.elm).

The Ardunino is flashed with Firmata and then controlled from Node with Johnny-Five in Node. You write no Ardunino code. Node uses socket.io to pass events in both directions to the compiled Elm that it hosts. Elm uses ports to receive and transmit values.

Once you have Node and Elm installed and the robot connected, compile and run using
````bash
elm --only-js robot.elm
node server.js
````

Enable the robot using the space bar. I haven't been able to brake the robot when the server quits so disable it before doing so.

This code is meant to be extremely hackable, and not a monolithic framework. There are many layers but none of them are difficult.

The robot must be tethered to the computer running Node. I have not investigated using Bluetooth, but you are welcome to try.
