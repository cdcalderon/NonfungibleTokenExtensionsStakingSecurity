// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./MyERC20Token.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTStaking is IERC721Receiver, ReentrancyGuard {
    MyERC20Token public erc20Token;
    IERC721 public erc721Token;
    uint256 public constant REWARD_AMOUNT = 10 * (10 ** 18); // considering 18 decimals
    uint256 public constant REWARD_INTERVAL = 24 hours;

    struct StakeInfo {
        uint256 tokenId;
        uint256 lastClaimed;
    }

    mapping(address => StakeInfo) public stakers;

    constructor(address _erc20Token, address _erc721Token) {
        erc20Token = MyERC20Token(_erc20Token);
        erc721Token = IERC721(_erc721Token);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        require(msg.sender == address(erc721Token), "Invalid token");

        stakers[from] = StakeInfo(tokenId, block.timestamp);

        return this.onERC721Received.selector;
    }

    function claimRewards() external nonReentrant {
        StakeInfo storage stake = stakers[msg.sender];
        require(
            stake.lastClaimed + REWARD_INTERVAL <= block.timestamp,
            "Claim interval not met"
        );

        stake.lastClaimed = block.timestamp;
        erc20Token.transfer(msg.sender, REWARD_AMOUNT);
    }

    function unstake() external nonReentrant {
        StakeInfo storage stake = stakers[msg.sender];
        require(stake.tokenId != 0, "Not staked");

        uint256 tokenId = stake.tokenId;
        delete stakers[msg.sender];

        erc721Token.safeTransferFrom(address(this), msg.sender, tokenId);
    }

    function mintERC20(uint256 amount) external {
        erc20Token.mint(msg.sender, amount);
    }
}
