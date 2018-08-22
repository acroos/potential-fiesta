module Commands exposing (..)

import Msgs exposing (Msg)
import Ports

downloadSvg : String -> Cmd Msg
downloadSvg id =
    Ports.downloadFile id