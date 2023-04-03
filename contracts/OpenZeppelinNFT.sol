// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OpenZeppelinNFT is ERC721, Ownable {
    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 5;
    address immutable deployer;

    constructor() ERC721("OpenZeppelinNFT", "OPZ") {
        deployer = msg.sender;
    }

    function mint() external {
        require(tokenSupply < MAX_SUPPLY, "supply used up");
        _mint(msg.sender, tokenSupply);
        tokenSupply++;
    }

    function withdraw() external {
        payable(deployer).transfer(address(this).balance);
    }

    // this can be removed if Ownable is removed and relay on deployer property
    function renounceOwnership() public pure override {
        require(false, "cannot renounce");
    }

    // this can be removed if Ownable is removed and relay on deployer property
    function transferOwnership(address /* newOwner */) public pure override {
        require(false, "cannot renounce");
    }
}
