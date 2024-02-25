// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */
    mapping(address => uint256) public users;
    mapping(address => uint256) public lastDeposit;

    function balanceOf(address user) public view returns (uint256) {
        return users[user];
    }

    function depositEther() external payable {
        users[msg.sender] += msg.value;
        lastDeposit[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        uint256 userDeposited = users[msg.sender];
        uint256 userLastDeposit = lastDeposit[msg.sender];
        require(userDeposited >= amount, "Not enough deposited");
        require(
            block.timestamp - userLastDeposit >= 1 weeks,
            "Not enough time passed"
        );
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
