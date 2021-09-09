//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./utils/LoadedTest.sol";

contract MetadataTest is LoadedTest {
    function testMetadata() public {
        string memory meta = loaded.tokenURI(LOAD);
        emit log(meta);
    }
}
