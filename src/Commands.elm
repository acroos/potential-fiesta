module Commands exposing (..)

import Json.Encode exposing (..)
import Models exposing (DownloadConfig)
import Msgs exposing (Msg)
import Ports

downloadImage : DownloadConfig -> Cmd Msg
downloadImage config =
    let
        jsonValue =
            object
                [ ("width", float config.width)
                , ("height", float config.height)
                , ("fileType", string config.fileType)
                ]
    in
        Ports.downloadFile jsonValue