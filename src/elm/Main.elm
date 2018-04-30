module Main exposing (..)

import Candy exposing (..)
import Color exposing (..)
import Html exposing (..)
import Time exposing (..)
import Time.DateTime as DT


type alias Model =
    Time


type Msg
    = Tick Time


model : Model
model =
    0


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Time.every second Tick ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            let
                s =
                    Debug.log "Second" (time |> DT.fromTimestamp |> DT.second)

                colors =
                    List.range 0 59
                        |> List.map
                            (\i ->
                                if s == i then
                                    Color.red
                                else
                                    Color.black
                            )
            in
            time ! [ updateFC colors ]


view : Model -> Html Msg
view model =
    div [] [ text "Stuff is happening in the console" ]
