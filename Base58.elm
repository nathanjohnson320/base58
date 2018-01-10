module Base58 exposing (decode, encode)

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


encode : BigInt -> String
encode num =
    let
        alphabetLength =
            fromInt (String.length alphabet)

        ( _, encoded ) =
            encodeReduce num alphabetLength ( "", fromInt 0 )
    in
        encoded



-- while ($num >= $base_count) {
--     $div = $num / $base_count;
--     $mod = ($num - ($base_count * intval($div)));
--     $encoded = $alphabet[$mod] . $encoded;
--     $num = intval($div);
-- }


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

