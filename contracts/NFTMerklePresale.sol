// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract NFTMerklePresale is ERC721URIStorage, Ownable {
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public nextTokenId = 0;
    uint256 public presalePrice;
    bytes32 public merkleRoot;

    mapping(address => bool) public claimedPresale;

    constructor(
        bytes32 _merkleRoot,
        uint256 _presalePrice
    ) ERC721("MerklePresaleNFT", "MPNFT") {
        merkleRoot = _merkleRoot;
        presalePrice = _presalePrice;
    }
}
