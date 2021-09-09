//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./utils/LoadedTest.sol";

contract BasicTest is LoadedTest {
    function testCommander() public {
        uint256 load = 9999;
        loaded.commanderLocknload(load);
        assertEq(loaded.ownerOf(load), deployer);
        assertEq(loaded.owner(), deployer);
    }

///@dev  We have set the block.timestamp to a timestamp that satisfies the require.
///      This is done by adding an env variable to  .env that we source just before we call dapp test
    function testDatedCorrectDate() public {
        LoadedUser bob;
        bob = new LoadedUser(loaded);
        bob.locknloadWave2(7000);
        assertEq(loaded.ownerOf(7000), address(bob));
    }
///@dev This is a test that in oreder to pass, the code have to revert . We catch the error via try, catch statement.
    function testDatedWrongDate() public {
        hevm.warp(1631208546);
        LoadedUser bob;
        bob = new LoadedUser(loaded);
        try bob.locknloadWave2(7000) { fail(); }
        catch Error(string memory error) {
            assertEq(error,"ETA is unknown");
        }
}


    function testWrongLock() public {
        uint256 load = 9999;
        try alice.locknload(load) { fail(); }
        catch Error(string memory error) {
            assertEq(error, "Ser, Loaded has been already locked or you entered an invalid ID");
        }
    }

    function testWrongLockCommander() public {
        uint256 load = 9999;
        try alice.commanderLocknload(load) { fail(); }
        catch Error(string memory error) {
            assertEq(error, "Ownable: caller is not the owner");
        }
    }

///@dev We have set the address to which the contract is deployed to the hardcoded address that we want to test.
    function testMinister() public {
        emit log_address(msg.sender);
        loaded.ministerOfDefenseLocknload(9000);
        assertEq(msg.sender, loaded.ownerOf(9000));
    }
}
