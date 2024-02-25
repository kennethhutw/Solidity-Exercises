// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Typecast {
    /**
     * the goal of this exercise is to pass if msg.value is equal to the address of this contract or revert otherwise
     */

    function typeCast() external payable {
        bytes32 addressBytes = bytes32(msg.value);

        address addr = address(this);
        bytes32 addressBytes2 = bytes32(addr);
        require(
            addressBytes == addressBytes2,
            "msg.value is not equal to address(this).balance"
        );
    }
}
