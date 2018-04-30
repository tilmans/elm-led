port module Candy exposing (updateFC)

import Color exposing (..)
import Color.Manipulate exposing (..)


port send : List Int -> Cmd msg


brightness : Float
brightness =
    0.3


updateFC : List Color -> Cmd msg
updateFC colors =
    let
        shifted =
            List.drop 30 colors ++ List.take 30 colors

        _ =
            Debug.log "colors" (List.length shifted)
    in
    send
        ([ 0, 0, 0, 0 ]
            ++ List.foldl
                (\c l ->
                    let
                        { red, green, blue, alpha } =
                            c |> Color.Manipulate.darken brightness |> Color.toRgb
                    in
                    l ++ [ red, green, blue ]
                )
                []
                shifted
        )
