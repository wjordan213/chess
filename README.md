# Chess

## Description
A command line interface for the game of chess. the board renders nicely on the command line thanks to the colorize gem and the game enforces move order, move validity, and ends the game on checkmate.

## How to use:
- download the repo
- after navigating to the directory within the command line, type "ruby game.rb"
- after each move prompt, write the starting square (i.e. e2) followed by a space, followed by the ending square (i.e. e4)
- when you decide to finish playing, press control + c to exit out of the game

## Technologies
Ruby, colorize

## Notable implementation details
- This game was written with Object Oriented approach, utilizing class inheritance to keep the code DRY
  - The Class hierarchy for pieces went Piece > Stepping or Sliding Piece > Individual Piece
