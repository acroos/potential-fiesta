module Routing exposing (..)

import Models exposing (Route(..))
import Navigation exposing (Location)
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map FiestaRoute top
        , map AboutRoute (s "about")
        , map AboutRoute (s "about/")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            FiestaRoute

aboutPath : String
aboutPath =
    "#about"

boolParam : String -> QueryParser (Bool -> a) a
boolParam name =
    customParam name boolParamHelper

boolParamHelper : Maybe String -> Bool
boolParamHelper name =
    case name of
        Nothing ->
            False
        Just value ->
            (String.toLower (String.trim value)) == "true"