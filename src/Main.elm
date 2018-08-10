module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Ports exposing (bodyKeyPress)
import Update exposing (update)
import View exposing (view)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    bodyKeyPress Msgs.OnBodyKeyPress

main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
