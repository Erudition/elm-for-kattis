module Run exposing (..)

import Dict exposing (Dict)
import Posix.IO as IO exposing (IO, Process)
import Posix.IO.Process as Proc
import Posix.IO.File as File
import Json.Decode as Decode
import Array exposing (Array)


type alias StringInputSolver = String -> String

{-| Read raw String input, raw String output. Pass your `solve` function.
Note: node may crash if there is nothing passed to STDIN. If the problem involves no input, use `outString`.
-}
inStringOutString : Process -> StringInputSolver -> IO ()
inStringOutString process solve =
    IO.do (File.read File.stdIn) <| \content ->
    IO.do (Proc.print (solve content)) <| \_ ->
    IO.return ()

type alias StringOutputOnlySolver = String

{-| Raw String output only. Pass your `solve` function.
-}
outString : Process -> StringOutputOnlySolver -> IO ()
outString process solve =
    IO.do (Proc.print (solve)) <| \_ ->
    IO.return ()


type alias LinesInputOutputSolver = List String -> List String

{-| Read String input lines as a List String, give the same as output. Pass your `solve` function.
Note: node may crash if there is nothing passed to STDIN. If the problem involves no input, use `outLines`.
-}
linesInLinesOut : Process -> LinesInputOutputSolver -> IO ()
linesInLinesOut process solve =
    IO.do (File.read File.stdIn) <| \content ->
    IO.do (Proc.print (String.join "\n" (solve (String.lines (String.trim content))))) <| \_ ->
    IO.return ()

type alias LinesOutputSolver = List String

{-| Give output lines as a List String, no input. Pass your `solve` function.
-}
outLines : Process -> LinesOutputSolver -> IO ()
outLines process solve =
    IO.do (Proc.print (String.join "\n" solve)) <| \_ ->
    IO.return ()


type alias ArrayLinesInputOutputSolver = Array String -> Array String

{-| Read String input lines as an Array String, give the same as output. Pass your `solve` function.
Note: node may crash if there is nothing passed to STDIN. If the problem involves no input, use `outLines`.
-}
linesInLinesOutArray : Process -> ArrayLinesInputOutputSolver -> IO ()
linesInLinesOutArray process solve =
    IO.do (File.read File.stdIn) <| \content ->
    IO.do (Proc.print (String.join "\n" (Array.toList (solve (Array.fromList (String.lines content)))))) <| \_ ->
    IO.return ()