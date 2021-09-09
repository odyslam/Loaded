// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;


import "ds-test/test.sol";
import "./Hevm.sol";
import { Loaded } from "../../Loaded.sol";

import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

// NB: Using callbacks is hard, since we're a smart contract account we need
// to be implementing the callbacks
contract LoadedUser is ERC721Holder {
    Loaded loaded;

    constructor(Loaded _loaded) {
        loaded = _loaded;
    }

    function locknload(uint256 tokenId) public {
        loaded.locknload(tokenId);
    }
    function locknloadWave2(uint256 tokenId) public {
        loaded.locknloadWave2(tokenId);
   }
   function ministerOfDefenseLocknload(uint256 tokenId) public {
       loaded.ministerOfDefenseLocknload(tokenId);
   }
   function commanderLocknload(uint256 tokenId) public {
       loaded.commanderLocknload(tokenId);
   }
}

contract LoadedTest is DSTest, ERC721Holder  {
    uint256 internal constant LOAD = 100;
    address internal deployer = address(this);
    Hevm internal constant hevm =
        Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    Loaded internal loaded;

    // users
    LoadedUser internal alice;

    function setUp() public virtual {
        // deploy contracts
        loaded = new Loaded();
        emit log_named_address("Deployer Address", deployer);
        alice = new LoadedUser(loaded);
        alice.locknload(LOAD);
        assertEq(loaded.ownerOf(LOAD), address(alice));
    }
}

