module StringOut exposing (program)
{-|
Solution for 
-}

import Run
import Posix.IO
import Posix.IO.Process


{-| This is the entry point, it will run your `solve` function and print the output. Don't touch it.
-}
program : Posix.IO.Process -> Posix.IO.IO ()
program process =
    Run.outString process solve

{-| Put your solution here.
-}
solve : String
solve =
    "Got input: " + input
