// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract DistributeV2 {
    event Log(address[] addresses, uint256 amount, uint256 length);

    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
        3. Consider scenarios where one of the recipients rejects the ether transfer, 
           have a work around for that whereby other recipients still get their transfer
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        uint256 currentBalance = address(this).balance;
        uint256 amount = currentBalance / addresses.length;
        for (uint256 i = 0; i < addresses.length; i++) {
            (bool sent, bytes memory data) = payable(addresses[i]).call{
                value: amount
            }("");
            if (sent) {
                emit Log(addresses, amount, addresses.length);
            }
        }
    }
}
