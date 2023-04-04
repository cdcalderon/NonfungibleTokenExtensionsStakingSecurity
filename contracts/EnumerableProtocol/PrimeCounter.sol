// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

contract PrimeCounter {
    function countPrimeTokens(
        address nftAddress,
        address userAddress
    ) public view returns (uint256) {
        IERC721Enumerable nftContract = IERC721Enumerable(nftAddress);
        uint256 numTokens = nftContract.balanceOf(userAddress);
        uint256 primeCount = 0;

        for (uint256 i = 0; i < numTokens; i++) {
            uint256 tokenId = nftContract.tokenOfOwnerByIndex(userAddress, i);
        }

        return primeCount;
    }
}
