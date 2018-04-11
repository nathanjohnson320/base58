module TestBase58 exposing (..)

import Expect exposing (Expectation)


-- import Fuzz exposing (Fuzzer, int, list, string)

import Test exposing (..)
import Base58
import BigInt


decodeTests : Test
decodeTests =
    describe "decode"
        [ test "decode \"1\" == 0" <|
            \_ ->
                Base58.decode "1"
                    |> Result.map BigInt.toString
                    |> Expect.equal (Ok "0")
        , test "decode \"z\" == 57" <|
            \_ ->
                Base58.decode "z"
                    |> Result.map BigInt.toString
                    |> Expect.equal (Ok "57")
        , test "very large base58" <|
            \_ ->
                Base58.decode "Qmd4STeBJPJyDw9KhaDYfFd91W2cDkW6CFkzEF8gveVfXg"
                    |> Result.map BigInt.toString
                    |> Expect.equal (Ok "537374223645606396327404992513981989153791146196994939352589708590914230509284699")
        , test "invalid char" <|
            \_ ->
                Base58.decode " "
                    |> Result.map BigInt.toString
                    |> Expect.err
        , test "invalid char in back" <|
            \_ ->
                Base58.decode " a"
                    |> Result.map BigInt.toString
                    |> Expect.err
        , test "invalid char in front" <|
            \_ ->
                Base58.decode "a "
                    |> Result.map BigInt.toString
                    |> Expect.err
        , test "invalid char in middle" <|
            \_ ->
                Base58.decode "1 2"
                    |> Result.map BigInt.toString
                    |> Expect.err
        , test "invalid keyboard smashing" <|
            \_ ->
                Base58.decode "jna$#@Tgsk923@#$adflakj ;d[][]"
                    |> Result.map BigInt.toString
                    |> Expect.err
        ]


encodeTests : Test
encodeTests =
    describe "encode"
        [ test "zero" <|
            \_ ->
                BigInt.fromInt 0
                    |> Base58.encode
                    |> Expect.equal "1"
        , test "seventy four" <|
            \_ ->
                BigInt.fromInt 74
                    |> Base58.encode
                    |> Expect.equal "2H"
        ]
