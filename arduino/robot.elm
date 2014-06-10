import Window
import Keyboard

port proximity : Signal Float

data Dynamics = Stopped | Forward | Back | Left | Right

direction : {x:Int, y:Int} -> Dynamics
direction {x, y} = case (x,y) of
    (-1,0) -> Left
    (1,0) -> Right
    (0,1) -> Forward
    (0, -1) -> Back
    _ -> Stopped

type Control = {enabled : Bool, drive : (Int, Int)}
protocol : Dynamics -> Control
protocol d = case d of
    Left -> running (255, -255)
    Right -> running (-255, 255)
    Forward -> running (255, 255)
    Back -> running (-255, -255)
    Stopped -> stopped

running : (Int, Int) -> Control
running r = {enabled=True, drive=r}

stopped : Control
stopped = {enabled=False, drive=(0,0)}

control = protocol . direction <~ Keyboard.arrows

port control_out : Signal {enabled : Bool, drive : (Int, Int)}
port control_out = control

-- Dashboard rendering

scene prx {enabled, drive}  = flow down
    [(if enabled then toText "ENABLED"  |> Text.color green
            else toText "DISABLED" |> Text.color red)
        |> Text.height 60 |> centered
      , show prx |> toText |> Text.height 40 |> centered
      , show drive |> toText |> Text.height 40 |> centered
    ]

center (w,h) = container w h middle

main = lift2 center Window.dimensions <| scene <~ proximity ~ control
