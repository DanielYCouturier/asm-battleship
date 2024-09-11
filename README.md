# Battleship (ASM)
[Download EXE](https://github.com/DanielCouturier/asm-battleship/blob/main/Project.exe)

The requirements for ths project were to create a simple game in MASM (Microsoft Assembly).

I chose to recreate the classic two-player board game BattleShip. Normally, each player places 5 ships of different lengths on the board (a coordinate grid), obscured from their opponent. Then each player takes turns guessing coordinates. If a player guesses a coordinate which overlaps with part of their opponents ship, the opponent must declare a "Hit". When a player hits every segment of their opponent's ship, the opponent must declare their ship has been "Sunk". A player wins when they sink all 5 of their opponents ships. 

In my implementation, I chose to allow one human player, who plays against an AI, since a two player game on a single device can be confusing for the user. At the start of the game, the user chooses the difficulty for the AI between 1 and 100, which represents the probability the AI guesses correctly each turn. Towards the end of the game the AI might be forced to guess correctly if there are no remaining incorrect guesses to make. 

This project was originally submitted as a final project for CSE 3120 (Computer Architecture and Assembly) (2024).
All submissions participated in a peer-evaluated competition. This project placed 5th out of 15.

Written in MASM, compiled with Visual Studio 2015 (v140), Targeted for Windows SDK 8.1 
Dependent Library: [Irvine32](https://www.asmirvine.com/gettingStartedVS2015/)

![image](https://github.com/user-attachments/assets/a25c398a-9479-4186-b254-e8d7fb17ae29)

![image](https://github.com/user-attachments/assets/b84ff5f6-cb40-4376-bd3f-f929cfdf66be)

# Basic Design
* z_main.asm - controls main menu  loop
* z_game.asm - controls main gameplay loop
* InitializeAllyBoard.asm - controls the UI for the first part of the game (selecting where to place user ships)
* InitializeEnemyBoard.asm - code to randomly place all enemy ships
* Guess.asm - controls the UI for the second part of the game (when the user tries to guess AI ship placement)
* RandomGuess.asm - code for the AI to guess randomly
* BoardWins.asm - called upon any user or AI guess to see if the game should end
* PrintBoard.asm & PrintCursor.asm - handles all draw calls to the console
* Remaining asm files are miscellaneous util functions that would be trivial in higher level languages and dont need much explanation
