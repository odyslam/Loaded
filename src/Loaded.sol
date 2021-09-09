//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

// ============ Imports ============

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "./LoadedMetadata.sol";

/// @title Loadout
/// @author Odysseas Lamtzidis
/// @notice A loot-inspired NFT project in the era of modern combat. Every Loudout is pseudo-randomly generated.
/// @notice We add a se
/// @dev Project structure is based on lootloose by Georgios Konstantopoulos: https://github.com/gakonst/lootloose

contract Loaded is ERC721, LoadedMetadata, Ownable, ReentrancyGuard{

    constructor() ERC721("Loaded", "LOADED") Ownable() {}
/// @notice Claims a new load that is not claimed and it's ID is between the boundaries.
/// It's the first wave of claimable Loads. The ID is passed to a pseudo-random generator to create and store the seed.
    function locknload(uint256 loadId) public nonReentrant {
        require(loadId > 0 && loadId < 4242, "Ser, Loaded has been already locked or you entered an invalid ID");
        saveSeed(loadId);
        _safeMint(_msgSender(), loadId);
    }
/// @notice Claims a new load that has not been claimed. The function can be ran only after a certain timestamp,
/// giving the chance to everyone to participate.
    function locknloadWave2(uint256 loadId) public nonReentrant {
        require(loadId > 4243 && loadId < 8888, "Ser, Loaded has been already locked or you entered an invalid ID");
        require(block.timestamp > 1631976975, "ETA is unknown");
        saveSeed(loadId);
        _safeMint(_msgSender(), loadId);
    }
/// @notice Same claim unction as before, reserved for the creators of the project.
    function commanderLocknload(uint256 loadId) public nonReentrant onlyOwner {
        require(loadId > 9222 && loadId < 10001, "Ser, Loaded has been already locked or you are not the commander");
        saveSeed(loadId);
        _safeMint(owner(), loadId);
    }
/// @notice Same claim function as before, reserved for the creators of the project.
    function ministerOfDefenseLocknload(uint256 loadId) public nonReentrant {
        require(loadId >  8887 && loadId < 9223 && msg.sender == address(0x4783CaA6645B566465978b5d19Cd55329AE6e964), "Ser, Loaded has been already locked or you are not the Minister");
        saveSeed(loadId);
        _safeMint(msg.sender, loadId);
    }
/// @notice It returns the Base64 encoded json according to the ERC721 spec. The svg image is generated inside the contract.
    function tokenURI(uint256 loadId) override public view returns (string memory)
        {
            string memory output = buildSVG(loadId);
            string memory json = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{ "name": "', string(abi.encodePacked(tokenName, toString(loadId))),'", ',
                            '"description" : ', '"Loaded is randomized gear for soldiers, generated and stored on chain. The weapon stats are open and available on chain.",',
                            '"image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"'
                            '}'
                        )
                    )
                )
            );
            output = string(abi.encodePacked("data:application/json;base64,", json)
            );
        return output;
        }
}
