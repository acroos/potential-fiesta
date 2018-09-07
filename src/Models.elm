module Models exposing (..)

type alias Model = 
    { keystrokes : List Int
    , route : Route
    , downloadConfig : DownloadConfig
    }

initialModel : Route -> Model
initialModel route = 
    { keystrokes = []
    , route = route
    , downloadConfig = 
        { width = 1920
        , height = 1200
        , fileType = "svg"
        }
    }

type alias DownloadConfig =
    { width : Float
    , height : Float
    , fileType : String
    }

type Route
    = FiestaRoute
    | AboutRoute