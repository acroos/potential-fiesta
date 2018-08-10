module Models exposing (..)

type alias Model = 
    { keystrokes : List Int }

initialModel : Model
initialModel = 
  { keystrokes = [] }

type Route
    = FiestaRoute