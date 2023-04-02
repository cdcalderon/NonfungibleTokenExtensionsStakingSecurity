// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract OpenZeppelinNFT is ERC721 {
    constructor() ERC721("OpenZeppelinNFT", "OPZ") {}
}
