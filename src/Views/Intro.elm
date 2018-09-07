module Views.Intro exposing (introView)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Routing exposing (aboutPath)

introView : Html Msg
introView =
    jumbotron [ header, whyLink ]

jumbotron : List (Html Msg) -> Html Msg
jumbotron children =
    div [ class "jumbotron jumbotron-fluid" ]
        children

header : Html msg
header =
    h1 [ class "text-center display-1" ]
        [ text "type something" ]

whyLink : Html Msg
whyLink =
    p [ class "text-center" ]
        [ a [ class "dark-link", href aboutPath ]
            [ text "why?" ]
        ]