Elmberry
========

Elmberry makes it possible to run Elm programs on your Raspberry Pi, and have the output on the GPIO pins. The caveat: you can't _compile_ them on the Pi (some of Elm's dependencies don't work well with ARM and Raspian's older version of GHC). Instead, you 
# Write your Elm on a "normal" computer
# Run `sh elmberry.sh myFile.elm`
# Copy `myFile_pi.js` to your Pi
# Run `nodejs myFile_pi.js`

**Dependencies:** Node (`sudo apt-get install node`) and [WiringPi](https://projects.drogon.net/raspberry-pi/wiringpi/download-and-install/).

Elmberry allows you to define outgoing [ports](http://elm-lang.org/blog/announce/0.11.elm) like `gpio22` or `pwm18` to control the Pi's GPIO pins, and the one PWM pin. At this moment, only _output_ is supported. The GPIO pins must have type `Signal Bool` and the PWM must have type `Signal Int`. This is currently not enforced at compile time. Only one file is supported. To get a better feel for what's going on, just read the code; there's not much of it!

Elmberry has only been tested on Raspian (Jan 2014 release), and I actually haven't had a chance to take a multimeter to the pins yet. But this testing checks out: `watch -d -n 0.1 gpio readall`. I'm hoping to expand it in the next few months.
