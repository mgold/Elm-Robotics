import Window
import Keyboard

port proxy : Signal Float

enabled : Signal Bool
enabled = foldp (always not) False <| keepIf id True Keyboard.space



drive : Signal (Int, Int)
drive = constant (255, 255)



port control : Signal {enabled : Bool, drive : (Int, Int)}
port control = (\en dr -> {enabled=en, drive=dr}) <~ enabled ~ drive

-- Dashboard rendering

scene prx en drv = flow down
    [(if en then toText "ENABLED"  |> Text.color green
            else toText "DISABLED" |> Text.color red)
        |> Text.height 90 |> centered
      , show prx |> toText |> Text.height 60 |> centered
      , show drv |> toText |> Text.height 60 |> centered
    ]


center (w,h) = container w h middle

main = lift2 center Window.dimensions <| scene <~ proxy ~ enabled ~ drive
