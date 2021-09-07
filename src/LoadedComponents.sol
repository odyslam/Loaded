//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;
import {toString} from "./MetadataUtils.sol";
import "ds-test/test.sol";
/// @title Loadout Components
/// @author Odysseas Lamtzidis
/// @notice Based
/// The created tokens are ERC1155 compatible, and their on-chain SVG is their name
contract LoadedComponents is DSTest{
    string[48] internal primaryWeapons= [
        "SIG MCX", //assault rifles, index = 0
        "M4A1",
        "FAMAS",
        "FAL",
        "SCAR",
        "VLK",
        "HK433",
        "TAR-21"
        "SIG SG 552",
        "GALIL",
        "AN-94",
        "AK-47",
        "M16A1,"
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
    // attributes of every weapon, scale of 10
    uint256[3][48] internal primaryWeaponLevels = [
    [5,7,6], // sig
    [6,7,7],
    [5,8,4],
    [6,8,4],
    [6,7,6],
    [5,7,7],
    [5,6,7], //hk433
    [4,8,7],
    [5,7,7],
    [6,7,6],
    [6,6,6],
    [7,4,7],
    [6,7,5],
    [4,7,6], //SMG - MP5
    [4,7,6],
    [5,7,5],
    [4,5,8],
    [3,3,8],
    [3,5,7],
    [4,7,6],
    [4,6,7],
    [6,4,7],
    [8,3,2], // SHOTGUN - 870MCS
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
    [8,5,3], // RIFLE
    [8,4,2],
    [7,5,4],
    [2,2,4],
    [8,5,4],
    [7,4,4],
    [7,4,4],
    [9,7,4], // SNIPER RIFLE
    [8,6,3],
    [8,6,3],
    [8,6,3],
    [8,6,2]
    ];
   uint256[3][13] internal secondaryWeaponLevels = [
    [2,4,4], // PISTOL
    [2,3,3],
    [3,3,2],
    [3,2,3],
    [2,3,3],
    [2,3,3],
    [10,1,1], // LAUNCHER
    [10,3,1],
    [10,2,1],
    [10,3,1],
    [1,2,0], //MELEE
    [0,0,0],
    [1,1,0]
   ];

    string[] internal levelBars = [
        unicode" ",
        unicode"█",
        unicode"██",
        unicode"███",
        unicode"████",
        unicode"█████",
        unicode"██████"
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

    function random(string memory input)
    internal
    view
    returns (uint256)
    {
    return uint256(keccak256(abi.encodePacked(input)));
    }

    function getPrimaryWeapon(uint256 tokenId)
        internal
        view
        returns (uint256 )
    {
        return pluck(tokenId, "PRIMARY WEAPON" , 48);
    }
    function getSecondaryWeapon(uint256 tokenId)
        internal
        view
        returns (uint256 )
    {
            return pluck(tokenId, "SECONDARY WEAPON", 13);
    }
    function getEquipment(uint256 tokenId)
        internal
        view
        returns (uint256[3] memory)
    {
            return ([pluck(tokenId, "EQUIPMENT ONE", 15), pluck(tokenId, "EQUIPMENT TWO", 15), pluck(tokenId, "EQUIPMENT THREE", 15)]);
    }
    function getPerks(uint256 tokenId)
        internal
        view
        returns (uint256[3] memory)
    {
            return ([pluck(tokenId, "PERK ONE", 25), pluck(tokenId, "PERK TWO", 25) , pluck(tokenId, "PERK THREE", 25)]);
    }

    function pluck(
        uint256 tokenId,
        string memory keyPrefix,
        uint256 sourceArrayLength
    )
    internal
   view
    returns (uint256 ) {
        uint256 component;
        uint256 rand = random(
        string(abi.encodePacked(keyPrefix, toString(tokenId)))
        );
        component = rand % sourceArrayLength;
        return component;
    }
}
