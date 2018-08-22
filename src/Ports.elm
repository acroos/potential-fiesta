port module Ports exposing (..)

port bodyKeyPress : (Int -> msg) -> Sub msg

port downloadFile : String -> Cmd msg