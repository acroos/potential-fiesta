module Views.About exposing (aboutView)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)

aboutView : Html Msg
aboutView = 
    div [ class "about" ]
        [ div [ class "w-50 mx-auto" ]
            [ aboutParagraph
            , goBack]
        ]

aboutParagraph : Html Msg
aboutParagraph =
    div [ class "text-center m-5" ]
        aboutText

goBack : Html Msg
goBack =
    p [ class "text-center" ] 
    [ a [ href "/", class "dark-link" ] [ text "go back" ] ]

aboutText : List (Html Msg)
aboutText =
    List.intersperse lineBreak (List.map text textLines)

textLines : List String
textLines = 
    [ "This is an \"art\" project created with the intention of giving an alternate meaning to words."
    , "Type anything you want, it will never be recorded or saved (except maybe by Google.)"
    , "As you're typing, the letters will be converted into colorful circles."
    , ""
    , ""
    , "The lack of control is intentional."
    , "You are not meant to copy/paste something just to see its representation."
    , "Instead, try typing something that evokes emotion or inspires you."
    , ""
    , ""
    , "I hope you find this little site fun to play with."
    , "If you want to share anything with me, send me an email: me@acroos.site"]

lineBreak : Html Msg
lineBreak =
    br [] []