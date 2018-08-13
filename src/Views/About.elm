module Views.About exposing (aboutView)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)

aboutView : Html Msg
aboutView = 
    div [ class "about" ]
        [ div [ class "w-50 mx-auto" ]
            [ aboutParagraph ]
        ]

aboutParagraph : Html Msg
aboutParagraph =
    p [ class "text-center m-5" ]
        [ text aboutText ]

aboutText : String
aboutText =
    """

    """