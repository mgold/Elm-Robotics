port gpio22 : Signal Bool
port gpio22 = foldp (always not) True (fps 1)

port gpio23 : Signal Bool
port gpio23 = foldp (always not) True (fps 50)

port pwm18 : Signal Int
port pwm18 = let
    toggler = foldp (always not) True (fps 0.2)
    choose b x y = if b then x else y
        in lift3 choose toggler sinusoid sawtooth

clock : Float -> Signal Float
clock speed = foldp (+) 0 (fps 150) |> lift (\n -> n * speed)

sinusoid : Signal Int
sinusoid = let
    byteSine : Float -> Int
    byteSine x = (sin x + 1) * 512 |> round
        in lift byteSine (clock <| 1/100)

sawtooth : Signal Int
sawtooth = lift (\x -> truncate x `mod` 1024) (clock 10)
