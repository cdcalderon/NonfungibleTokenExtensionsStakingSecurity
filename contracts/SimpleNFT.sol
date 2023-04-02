// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";

contract SimpleNFT {
    /* Type declarations */
    using Strings for uint256;

    mapping(uint256 => address) private _owners;
    //mapping(msg.sender => mapping(addressToApprove-opensea => bool))
    mapping(address => mapping(address => bool)) private _operators;
    string baseURL = "https://example.com/images/";

    function mint(uint256 _tokenId) external {
        require(_owners[_tokenId] == address(0), "already minted");
        require(_tokenId < 100, "_tokenId too large");
        _owners[_tokenId] = msg.sender;
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        require(_owners[_tokenId] != address(0), "no such token");
        return _owners[_tokenId];
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable {
        require(_owners[_tokenId] != address(0), "token does not exist");
        require(_owners[_tokenId] == _from, "cannot transfer from"); // check that _from is the owner of token
        //_operators[_from][msg.sender]  check that .msg.sender is approved for the from address
        require(
            msg.sender == _from || _operators[_from][msg.sender],
            "require to be the owner"
        );
        _operators[_from][msg.sender] = false;
        _owners[_tokenId] = _to;
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        require(_owners[_tokenId] != address(0), "does not exist");
        return string(abi.encodePacked(baseURL, _tokenId.toString(), ".jpeg"));
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        _operators[msg.sender][_operator] = _approved;
    }

    function isApprovedForAll(
        address _owner,
        address _operator
    ) external view returns (bool) {
        return _operators[_owner][_operator];
    }
}
