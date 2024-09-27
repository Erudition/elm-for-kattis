module LinesInLinesOut exposing (program)
{-|
Solution for 
-}

import Run
import Posix.IO
import Posix.IO.Process
import List.Extra as List


{-| This is the entry point, it will decode the inputs, run your `solve` function and print the output. Don't touch it.
-}
program : Posix.IO.Process -> Posix.IO.IO ()
program process =
    Run.linesInLinesOut process solve

{-| Put your solution here.
-}
solve : List String -> List String
solve input =
    ["Got input: "] ++ input
