module Models exposing (..)

type alias Model = 
    { keystrokes : List Int
    , route : Route }

initialModel : Route -> Model
initialModel route = 
    { keystrokes = []
    , route = route
    }

type Route
    = FiestaRoute
    | AboutRoute