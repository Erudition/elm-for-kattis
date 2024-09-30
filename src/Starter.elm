module Starter exposing (program)
{-|
Solution for 
-}

import List.Extra
import Helpers exposing (..)


{-| This is the entry point, it will decode the inputs, run your `solve` function and print the output. Don't touch it.
-}
program process =
    linesInLinesOut process solve

{-| Put your solution here.
-}
solve : List String -> List String
solve input =
    ["Got input: "] ++ input
