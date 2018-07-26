module ElmMusicRecognitionModule exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (int, string, list, decodeString, Decoder)
import Task exposing (Task, andThen)

data : String
data =
    """
    [
      {
      "track id_number": 2,
      "Artist": "Anthony Naples",
      "Title": "Refugio"
      }
    ]
  """

type alias TrackID =
  { artist : String
  , title : String
}

trackIDDecoder : Decoder TrackID
trackIDDecoder =
  decode
    TrackID
    |> required "Artist" string
    |> required "Title" string

main : Html msg
main =
  let
    source =
      decodeString (list trackIDDecoder) data



main =
    program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }



-- MODEL


type alias Model =
    { showRecords : Bool
    , showArchive : Bool
    , hideArchive : Bool
    , showTrackList : Bool
    , hideTrackList : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model False False True False True, Cmd.none )



-- UPDATE


type Msg
    = ShowRecords
    | ShowArchive
    | HideArchive
    | ShowTrackList
    | HideTrackList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowRecords ->
            ( { model | showRecords = True }, Cmd.none )

        ShowArchive ->
            ( { model | showArchive = True }, Cmd.none )

        HideArchive ->
            ( { model | showArchive = False }, Cmd.none )

        ShowTrackList ->
            ( { model | showTrackList = True }, Cmd.none )

        HideTrackList ->
            ( { model | showTrackList = False }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [] [ text "Ame Music" ]
        , button [ onClick ShowRecords, class "mainButton" ]
            [ text "Upload File" ]
        , button [ onClick ShowArchive, class "mainButton" ]
            [ text "Show Recent Tracks" ]
        , if model.showRecords then
            div []
                [ h1 [] []
                , input [ type_ "file", placeholder "Upload your file", class "uploadButton" ] []
                , button [ onClick ShowTrackList, class "confirmUploadButton" ] [ text "upload" ]
                ]
          else
            text ""
        , if model.showArchive then
            div [ class "trackList" ]
                [ h2 [ class "tracklistHeading" ] [ text "Recent Tracks" ]
                , ul [ class "tracklistList" ]
                    [ li [ class "tracklistItem" ] [ text "Tracklist 1" ]
                    , li [ class "tracklistItem" ] [ text "Tracklist 2" ]
                    , li [ class "tracklistItem" ] [ text "Tracklist 3" ]
                    , button [ onClick HideArchive, class "closeButton" ]
                        [ text "close" ]
                    ]
                ]
          else
            text ""
        , if model.hideArchive then
            text ""
          else
            text "something went wrong"
        , if model.showTrackList then
            div [ class "trackList" ]
                [ h2 [ class "tracklistHeading" ] [ text "Tracklist" ]
                , ul [ class "tracklistList" ]
                    [ li [ class "tracklistItem" ] [ text "Albert Ayler, Ghosts" ]
                    , li [ class "tracklistItem" ] [ text "Anthony Naples, Refugio" ]
                    , li [ class "tracklistItem" ] [ text "0 Flynn, Tyrion" ]
                    , button [ onClick HideTrackList, class "closeButton" ]
                        [ text "close" ]
                    ]
                ]
          else
            text ""
        , if model.hideTrackList then
            text ""
          else
            text "something went wrong"

        , div [ id "cassette", class "mixtape" ]
            [ div [ class "tag" ]
                  [ div [ class "title" ] []
                  , div [ class "player" ]
                        [ div [ class "play" ]
                              [ div [ class "roll-1" ]
                                    [ div [ class "teeth" ] []
                                    ]
                              , div [ class "roll-2" ]
                                    [ div [ class "teeth" ] []
                                    ]
                              ]
                              , div [ class "b-txt" ]
                                    [ div [ class "slog-text" ]
                                          [ h1 [] [ text "Eliteware" ]
                                          ]
                                    , div [ class "text-right" ]
                                          [ h1 [] [ text "F190" ]
                                          , h2 [] [ text "F190" ]
                                          ]
                                    ]
                        ]
                ]
                , div [ class "bot-det" ] []
                , div [ class "screws" ]
                      [ div [ class "scr-1" ] []
                      , div [ class "scr-2" ] []
                      , div [ class "scr-3" ] []
                      , div [ class "scr-4" ] []
                      ]
          ]
        ]
