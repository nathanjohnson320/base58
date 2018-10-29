module EncodeBenchmark exposing (main)

import Base58
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import BigInt


main : BenchmarkProgram
main =
    program <| describe "base58" [ encode, decode ]


encode : Benchmark
encode =
    describe "encode"
        [ benchmark "a BigInt" (\_ -> Base58.encode <| BigInt.fromInt 98765432123567890)
        ]


decode : Benchmark
decode =
    describe "decode"
        [ benchmark "an IPFS hash" (\_ -> Base58.decode "Qmd4STeBJPJyDw9KhaDYfFd91W2cDkW6CFkzEF8gveVfXg")
        ]
