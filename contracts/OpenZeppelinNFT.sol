// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract OpenZeppelinNFT is ERC721 {
    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 5;

    constructor() ERC721("OpenZeppelinNFT", "OPZ") {}

    function mint() external {
        require(tokenSupply < MAX_SUPPLY, "supply used up");
        _mint(msg.sender, tokenSupply);
        tokenSupply++;
    }
}
