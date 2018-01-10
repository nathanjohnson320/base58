module Base58 exposing (decode, encode)

{-| Handles encoding/decoding base58 data

# Transformations
@docs decode, encode
-}

import String
import Array exposing (Array)
import BigInt exposing (BigInt, fromInt)


alphabet : String
alphabet =
    "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"


alphabetArr : Array Char
alphabetArr =
    alphabet
        |> String.toList
        |> Array.fromList


{-| Decodes turns a string into its original BigInt
        "ANYBx47k26vP81XFbQXh6XKUj7ptQRJMLt"
            |> Base58.decode
        == BigInt.fromString "146192635802076751054841979942155177482410195601230638449945"
-}
decode : String -> BigInt
decode str =
    let
        alphabetLength =
            fromInt (String.length alphabet)

        len =
            fromInt (String.length str)

        strList =
            String.toList str

        ( _, decoded ) =
            List.foldr
                (\letter ( multi, dec ) ->
                    let
                        indexes =
                            String.indexes (String.fromChar letter) alphabet

                        index =
                            fromInt (Maybe.withDefault 0 (List.head indexes))

                        result =
                            BigInt.add dec (BigInt.mul multi index)

                        mul =
                            BigInt.mul multi alphabetLength
                    in
                        ( mul, result )
                )
                ( fromInt 1, fromInt 0 )
                strList
    in
        decoded

{-| Encode turns a big int into a string
        BigInt.fromString "146192635802076751054841979942155177482410195601230638449945"
            |> Base58.encode
        == "ANYBx47k26vP81XFbQXh6XKUj7ptQRJMLt"
-}
encode : BigInt -> String
encode num =
    let
        alphabetLength =
            fromInt (String.length alphabet)

        ( _, encoded ) =
            encodeReduce num alphabetLength ( "", fromInt 0 )
    in
        encoded


encodeReduce : BigInt -> BigInt -> ( String, BigInt ) -> ( BigInt, String )
encodeReduce num alphabetLength ( encoded, n ) =
    if BigInt.gte num alphabetLength then
        let
            dv =
                BigInt.div num alphabetLength

            md =
                (BigInt.sub num (BigInt.mul alphabetLength dv))

            index =
                Result.withDefault 0 (String.toInt (BigInt.toString md))

            i =
                String.fromChar (Maybe.withDefault '0' (Array.get index alphabetArr))

            newEncoded =
                i ++ encoded
        in
            encodeReduce dv alphabetLength ( newEncoded, dv )
    else
        let
            index =
                Result.withDefault 0 (String.toInt (BigInt.toString num))

            i =
                String.fromChar (Maybe.withDefault '0' (Array.get index alphabetArr))

            newEncoded =
                i ++ encoded
        in
            ( fromInt 0, newEncoded )
