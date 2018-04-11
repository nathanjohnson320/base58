module EncodeBenchmark exposing (main, benchmark)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import BigInt
import Base58


main : BenchmarkProgram
main =
    program benchmark


benchmark : Benchmark
benchmark =
    describe "encode"
        [ benchmark1 "a BigInt" Base58.encode (BigInt.fromInt 98765432123567890)
        ]
