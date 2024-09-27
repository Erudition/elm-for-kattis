module StringInStringOut exposing (program)
{-|
Solution for 
-}

import Run
import Posix.IO
import Posix.IO.Process


{-| This is the entry point, it will decode the inputs, run your `solve` function and print the output. Don't touch it.
-}
program : Posix.IO.Process -> Posix.IO.IO ()
program process =
    Run.inStringOutString process solve

{-| Put your solution here.
-}
solve : String -> String
solve input =
    "Got input: " + input
