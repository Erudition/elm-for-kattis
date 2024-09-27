# elm-for-kattis
Allows you to write Elm programs to solve Kattis problems, with automatic tests!
I made this because Kattis doesn't have an option for Elm. I may be the only one using this, but I built it in a portal way in case other Elm users want to try their skills on Kattis. I hope they do!

Takes advantage of [the `elm-posix` project by `albertdahlin`](https://github.com/albertdahlin/elm-posix/tree/master) which is old but still works fine with Elm 0.19 code today.
Read the docs for elm-posix, but you don't need to use it much because a problem starter template gives you stdin and stdout already which is all that [Kattis problems require](https://support.kattis.com/support/solutions/articles/79000120852-how-do-i-handle-input-and-output-).
Also [uses `elm-test`](https://www.npmjs.com/package/elm-test) to automatically test your solution using the example inputs and outputs published by Kattis. Write additional tests if you like by learning from the [elm-test docs](https://www.npmjs.com/package/elm-test).

# How it works
We use Node to compile (and test!) your solution. You don't need to know Node.js either, just Elm. The few commands here will be all you need.
When you think you have the answer, run the test. If it succeeds, your answer may still be wrong, but at least it works on the example input.

When you're ready to submit, copy the contents of the solution file to the text editor on Kattis. Make sure the language is set to Javascript Node. Yes, really - you'll be pasting the whole compiled Elm code! 

Why? Since Kattis doesn't natively support Elm, this way we don't have to make Kattis compile the elm code. That may be possible by getting node to execute a child process that installs the elm package and runs it, but would be a fragile hack, and may take long enough that the server's solution timeout will be reached.

For simplicity, the whole repo is a single Elm project. If you want to `elm install` some dependencies, they'll be available to all Problems. Each Problem will be a single Elm file located in `Problems/`. Tests are located within the file itself.

# Setup
Fork and clone this repo. It's optimized for opening in VSCodium/VSCode.
You need `node` installed. I use `pnpm` as well, but classic `npm` should work too. [Kattis node v18.13.0](https://open.kattis.com/languages/javascript) at the time of this writing, but the differences between Node versions probably don't matter much for running compiled Elm, so feel free to start with whatever Node version you have. Then just setup the repo with `install` as usual. You can run this in the terminal within the project:
```sh
pnpm install
```

# Windows
If you're not using GNU/Linux or Mac, the npm scripts may not work unless you run within WSL. I attempted to use the shell-emulator feature to have the scripts work cross-platform, but it seems to be broken for now even though the scripts are simple and work fine in regular bash. To test it again, uncomment `#shell-emulator=true` in `.npmrc`.

# New Problem
Create a new problem with the `new` script by choosing a starter template.
Use proper elm module casing (capitalize words) for the problem name, which must be passed as the second argument.
Otherwise, the name should match what the problem is named on Kattis.

For simple String output, where no input is given by the problem:
```
pnpm new StringOut ProblemName
```
For simple String input and output:
```
pnpm new StringInStringOut ProblemName
```
For lines output, where your `solve` returns a `List String`:
```
pnpm new LinesOut ProblemName
```
For lines input and output:
```
pnpm new LinesInLinesOut ProblemName
```

All templates can be seen in `Starters/`.

# Build a Solver
To build `./Problems/HippHipp.elm`:
```
pnpm run make HippHipp
```
If there are no build errors, you'll see a new file in `Solutions/` with the `.solution` extension. This is a Node script (vanilla JS) that you can paste or upload to Kattis.

# Test a Solver
```
pnpm run solution HippHipp "optional stdin input here"
```
Directly runs `Solutions/HippHipp.solution` with node. The second argument will be passed to stdin.

# Patch for `elm-posix`
This package contains a `pnpm patch` for the script builder that make sure `stdin` is processed before elm does. Otherwise, your script will work fine locally when piping input from, say, a file, but fail on Kattis as if it got no input. Kattis [streams the lines in a weird way](https://stackoverflow.com/a/69559880) which makes the otherwise-fine stdin capture of `elm-posix` see nothing, since the input has already passed by before elm asks for it. Also, if there's no stdin, asking for it will crash node, so the patch contains a fix for that so we don't have to make you specify whether every problem has input.

# Run in debug mode
Your solutions are compiled in debug mode so that we can use `Debug.todo` for ignoring the impossible values of Kattis inputs, since Kattis guarantees that the input will be in the correct format. For example, if we're getting a list of Ints, it's annoying to have to deal with all the Maybes that come from e.g. `String.toInt` in your solution. Using the functions in the `Helpers` library, you can force a String to be an Int without falling back to some arbitrary value like `0` (which can be confusing when your output is wrong) or writing decoders (which are for untrusted input). Instead, your program will crash upfront if the input is not as expected, and work fine if it was.

The `make` script automatically removes the line that spits out the warning about compiling in debug mode, so as not to contaminate your answer.