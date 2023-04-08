// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract NFTWithBitmapMerkleTreePresaleV3 is
    ERC721Enumerable,
    Ownable2Step,
    ReentrancyGuard,
    IERC2981
{
    using BitMaps for BitMaps.BitMap;

    bytes32 public merkleRoot;
    BitMaps.BitMap private _claimedBitMap;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant PRESALE_DISCOUNT = 500; // Discount in percentage (1000 = 100%)
    address public royaltyRecipient;
    uint256 public constant ROYALTY_RATE = 25; // 2.5% royalty rate (1000 = 100%)
    uint256 public constant ORIGINAL_PRICE = 1 ether;

    constructor(
        bytes32 merkleRoot_,
        address royaltyRecipient_
    ) ERC721("NFTWithBitmapMerkleTreePresale", "NFTBM") {
        merkleRoot = merkleRoot_;
        royaltyRecipient = royaltyRecipient_;
    }

    function mint(uint256 tokenId) external onlyOwner {
        require(tokenId < MAX_SUPPLY, "Invalid tokenId");
        _safeMint(_msgSender(), tokenId);
    }

    function presale(
        uint256 claimId,
        bytes32[] calldata merkleProof
    ) external payable nonReentrant {
        uint256 tokenId = totalSupply();
        require(tokenId < MAX_SUPPLY, "Presale has ended");
        require(!_claimedBitMap.get(claimId), "Presale already claimed");

        // Verify the Merkle proof
        bytes32 leaf = keccak256(abi.encodePacked(_msgSender(), claimId));
        require(
            MerkleProof.verify(merkleProof, merkleRoot, leaf),
            "Invalid Merkle proof"
        );

        // Calculate discounted price and check payment
        uint256 price = (ORIGINAL_PRICE * (1000 - PRESALE_DISCOUNT)) / 1000;
        require(msg.value >= price, "Invalid payment amount");

        // Mark the presale as claimed
        _claimedBitMap.set(claimId);

        _safeMint(_msgSender(), tokenId);
    }

    function royaltyInfo(
        uint256,
        uint256 salePrice
    ) external view override returns (address, uint256) {
        uint256 royaltyAmount = (salePrice * ROYALTY_RATE) / 1000;
        return (royaltyRecipient, royaltyAmount);
    }
}
