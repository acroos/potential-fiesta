module View exposing (view)

import Html exposing (..)
import Models exposing (Model)
import Msgs exposing (Msg)
import Views.About exposing (aboutView)
import Views.Index exposing (indexView)

view : Model -> Html Msg
view model =
    page model


page : Model -> Html Msg
page model =
    case model.route of
        Models.FiestaRoute ->
            indexView model

        Models.AboutRoute ->
            aboutView