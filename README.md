# elm-for-kattis
Allows you to write Elm programs to solve Kattis problems,test them, and submit the code to be scored on the platform!
I made this because Kattis doesn't have an option for Elm. I may be the only one using this, but I built it in a portable way in case other Elm users want to try their skills on Kattis. I hope they do!

Takes advantage of [the `elm-posix` project by `albertdahlin`](https://github.com/albertdahlin/elm-posix/tree/master) which is old but still works fine with Elm 0.19 code today. You won't need to read the docs for elm-posix, because this repo gives you a problem starter template that gives you stdin and stdout already which is all that [Kattis problems require](https://support.kattis.com/support/solutions/articles/79000120852-how-do-i-handle-input-and-output-).

Basically, just do what Elm does best -- write a pure function that takes some input and produces correct output! Also allows you to test your code against the example input and output provided by Kattis.

# How it works
We use Node to compile your solution. You don't need to know Node.js though, just Elm. The few commands here will be all you need.
When you think you have the answer, run the test. If it succeeds, your answer may still be wrong, but at least it works on the example input.

When you're ready to submit, make sure the Kattis editor's language is set to Javascript Node, then copy the contents of the solution file into and submit. Yes, really - you'll be pasting the whole huge mess of raw compiled Elm code!   

Why? This way we don't have to make Kattis compile the elm code itself, which would require getting their server to install Elm. (That may be possible by getting node to execute a child process that installs the elm package and runs it, but would be a fragile hack, and may take long enough that the server's solution timeout will be reached.)

For simplicity, the whole repo is a single Elm project. If you `elm install` some dependencies, they'll be available to all `Problem`s. Each `Problem` will be a single Elm file located in `Problems/`. Tests are located within `Tests` and the compiled solutions are `js` files in `Solutions/`.

# Testing
Originally the plan was to use elm-test to support inline tests written for each problem, but it turned out to be overkill, and writing formal tests is not conducive to the pace of competitive programming. Instead, each `Problem` you generate with `pnpm new ProblemName` will have two corresponding text files generated, `Solution/ProblemName.input` and `Solution/ProblemName.output`. Simply paste one of the example input-output pairs given into these files and `pnpm test ProblemName` will compare your solution's output with the example output using `diff`.

While this doesn't support multiple tests per problem, for problems with single-line inputs and outputs you can simply write your `solve` functions to map over all lines of the input, then put multiple examples in the test file on separate lines.

# Setup
Fork and clone this repo. It's optimized for opening in VSCodium/VSCode.
You need `node` installed, and `pnpm` as well. You can try using classic `npm` instead, but this project makes use of the wonderful `pnpm patch` feature to patch an issue in `elm-posix`. [Kattis uses node v18.13.0](https://open.kattis.com/languages/javascript) at the time of this writing, but the differences between Node versions probably don't matter much for running compiled Elm, so feel free to try it with whatever Node version you have. Then just setup the repo with `install` as usual. You can run this in the terminal within the project:
```sh
pnpm install
```

# Windows
If you're not using GNU/Linux or Mac, the npm scripts may not work unless you run within WSL. I attempted to use the shell-emulator feature to have the scripts work cross-platform, but it seems to be broken for now even though the scripts are simple and work fine in regular bash.

# New Problem
Create a new problem with the `new` script, which copies the starter template.
Use proper elm module casing (capitalize words) for the problem name, which must be passed as the second argument.
Otherwise, the name should match what the problem is named on Kattis.

```
pnpm new ProblemName
```

# Build a Solver
To build `./Problems/HippHipp.elm`:
```
pnpm make HippHipp
```
If there are no build errors, you'll see a new file in `Solutions/` with the `.solution` extension. This is a Node script (vanilla JS) that you can paste or upload to Kattis.

# Test a Solver
```
pnpm test HippHipp
```
Directly runs `Solutions/HippHipp.js` with node. The `Test/HippHipp.input` will be fed in, and diffed with `Test/HippHipp.output`.
If there are no differences, you may be ready to paste your solution js file into Kattis!

# Patch for `elm-posix`
This package contains a `pnpm patch` for the script builder that make sure `stdin` is processed before elm does. Otherwise, your script will work fine locally when piping input from, say, a file, but fail on Kattis as if it got no input. Kattis [streams the lines in a weird way](https://stackoverflow.com/a/69559880) which makes the otherwise-fine stdin capture of `elm-posix` see nothing, since the input has already passed by before elm asks for it. Also, if there's no stdin, asking for it will crash node, so the patch contains a fix for that so we don't have to make you specify whether every problem has input.

# Run in debug mode
Your solutions are compiled in debug mode so that we can use `Debug.todo` for ignoring the impossible values of Kattis inputs, since Kattis guarantees that the input will be in the correct format. For example, if we're getting a list of Ints, it's annoying to have to deal with all the Maybes that come from e.g. `String.toInt` in your solution. Using the functions in the `Helpers` library, you can force a String to be an Int without falling back to some arbitrary value like `0` (which can be confusing when your output is wrong) or writing decoders (which are for untrusted input). Instead, your program will crash upfront if the input is not as expected, and work fine if it was.

The `make` script automatically removes the line that spits out the warning about compiling in debug mode, so as not to contaminate your answer.