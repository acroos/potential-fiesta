module Views.Graph exposing (graphView)

import Html exposing (Html, div, button)
import Html.Attributes exposing (id, class)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Utils exposing (partition, getOrDefault)

graphView : List Int -> Html Msg
graphView letters =
    Html.div []
        [ graph letters
        , downloadLink
        ]

downloadLink : Html Msg
downloadLink = 
    Html.button [ Html.Attributes.id "download-svg"
                , Html.Attributes.class "btn btn-outline-secondary btn-sm download-btn"
                , onClick (Msgs.DownloadSvg "canvas")
                ]
        [ Html.text "Download" ]

graph : List Int -> Svg Msg
graph letters =
    svg [ Html.Attributes.id "canvas" ]
        (List.indexedMap (\index code -> letterCircle code index) letters)

letterCircle : Int -> Int -> Svg Msg
letterCircle code index =
    circle 
        [ cx <| toPercentString <| (codeAndIndexToXPercent code index)
        , cy <| toPercentString <| (codeAndIndexToYPercent code index)
        , r <| toPercentString <| (codeAndIndexToRadius code index)
        , fill (codeAndIndexToFillRgba index code)
        ] []

toPercentString : Float -> String
toPercentString value =
    (toString value) ++ "%"

codeAndIndexToXPercent : Int -> Int -> Float
codeAndIndexToXPercent code index =
    let
        combined = combineIndexAndCode code index 2
    in
        randomPercentFromCode combined

codeAndIndexToYPercent : Int -> Int -> Float
codeAndIndexToYPercent code index =
    let
        combined = combineIndexAndCode code index 4
    in
        randomPercentFromCode combined

codeAndIndexToRadius : Int -> Int -> Float
codeAndIndexToRadius code index =
    let
        combined = combineIndexAndCode code index 8
    in
        randomFloatFromCode combined 1.0 25.0

randomPercentFromCode : Int -> Float
randomPercentFromCode code =
    randomFloatFromCode code 0.0 100.0

randomFloatFromCode : Int -> Float -> Float -> Float
randomFloatFromCode code min max =
    let
        seed = Random.initialSeed code
    in
        Tuple.first (Random.step (Random.float min max) seed)

codeToColor : Int -> Int
codeToColor code =
    floor <| (randomFloatFromCode code 0.0 255.0)

combineIndexAndCode : Int -> Int -> Int -> Int
combineIndexAndCode code index offset =
    code ^ ((index + offset) % code)

codeAndIndexToRed : Int -> Int -> Int
codeAndIndexToRed code index =
    codeToColor (combineIndexAndCode code index 1)

codeAndIndexToGreen : Int -> Int -> Int
codeAndIndexToGreen code index =
    codeToColor (combineIndexAndCode code index 3)

codeAndIndexToBlue : Int -> Int -> Int
codeAndIndexToBlue code index =
    codeToColor (combineIndexAndCode code index 5)

codeAndIndexToOpacity : Int -> Int -> Float
codeAndIndexToOpacity code index =
    (randomFloatFromCode (combineIndexAndCode code index 7) 0.2 0.8)

codeAndIndexToFillRgba : Int -> Int -> String
codeAndIndexToFillRgba index code =
    "rgba(" ++ (toString (codeAndIndexToRed code index)) ++ 
    ", " ++ (toString (codeAndIndexToGreen code index)) ++ 
    ", " ++ (toString (codeAndIndexToBlue code index)) ++
    ", " ++ (toString (codeAndIndexToOpacity code index)) ++ ")"