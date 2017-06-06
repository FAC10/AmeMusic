module BeginningElm exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html exposing (beginnerProgram)
import Html.Events exposing (..)

model =
   { showRecords = False }

type Msg =
    ShowRecords | HideRecords

update msg model_ =
    case msg of
        ShowRecords -> { model_ | showRecords = True }
        HideRecords -> { model_ | showRecords = False }

view model_ =
    div [ class "container" ]
        [ h1 [] [ text "Ame Music" ]
        , button [ onClick ShowRecords]
            [ text "Show Records" ]
        , button [onClick HideRecords]
            [ text "Hide Records" ]
        , if model_.showRecords then
            text "list of records here"
            else
               text ""
        ]


main =
    beginnerProgram
       { model = model
       , update = update
       , view = view
       }
