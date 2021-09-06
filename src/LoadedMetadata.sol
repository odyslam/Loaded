//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "./LoadedComponents.sol";
import {Base64, toString} from "./MetadataUtils.sol";

/// @title Helper contract for generating metadata information about Loadouts. Heavily inspired by lootloose smart contract by Georgios Konstantopoulos.
/// @author Odysseas Lamtzidis
/// @dev Inherit from this contract and use it to generate metadata for your Loadout
contract LoadedMetadata is LoadedComponents{
    string tokenName = unicode"Loaded - ︻デ═一 #";
    function buildSVG(uint256 tokenId) internal view returns (string memory) {
        string[] memory parts = new string[](34);
        uint256 index = getPrimaryWeapon(tokenId);
        uint256[3] memory primaryWeaponStats = primaryWeaponLevels[index];
        parts[26] =  primaryWeapons[index];
        index = getSecondaryWeapon(tokenId);
        parts[5] = secondaryWeapons[index];
        uint256[3] memory  secondaryWeaponStats = secondaryWeaponLevels[index];
        uint256[3] memory indexes = getEquipment(tokenId);
        parts[13] = equipment[indexes[0]];
        parts[14] = '</tspan><tspan x="40" y="360">';
        parts[15] = equipment[indexes[1]];
        parts[16] = '</tspan><tspan x="40" y="390">';
        parts[17] = equipment[indexes[2]];
        indexes = getPerks(tokenId);
        parts[0] = '<svg fill="#FFFFFF" font-family="HelveticaNeue-CondensedBold" font-style="condensed" font-weight="bold" width="500px" height="500px" viewBox="0 0 500 500" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">';
        // parts[1] is empty
        parts[2] = '<rect fill="#000000" x="0" y="0" width="500" height="500"></rect><text font-size="24" x="167.144" y="123">';
        parts[3] = string(abi.encodePacked(tokenName, toString(tokenId)));
        parts[4] = '</text><text font-size="20" x="270" y="197">';
        //parts[5]
        parts[6] = '</text><text font-size="10"  line-spacing="20" letter-spacing="0.416666667" x="270" y="221">DAMAGE<tspan x="326" y="221"';
        parts[7] = levelBars[secondaryWeaponStats[0]];
        parts[8] = '</tspan><tspan x="426" y="221" ></tspan><tspan x="270" y="241">ACCURACY</tspan><tspan x="316.703333" y="241" ></tspan><tspan x="326" y="241" >';
        parts[9] = levelBars[secondaryWeaponStats[1]];
        parts[10] = '</tspan><tspan x="426" y="241"></tspan><tspan x="270" y="261">FIRE RATE</tspan><tspan x="326" y="261" >';
        parts[11] = levelBars[secondaryWeaponStats[2]];
        parts[12] = '</tspan></text><text font-size="20" line-spacing="30" <tspan x="40" y="330">';
        // parts[13]
        // parts[14]
        // parts[15]
        // parts[16]
        // parts[17]
        parts[18] = '</tspan></text><text font-size="20" line-spacing="30"><tspan x="270" y="330">';
        parts[19] = perks[indexes[0]];
        parts[20] = '</tspan><tspan x="270" y="360">';
        parts[21] = perks[indexes[1]];
        parts[22] = '</tspan><tspan x="270" y="390">';
        parts[23] = perks[indexes[2]];
        parts[24] = '</tspan></text><text font-size="20" x="40" y="197">';
        // parts[26]
        parts[27] = '</text><text font-size="10" line-spacing="20" letter-spacing="0.416666667"<tspan x="40" y="221">DAMAGE</tspan><tspan x="96" y="221">';
        parts[28] = levelBars[primaryWeaponStats[0]];
        parts[29] = '</tspan><tspan x="40" y="241">ACCURACY</tspan><tspan x="86.7033333" y="241"</tspan><tspan x="96" y="241">';
        parts[30] = levelBars[primaryWeaponStats[1]];
        parts[31] = '</tspan><tspan x="40" y="261">FIRE RATE<n:/tspan><tspan x="96" y="261" >';
        parts[32] = levelBars[primaryWeaponStats[2]];
        parts[33] = '</tspan></text></svg>';
        bytes memory output5 = abi.encodePacked(abi.encodePacked(parts[0], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7] ,parts[8], parts[9], parts[10]),
                                                abi.encodePacked(parts[11], parts[12], parts[13], parts[14], parts[15], parts[16], parts[17], parts[18], parts[19]),
                                                abi.encodePacked(parts[20], parts[21], parts[22], parts[23], parts[24], parts[25], parts[26]),
                                                abi.encodePacked(parts[27], parts[28], parts[29], parts[30], parts[31], parts[32], parts[33]));
        return string(output5);
    }
 }

