// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private _tokenCounter;
    mapping(address => uint256) private _owners;

    event NftMinted(address indexed owner, uint256 indexed tokenId);

    constructor() ERC721("Poncho", "PONCHO") {}

    function mintNft() public returns (uint256) {
        uint256 tokenId = _tokenCounter;

        _safeMint(msg.sender, tokenId);
        _tokenCounter = tokenId + 1;

        emit NftMinted(msg.sender, tokenId);

        return tokenId;
    }

    function getTokenIdForOwner(address owner) public view returns (uint256) {
        return _owners[owner];
    }

    function getTokenCounter() public view returns (uint256) {
        return _tokenCounter;
    }
}
