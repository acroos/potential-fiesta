module Main exposing (..)

import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Ports exposing (bodyKeyPress)
import Routing exposing (parseLocation)
import Update exposing (update)
import View exposing (view)

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    bodyKeyPress Msgs.OnBodyKeyPress

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
