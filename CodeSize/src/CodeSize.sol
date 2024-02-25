// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CodeSize {
    /**
     * The challenge is to create a contract whose runtime code (bytecode) size is greater than 1kb but less than 4kb
     */
    address public owner;
    string public name = "AVCBCXDDDDDDDD00000002223ss";
    string public name2 = "AVCBCXDDDDDDDD0000000dsadsads";
    mapping(address => uint256) public balances;
    mapping(address => uint256) public balances2;
    mapping(address => uint256) public balances3;
    uint152 public balance;
    uint256 public balance2;
    string public balance3;

    function isGreaterThan1kb() external returns (bool) {
        require(
            msg.sender == owner,
            "Only the owner of this contract can call this function dsa dsds dsds $$$$$$$$$$$ "
        );
        owner = msg.sender;
        return owner == msg.sender;
    }
}
