//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./utils/LoadedTest.sol";

contract MetadataTest is LoadedTest {
    function testMetadata() public {
        emit log_uint(block.gaslimit);
        emit log_uint(block.timestamp);
        emit log_uint(block.difficulty);
        emit log_address(block.coinbase);string memory meta = loaded.tokenURI(LOAD);
        fail();
    }
}
