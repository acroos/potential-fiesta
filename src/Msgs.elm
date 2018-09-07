module Msgs exposing (..)

import Navigation exposing (Location)

type Msg
    = OnBodyKeyPress Int
    | DownloadSvg String
    | OnLocationChange Location
    | GoBack