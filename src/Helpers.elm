module Helpers exposing (..)

import Dict exposing (Dict)
import Posix.IO as IO exposing (IO, Process)
import Posix.IO.Process as Proc
import Posix.IO.File as File
import Json.Decode as Decode
import Array exposing (Array)

intFromString : String -> Int
intFromString integerString =
    case String.toInt integerString of
        Just integer ->
            integer
        
        Nothing ->
            Debug.todo ("String '" ++ integerString ++ "' could not be forced to an Int")

floatFromString : String -> Float
floatFromString floatString =
    case String.toFloat floatString of
        Just float ->
            float
        
        Nothing ->
            Debug.todo ("String '" ++ floatString ++ "' could not be forced to a Float")
