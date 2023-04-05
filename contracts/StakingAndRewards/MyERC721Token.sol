// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyERC721Token is ERC721 {
    uint256 private tokenIdCounter;

    constructor() ERC721("MyERC721Token", "MNFT") {}

    function mintNFT(address to) external {
        _safeMint(to, tokenIdCounter);
        tokenIdCounter++;
    }
}
