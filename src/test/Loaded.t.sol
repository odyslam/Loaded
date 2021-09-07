//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./utils/LoadedTest.sol";

contract BasicTest is LoadedTest {
    function testOwner() public {
        uint256 load = 7999;
        loaded.commanderLocknload(load);
        assertEq(loaded.ownerOf(load), deployer);
        assertEq(loaded.owner(), deployer);
    }
    function testWrongLock() public {
        uint256 load =  7800;
        alice.locknload(load);
}
}
