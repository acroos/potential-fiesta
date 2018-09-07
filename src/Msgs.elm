module Msgs exposing (..)

import Navigation exposing (Location)

type Msg
    = OnBodyKeyPress Int
    | DownloadImage
    | OnLocationChange Location
    | GoBack
    | UpdateDownloadConfigWidth Float
    | UpdateDownloadConfigHeight Float
    | UpdateDownloadConfigFileType String