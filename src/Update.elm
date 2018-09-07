module Update exposing (update)

import Commands exposing (downloadImage)
import Msgs exposing (Msg)
import Models exposing (Model, Route(..))
import Navigation exposing (back)
import Routing exposing (parseLocation)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnBodyKeyPress keycode ->
            let
                newkeystrokes = model.keystrokes ++ [keycode]
            in
                ( { model | keystrokes = newkeystrokes }, Cmd.none )

        Msgs.DownloadImage ->
            ( model, (downloadImage model.downloadConfig))

        Msgs.OnLocationChange location ->
            let
                newRoute = parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
        
        Msgs.GoBack ->
            ( model, Navigation.back 1 )


        Msgs.UpdateDownloadConfigWidth width ->
            let
                oldConfig = model.downloadConfig
                newConfig = { oldConfig | width = width }
            in
                ( { model | downloadConfig = newConfig }, Cmd.none )

        Msgs.UpdateDownloadConfigHeight height ->
            let
                oldConfig = model.downloadConfig
                newConfig = { oldConfig | height = height }
            in
                ( { model | downloadConfig = newConfig }, Cmd.none )

        Msgs.UpdateDownloadConfigFileType fileType ->
            let
                oldConfig = model.downloadConfig
                newConfig = { oldConfig | fileType = fileType }
            in
                ( { model | downloadConfig = newConfig }, Cmd.none )