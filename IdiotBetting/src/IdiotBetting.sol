// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */
    uint256 public lastDeposit;
    address public winner;
    uint256 totalDeposit;
    uint256 public highestDeposit;

    constructor() {}

    function bet() public payable {
        uint256 deltaTime = block.timestamp - lastDeposit;
        require(deltaTime < 1 hours, "betting period has ended");
        totalDeposit += msg.value;
        lastDeposit = block.timestamp;
        if (msg.value > highestDeposit) {
            winner = msg.sender;
            highestDeposit = msg.value;
        }
    }

    function claimPrize() public {
        require(winner == msg.sender, "only winner can claim prize");
        (bool sent, ) = msg.sender.call{value: totalDeposit}("");
        require(sent, "Failed to send Ether");
    }
}
