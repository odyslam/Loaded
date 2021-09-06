pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Codloot.sol";

contract CodlootTest is DSTest {
    Codloot loot;

    function setUp() public {
        loot = new Codloot();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
