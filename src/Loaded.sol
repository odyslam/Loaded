//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

// ============ Imports ============

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "./LoadedMetadata.sol";

/// @title Loadout
/// @author Odysseas Lamtzidis
/// @notice Allows "opening" your ERC721 Loot bags and extracting the items inside it
/// The created tokens are ERC1155 compatible, and their on-chain SVG is their name
contract Loaded is ERC721, LoadedMetadata, Ownable, ReentrancyGuard{
    // The OG Loot bags contract
    // No need for a URI since we're doing everything onchain
    constructor() ERC721("Loadout", "LOADOUT") Ownable() {}

    function locknload(uint256 tokenId) public nonReentrant {
        require(tokenId > 0 && tokenId < 9643, "Ser, Loaded has been already locked or you entered an invalid ID");
        _safeMint(_msgSender(), tokenId);
    }

    function commanderLocknload(uint256 tokenId) public nonReentrant onlyOwner {
        require(tokenId > 9642 && tokenId < 10001, "Ser, Loaded has been already locked or you are not the commander");
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
