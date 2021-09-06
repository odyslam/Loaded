//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

// ============ Imports ============

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "./LoadoutMetadata.sol";

/// @title Loadout
/// @author Odysseas Lamtzidis
/// @notice Allows "opening" your ERC721 Loot bags and extracting the items inside it
/// The created tokens are ERC1155 compatible, and their on-chain SVG is their name
contract Loadout is ERC721, LoadoutMetadata, Ownable, ReentrancyGuard{
    // The OG Loot bags contract
    // No need for a URI since we're doing everything onchain
    constructor() ERC721("Loadout", "LOADOUT") Ownable() {}

    function claim(uint256 tokenId) public nonReentrant {
        require(tokenId > 0 && tokenId < 7778, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }

    function ownerClaim(uint256 tokenId) public nonReentrant onlyOwner {
        require(tokenId > 7777 && tokenId < 8001, "Token ID invalid");
        _safeMint(owner(), tokenId);
}
    function tokenURI(uint256 tokenId) override public view returns (string memory)
        {
            string memory output = buildSVG(tokenId);
            string memory json = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{ "name": "', string(abi.encodePacked(tokenName, toString(tokenId))),'", ',
                            '"description" : ', '"Loaded is randomized gear for soldiers, generated and stored on chain.',
                            '"image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '", '
                            '}'
                        )
                    )
                )
            );
            output = string(
                abi.encodePacked("data:application/json;base64,", json)
            );
        return output;
        }
}
