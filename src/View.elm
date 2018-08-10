module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, style, attribute)
import Models exposing (Model)
import Msgs exposing (Msg)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Utils exposing (partition, getOrDefault)

view : Model -> Html Msg
view model =
    let
        letterCount = (List.length model.keystrokes)
    in
        if letterCount < 3 then
            jumbotron letterCount
        else
            graph model.keystrokes

jumbotron : Int -> Html Msg
jumbotron letterCount  =
    div [ Html.Attributes.class "jumbotron jumbotron-fluid" ]
        [ h1 [ Html.Attributes.class "text-center display-3" ] [ Html.text "Type something" ] ]

graph : List Int -> Svg Msg
graph letters =
    let
        circleData = circleDataPoints letters
    in
        svg [] (List.map letterCircle circleData)

circleDataPoints : List Int -> List(List Int)
circleDataPoints letters =
    partition letters 3

letterCircle : List Int -> Svg Msg
letterCircle circleData =
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
            ] []

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