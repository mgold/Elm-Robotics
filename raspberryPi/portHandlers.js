var myElm = Elm.worker(Elm.Main)
var exec = require('child_process').exec
function gpio(pin){
    exec("gpio -g mode "+pin+" out")
    return function(b){ exec("gpio -g write " + pin + (b ? " 1" : " 0"))}
}
exec("gpio mode 1 pwm")
function pwm(val){
    val = val > 1024 ? 1024 : (val < 0 ? 0 : val)
    exec("gpio pwm 1 "+val)
}
// Add or remove GPIOs here
myElm.ports.gpio22.subscribe(gpio(22));
myElm.ports.gpio23.subscribe(gpio(23));
myElm.ports.pwm18.subscribe(pwm);
