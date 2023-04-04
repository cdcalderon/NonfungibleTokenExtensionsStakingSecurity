// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract EnumerableNFTCollection is ERC721Enumerable {
    constructor() ERC721("MyNFTCollection", "MNFT") {
        for (uint256 i = 1; i <= 20; i++) {
            _mint(msg.sender, i);
        }
    }
}
