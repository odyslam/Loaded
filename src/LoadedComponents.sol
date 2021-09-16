//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;
import {toString} from "./MetadataUtils.sol";

/// @title Loadout Components
/// @author Odysseas Lamtzidis
/// @notice Helper contract that stores all the available Loadout weapons and perks.
/// It's also responsible for generating the Loadout kit for every ID. The generated tokens are ERC721 compatible.

contract LoadedComponents {

/// An array of all available weapons, organized by category.
    string[48] internal primaryWeapons= [
        "SIG MCX", //assault rifles, index = 0
        "M4A1",
        "FAMAS",
        "FAL",
        "SCAR",
        "VLK",
        "HK433",
        "TAR-21",
        "SIG SG 552",
        "GALIL",
        "AN-94",
        "AK-47",
        "M16A1,",
        "MP5", //smgs, index = 13
        "MP7",
        "AUG",
        "P90",
        "PP19 BISON",
        "UZI",
        "UMP-45",
        "APC9",
        "AK-74U",
        "870 MCS", // shotguns , index = 22
        "DP12",
        "ORIGIN 12",
        "B725",
        "ORIGIN 12",
        "VLK",
        "AA-12",
        "M249", // light machine guns, index = 29
        "PK",
        "MG 24",
        "SA80",
        "G36",
        "M249 SAW",
        "STONER 96",
        "MK 14", //rifles, index = 36
        "KAR98",
        "MK12 CARBINE",
        "CROSSBOW",
        "SKS",
        "M24",
        "HK G28",
       "BARRETT M82 .50", // sniper rifles, index = 43
        "AX50",
        "DRAGUNOV",
        "M40 RIFLE",
        "L96A1"
    ];
    /// attributes of every weapon, scale of 0 to 10. Attributes are as follows:
    /// [DAMAGE, ACCURACY, RATE OF FIRE]
    uint256[3][48] internal primaryWeaponLevels = [
    [5,7,6], // assault rifles
    [6,7,7],
    [5,8,4],
    [6,8,4],
    [6,7,6],
    [5,7,7],
    [5,6,7],
    [4,8,7],
    [5,7,7],
    [6,7,6],
    [6,6,6],
    [7,4,7],
    [6,7,5],
    [4,7,6], // smgs
    [4,7,6],
    [5,7,5],
    [4,5,8],
    [3,3,8],
    [3,5,7],
    [4,7,6],
    [4,6,7],
    [6,4,7],
    [8,3,2], // shotguns
    [7,4,3],
    [7,4,5],
    [7,3,2],
    [7,4,4],
    [7,4,5],
    [8,7,5],
    [7,5,5],
    [7,6,5],
    [6,7,7],
    [8,7,6],
    [7,6,5],
    [8,5,3], // rifles
    [8,4,2],
    [7,5,4],
    [2,2,4],
    [8,5,4],
    [7,4,4],
    [7,4,4],
    [9,7,4], // sniper rifles
    [8,6,3],
    [8,6,3],
    [8,6,3],
    [8,6,2]
    ];
    // Stats for secondary weapons. Scale 0 to 10.
    // [DAMAGE, ACCURACY, RATE OF FIRE]
   uint256[3][13] internal secondaryWeaponLevels = [
    [2,4,4], // pistols
    [2,3,3],
    [3,3,2],
    [3,2,3],
    [2,3,3],
    [2,3,3],
    [10,1,1], // launchers
    [10,3,1],
    [10,2,1],
    [10,3,1],
    [1,2,0], // melee
    [0,0,0],
    [1,1,0]
   ];

   // unicode characters that are used to create the visual effect of a stats bar
    string[] internal levelBars = [
        unicode" ",
        unicode"█",
        unicode"██",
        unicode"███",
        unicode"████",
        unicode"█████",
        unicode"██████",
        unicode"███████",
        unicode"████████",
        unicode"█████████",
        unicode"██████████"
    ];

    string[] internal secondaryWeapons = [
        "GLOCK 18", // pistols, index = 0
        "M1911",
        ".357 MAGNUM",
        "DESERT EAGLE .50",
        "M17",
        "BERETTA M9",
        "RPG-7", // launchers, index =  6
        "M72 LAW",
        "FGM-148",
        "9K32 STRELA-2",
        "COMBAT KNIFE", //melee, index = 10
        "RIOT SHIELD",
        "KARAMBIT"

    ];

// Equipment is both grenades and tactical equipment
    string[] internal equipment = [
        "CLAYMORE",
        "FRAG GRENADE",
        "C4",
        "SEMTEX",
        "THROWING KNIFE",
        "THROWING AXE",
        "PROXIMITY MINE",
        "THERMITE",
        "FLASH GRENADE",
        "STUN GRENADE",
        "SMOKE GRENADE",
        "HEARTBEAT SENSOR",
        "GAS GRENADE",
        "DECOY GRENADE",
        "TEAR GAS"
    ];

// Perks are loosely defined. Some are skill-based and other role-based. Use your imagination.
    string[] internal perks = [
        "SCAVENGER",
        "GHOST",
        "MEDIC",
        "HARDLINE",
        "OVERKILL",
        "HIGH ALERT",
        "RECON",
        "AMPED",
        "STEADY AIM",
        "TRACKER",
        "SUPPORT",
        "GUNNER",
        "SCOUT",
        "TECHNICIAN",
        "QUICK DRAW",
        "MARKSMAN",
        "DEAD SILENCE",
        "TOUGHNESS",
        "HARD WIRED",
        "RECOVER",
        "LAST STAND",
        "UAV JAMMER",
        "IRON LUNGS",
        "SUPPLIER",
        "ASSASSIN"
    ];
// For every Loaded kit, there is a unique seed that is used to generate the metadata. It's stored in this array.
    uint256[10001] internal loadedSeeds;

// @notice saveSeed generates a seed when a particular Loaded kit is claimed. The seed is stored and used to generate the metadata.
// Seed generation algorithm is inspired by the Hymns project: https://etherscan.io/address/0x83f1d1396b19fed8fbb31ed189579d07362d661d
// @dev Seed is generated based on the time and the block when the function was invoked. It's saved so that metadata for a particular ID stays constant.
    function saveSeed(uint256 loadedId)
        internal
        {
          uint256 seed = uint256(
             keccak256(
                   abi.encodePacked(
                       block.timestamp +
                       block.difficulty +
                       (
                               (uint256(keccak256(abi.encodePacked(block.coinbase))) / (block.timestamp))
                               + block.gaslimit +
                           (
                               (uint256(keccak256(abi.encodePacked(msg.sender)))) /
                               (block.timestamp + block.number)
                            )
                       )

                    )
               )
           );
           loadedSeeds[loadedId] = seed;
        }

//Turns a string into a uint. Not random.
    function random(string memory input)
        internal
        pure
        returns (uint256)
        {
            return uint256(keccak256(abi.encodePacked(input)));
        }
//@notice getPrimaryWeapon returns an index to  pick primary weapon from the primaryWeapon array
    function getPrimaryWeapon(uint256 tokenId)
        internal
        view
        returns (uint256 )
    {
        return pluck(tokenId, "PRIMARY WEAPON" , 48);
    }

///@notice getSecondaryWeapon returns three uints to be used as indexes  to pick items from the secondaryWeapon array
    function getSecondaryWeapon(uint256 tokenId)
        internal
        view
        returns (uint256 )
    {
            return pluck(tokenId, "SECONDARY WEAPON", 13);
    }
///@notice getEquipment returns three uints to be used as indexes  to pick items from the equipment array
    function getEquipment(uint256 tokenId)
        internal
        view
        returns (uint256[3] memory)
    {
            return ([pluck(tokenId, "EQUIPMENT ONE", 15), pluck(tokenId, "EQUIPMENT TWO", 15), pluck(tokenId, "EQUIPMENT THREE", 15)]);
    }
///@notice getPerks returns three uints to be used as indexes to pick items from the perks array
    function getPerks(uint256 tokenId)
        internal
        view
        returns (uint256[3] memory)
    {
            return ([pluck(tokenId, "PERK ONE", 25), pluck(tokenId, "PERK TWO", 25) , pluck(tokenId, "PERK THREE", 25)]);
    }

// @notice pluck is used to choose an item for every category and id
// @param loadID the ID for the ERC721 token
// @param keyPrefix a string to differentiate the output betwen items in different categories for the same ERC721 token ID
// @param sourceArrayLength The length of the category from which the item will be chosen.  The modulo % operator ensures that no out-of-boundaries index will be returned
// @dev the returned value is used as an index for the items category to pick a particular item.
// The function will always output the same component for the same arguments. It's deterministic.
    function pluck(
        uint256 loadId,
        string memory keyPrefix,
        uint256 sourceArrayLength
        )
        internal
        view
        returns (uint256 )
    {
        uint256 seed = loadedSeeds[loadId];
        require(seed != 0, "Invalid ID: Load has not been locked");
        uint256 rand = random(keyPrefix);
        uint256 component = (rand % (seed % 10000)) % sourceArrayLength;
        return component;
    }
}
