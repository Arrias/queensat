# queensat 
[![Haskell CI](https://github.com/SmnTin/simple-type-checker/actions/workflows/haskell.yml/badge.svg)](https://github.com/Arrias/queensat/actions)

Program solve generalized [Eight queens puzzle](https://ru.wikipedia.org/wiki/%D0%97%D0%B0%D0%B4%D0%B0%D1%87%D0%B0_%D0%BE_%D0%B2%D0%BE%D1%81%D1%8C%D0%BC%D0%B8_%D1%84%D0%B5%D1%80%D0%B7%D1%8F%D1%85) with the help of [Picosat](https://github.com/sdiehl/haskell-picosat).

## Usage
Run the following commands to build a project
```terminal 
$ stack update
$ stack build
```
Then run program with exactly one argument n. For example
```terminal
$ stack run 8
.......Q
.Q......
....Q...
..Q.....
Q.......
......Q.
...Q....
.....Q..
```
To run unit tests you can 
```
$ stack test 
```