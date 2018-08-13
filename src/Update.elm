module Update exposing (update)

import Commands exposing (downloadSvg)
import Msgs exposing (Msg)
import Models exposing (Model, Route(..))
import Routing exposing (parseLocation)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnBodyKeyPress keycode ->
            let
                newkeystrokes = model.keystrokes ++ [keycode]
            in
                ( { model | keystrokes = newkeystrokes }, Cmd.none )
        
        Msgs.DownloadSvg id ->
            ( model, (downloadSvg id))

        Msgs.OnLocationChange location ->
            let
                newRoute = parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
