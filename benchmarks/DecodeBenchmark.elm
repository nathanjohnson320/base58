module DecodeBenchmark exposing (main, benchmark)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Base58


main : BenchmarkProgram
main =
    program benchmark


benchmark : Benchmark
benchmark =
    describe "decode"
        [ benchmark1 "an IPFS hash" Base58.decode "Qmd4STeBJPJyDw9KhaDYfFd91W2cDkW6CFkzEF8gveVfXg"
        ]
