// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";

import "src/WillFactory.sol";

contract WillTest is Test {
    WillFactory public willFactory;

    address internal owner;
    address internal guardian;

    function setUp() public {
        owner = address(0xB0B);
        guardian = address(0xA11ce);

        willFactory = new WillFactory();
        
        //top up the owner account with ETH
        owner.call{value: 90 ether}("");

        willFactory.setPrice(0.01 ether);
    }

    function test_ownerBuildWill() public {
        vm.prank(owner);

        address(willFactory).call{value: 0.01 ether}(abi.encode(address(owner)));
        willFactory.buildWill(address(owner), address(guardian), 60);

    }
}
