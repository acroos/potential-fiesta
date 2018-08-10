module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Ports exposing (bodyKeyPress)
import Update exposing (update)
import View exposing (view)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    bodyKeyPress Msgs.OnBodyKeyPress

---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
