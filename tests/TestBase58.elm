module TestBase58 exposing (..)

import Expect exposing (Expectation)
-- import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Base58
import BigInt exposing (fromInt)


suite : Test
suite =
    describe "Base58"
        [ describe "Base58.decode"
            [ test "encode base 58"
                <| \_ ->
                    (fromInt 74)
                        |> Base58.encode
                        |> Expect.equal "2H"
            , test "decodes base 58"
                <| \_ ->
                    let
                        networkVersion =
                            0x17

                        decoded =
                            "ANYBx47k26vP81XFbQXh6XKUj7ptQRJMLt"
                                |> Base58.decode

                        encoded =
                                decoded
                                |> Base58.encode

                        testRes =
                            Expect.equal encoded "ANYBx47k26vP81XFbQXh6XKUj7ptQRJMLt"
                    in
                        testRes
              --   -- fuzz runs the test 100 times with randomly-generated inputs!
              -- , fuzz string "restores the original string if you run it again"
              --     <| \randomlyGeneratedString ->
              --         randomlyGeneratedString
              --             |> String.reverse
              --             |> String.reverse
              --             |> Expect.equal randomlyGeneratedString
            ]
        ]
