module Problems.HelloWorld exposing (program)
{-|
Solution for https://open.kattis.com/problems/hello
-}

import Run
import Posix.IO
import Posix.IO.Process


{-| This is the entry point, it will decode the inputs, run your `solve` function, encode the output, and print the output. For problems with:
  - No input, String output: change `program` body to `Run.outString process solve`
  - String input, String output: change body to `Run.inStringOutString process solve`
-}
program : Posix.IO.Process -> Posix.IO.IO ()
program process =
    Run.outString process solve


solve : String
solve =
    "Hello World!"
