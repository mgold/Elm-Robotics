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

This code is meant to be extremely hackable, and not a monolithic framework. There are many layers but none of them are difficult. With that said, the example code targets a robot with two drive motors and a proximity sensor. Control the robot with the arrow keys. Whenever there is not exactly one arrow key down, the robot is disabled, and the motors braked.

The robot must be tethered to the computer running Node. I have not investigated using Bluetooth, but you are welcome to try.
