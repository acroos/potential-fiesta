module Views.Index exposing (indexView)

import Html exposing (Html)
import Models exposing (Model)
import Msgs exposing (Msg)
import Views.Graph exposing (graphView)
import Views.Intro exposing (introView)

indexView : Model -> Html Msg
indexView model =
    if (List.length model.keystrokes) < 3 then
        introView
    else
        graphView model.keystrokes