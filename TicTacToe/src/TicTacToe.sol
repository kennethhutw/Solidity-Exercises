// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's && 0's elements && it is also a 3x3 nested array.
    */

    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        uint8 mark = 1;
        return ((board[0][0] == mark &&
            board[0][1] == mark &&
            board[0][2] == mark) ||
            (board[1][0] == mark &&
                board[1][1] == mark &&
                board[1][2] == mark) ||
            (board[2][0] == mark &&
                board[2][1] == mark &&
                board[2][2] == mark) ||
            (board[0][0] == mark &&
                board[1][0] == mark &&
                board[2][0] == mark) ||
            (board[0][1] == mark &&
                board[1][1] == mark &&
                board[2][1] == mark) ||
            (board[0][2] == mark &&
                board[1][2] == mark &&
                board[2][2] == mark) ||
            (board[0][0] == mark &&
                board[1][1] == mark &&
                board[2][2] == mark) ||
            (board[0][2] == mark &&
                board[1][1] == mark &&
                board[2][0] == mark));
    }
}
