// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Car {
    string public model;
    address public owner;

    constructor(string memory _model) {
        model = _model;
        owner = msg.sender;
    }
}

contract Deployer {
    /*
        This exercise assumes you know how to deploy a contract.
        1. Create an empty contract.
        2. Deploy the contract and return the address in `deployContract` function.
    */
    Car[] public cars;

    constructor() {
        Car car = new Car("Tesla");
        cars.push(car);
    }

    function deployContract() public view returns (address) {
        Car car = cars[0];
        return address(car);
    }
}
