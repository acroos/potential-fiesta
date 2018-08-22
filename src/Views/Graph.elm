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
        [ graph letters False
        , downloadLink
        ]

downloadLink : Html Msg
downloadLink = 
    Html.button [ Html.Attributes.id "download-svg"
                , Html.Attributes.class "btn btn-outline-secondary btn-sm download-btn"
                , onClick (Msgs.DownloadSvg "canvas")
                ]
        [ Html.text "Download" ]

graph : List Int -> Bool -> Svg Msg
graph letters animated =
    let
        circleData = circleDataPoints letters
    in
        svg [ Html.Attributes.id "canvas" ]
            (List.map (\x -> letterCircle x animated) circleData)

circleDataPoints : List Int -> List(List Int)
circleDataPoints letters =
    partition letters 3

letterCircle : List Int -> Bool -> Svg Msg
letterCircle circleData animated =
    let
        rawX = getOrDefault circleData 0 50
        rawY = getOrDefault circleData 1 50
        rawR = getOrDefault circleData 2 50
    in
        circle 
            [ cx <| toPercentString <| codeToXPercent <| rawX
            , cy <| toPercentString <| codeToYPercent <| rawY
            , r <| toString <| codeToRadius <| rawR
            , fill (circleDataToFillColor rawX rawY rawR)
            , Svg.Attributes.class <| circleClass <| animated
            ] []

circleClass : Bool -> String
circleClass animated =
    if animated then
        "animated"
    else
        ""

toPercentString : Float -> String
toPercentString value =
    (toString value) ++ "%"

codeToXPercent : Int -> Float
codeToXPercent code =
    randomPercentFromCode (code * code)

codeToYPercent : Int -> Float
codeToYPercent code =
    randomPercentFromCode (code * code * code)

codeToRadius : Int -> Float
codeToRadius code =
    randomFloatFromCode (code // 2) 0.0 500.0

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

codeToOpacity : Int -> Float
codeToOpacity code =
    (randomFloatFromCode code 0.1 0.9)

circleDataToFillColor : Int -> Int -> Int -> String
circleDataToFillColor circleX circleY circleR =
    "rgba(" ++ (toString (codeToColor circleX)) ++ 
    ", " ++ (toString (codeToColor circleY)) ++ 
    ", " ++ (toString (codeToColor circleR)) ++
    ", " ++ (toString (codeToOpacity (circleX + circleY + circleR))) ++ ")"