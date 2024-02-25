// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */
    struct Buyer {
        uint256 deposit;
        uint256 timestamp;
        address buyer;
    }

    mapping(address => Buyer) public buyers;

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // find buyer
        Buyer memory buyer = buyers[msg.sender];
        if (buyer.buyer != address(0)) {
            buyer.deposit += msg.value;
            buyer.timestamp = block.timestamp;
        } else {
            buyer = Buyer(msg.value, block.timestamp, msg.sender);
        }
        // update buyer
        buyers[msg.sender] = buyer;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        require(msg.sender == seller, "only seller can withdraw");
        require(
            buyers[buyer].timestamp + 3 days < block.timestamp,
            "escrow has not ended"
        );
        payable(msg.sender).transfer(buyers[buyer].deposit);
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(buyers[msg.sender].buyer != address(0), "no escrow found");
        require(
            buyers[msg.sender].timestamp + 3 days > block.timestamp,
            "escrow has ended"
        );
        payable(msg.sender).transfer(buyers[msg.sender].deposit);
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return buyers[buyer].deposit;
    }
}
