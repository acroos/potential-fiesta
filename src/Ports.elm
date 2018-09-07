port module Ports exposing (..)

import Json.Encode exposing (Value)

port bodyKeyPress : (Int -> msg) -> Sub msg
port downloadFile : Value -> Cmd msg