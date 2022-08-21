// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "forge-std/console.sol";

import "./Will.sol";

contract WillFactory {

    error PriceNotPaid();

    event NewWill(address, address, uint256, address);

    uint256 public price;
    address public admin;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only Admin!");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function setPrice(uint256 _price) external onlyAdmin {
        price = _price;
    }

    function getPrice() public view returns (uint256) {
        return price;
    }

    function withdrawFunds() external onlyAdmin {
        (bool sent, ) = admin.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether to admin");
    }

    function buildWill(address owner, address guardian, uint256 expiration) public payable {
        if (msg.value != price) {
            revert PriceNotPaid();
        }
        Will w = new Will(owner, guardian, expiration);
        console.log("Will contract:", address(w));
        emit NewWill(owner, guardian, expiration, address(w));
    }
}