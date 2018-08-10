module Update exposing (update)

import Msgs exposing (Msg)
import Models exposing (Model, Route(..))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnBodyKeyPress keycode ->
            let
                newkeystrokes = model.keystrokes ++ [keycode]
            in
                ( { model | keystrokes = newkeystrokes }, Cmd.none )