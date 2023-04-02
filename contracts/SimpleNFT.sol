// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SimpleNFT {
    mapping(uint256 => address) private _owners;

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
        require(msg.sender == _from, "require to be the owner");

        _owners[_tokenId] = _to;
    }
}
