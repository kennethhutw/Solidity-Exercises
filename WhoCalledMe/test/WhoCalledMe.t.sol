// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WhoCalledMe.sol";

contract SumArrayTest is Test {
    WhoCalledMe public whoCalledMe;

    function setUp() public {
        address[] memory owners = new address[](3);
        owners[0] = address(0x1);
        owners[1] = address(0x2);
        owners[2] = address(0x3);
        whoCalledMe = new WhoCalledMe(owners, 2);
    }

    function testConstructor() public {
        address[] memory nOwners = whoCalledMe.getOwners();
        assertEq(nOwners.length, 3, "nOwners should be equal to 3");

        address firstOwner = nOwners[0];
        assertEq(firstOwner, address(0x1), "firstOwner should be equal to 0x1");

        uint numberTransactions = whoCalledMe.getTransactionCount();
        assertEq(
            numberTransactions,
            0,
            "numberTransactions should be equal to 0"
        );
    }

    function testSendEthToContract() public payable {
        uint256 amount = 1e18;
        address caller = address(0x4);

        vm.deal(caller, amount);
        vm.prank(caller);
        (bool sent, bytes memory data) = address(whoCalledMe).call{
            value: amount
        }("");
        assertTrue(sent, "failed to send eth to contract");

        uint256 balance = address(whoCalledMe).balance;
        assertEq(balance, amount, "balance should be equal to amount");
    }
}
