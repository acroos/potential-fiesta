module Views.DownloadPrompt exposing (downloadPrompt)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Models exposing (DownloadConfig)
import Msgs exposing (Msg)

downloadPrompt : DownloadConfig -> Html Msg
downloadPrompt config = 
    div 
        [ class "modal fade"
        , id "downloadModal"
        , attribute "tabIndex" "-1"
        , attribute "role" "dialog"
        , attribute "aria-labelledby" "downloadModalLabel"
        , attribute "aria-hidden" "true"
        ]
        [ div
            [ class "modal-dialog", attribute "role" "dialog" ]
            [ div [ class "modal-content" ]
                [ modalHeader
                , modalBody config
                , modalFooter
                ]
            ]
        ]

modalHeader : Html Msg
modalHeader =
    div [ class "modal-header" ]
        [ h5 [ class "modal-title", id "downloadModalLabel" ]
            [ text "Download" ]
        ]

modalBody : DownloadConfig -> Html Msg
modalBody config =
    div [ class "modal-body" ]
        [ widthRange config.width (config.fileType /= "svg")
        , heightRange config.height (config.fileType /= "svg")
        , fileTypeSelector config.fileType
        ]

widthRange : Float -> Bool -> Html Msg
widthRange width enabled =
    let
        inputChange = 
            \s -> Msgs.UpdateDownloadConfigWidth (Result.withDefault width (String.toFloat s))

        labelColor =
            if enabled then
                "#000000"
            else
                "#888888"
    in
        div [ class "form-group" ]
            [ label [ for "rangeW", style [ ("color", labelColor) ] ] [ text "Image width: "]
            , input
                [ type_ "range"
                , class "form-control-range"
                , id "rangeW"
                , attribute "min" "192"
                , attribute "max" "5760"
                , attribute "step" "1"
                , onInput inputChange
                , onChange inputChange
                , value (toString width)
                , disabled (not enabled)
                ] []
            , label [ for "rangeW", style [ ("color", labelColor) ] ] [ text ((toString width) ++ "px") ]
            ]

heightRange : Float -> Bool -> Html Msg
heightRange height enabled =
    let
        inputChange = 
            \s -> Msgs.UpdateDownloadConfigHeight (Result.withDefault height (String.toFloat s))
        
        labelColor =
            if enabled then
                "#000000"
            else
                "#888888"
    in
        div [ class "form-group" ]
            [ label [ for "rangeH", style [ ("color", labelColor) ] ] [ text "Image height: "]
            , input 
                [ type_ "range"
                , class "form-control-range"
                , id "rangeH"
                , attribute "min" "120"
                , attribute "max" "3600"
                , attribute "step" "1"
                , onInput inputChange
                , onChange inputChange
                , value (toString height)
                , disabled (not enabled)
                ] []
            , label [ for "rangeH", style [ ("color", labelColor) ] ] [ text ((toString height) ++ "px") ]
            ]

fileTypeSelector : String -> Html Msg
fileTypeSelector fileType =
    div [ class "form-group" ]
        [ label [ for "fileTypeRadios" ] [ text "File type: " ]
        , div [ id "fileTypeRadios" ] 
            [ div [ class "form-check form-check-inline" ]
                [ input 
                    [ class "form-check-input"
                    , type_ "radio"
                    , name "fileTypeRadios"
                    , id "radioPng"
                    , value "png"
                    , checked (fileType == "png")
                    , onClick (Msgs.UpdateDownloadConfigFileType "png")
                    ] []
                , label [ class "form-check-label", for "radioPng" ] [ text "png" ]
                ]
            , div [ class "form-check form-check-inline" ]
                [ input 
                    [ class "form-check-input"
                    , type_ "radio"
                    , name "fileTypeRadios"
                    , id "radioSvg"
                    , value "svg"
                    , checked (fileType == "svg")
                    , onClick (Msgs.UpdateDownloadConfigFileType "svg")
                    ] []
                , label [ class "form-check-label", for "radioSvg" ] [ text "svg" ]
                ]
            ]
        , small [ style [ ("color", "#666666") ] ] [ text "If svg is selected, sizes will be ignored" ]
        ]

modalFooter : Html Msg
modalFooter =
    div [ class "modal-footer" ]
        [ button 
            [ type_ "button"
            , class "btn btn-secondary"
            , attribute "data-dismiss" "modal"
            ]
            [ text "Cancel" ]
        , button 
            [ type_ "button"
            , class "btn btn-primary"
            , attribute "data-dismiss" "modal"
            , onClick Msgs.DownloadImage
            ]
            [ text "OK" ]
        ]

onInput : (String -> msg) -> Attribute msg
onInput tagger =
    on "input" (Json.Decode.map tagger targetValue)

onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)