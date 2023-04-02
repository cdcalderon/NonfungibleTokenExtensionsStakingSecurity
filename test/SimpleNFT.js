// SPDX-License-Identifier: MIT
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SimpleNFT", function () {
  let nft, owner, addr1;

  beforeEach(async function () {
    const NFT = await ethers.getContractFactory("SimpleNFT");
    [owner, addr1] = await ethers.getSigners();
    nft = await NFT.deploy();
    await nft.deployed();
  });

  describe("mint", function () {
    it("should mint an NFT to the caller", async function () {
      const tokenId = 1;
      await nft.mint(tokenId);
      expect(await nft.ownerOf(tokenId)).to.equal(
        await ethers.provider.getSigner().getAddress()
      );
    });

    it("should not allow minting of the same token ID twice", async function () {
      const tokenId = 1;
      await nft.mint(tokenId);
      await expect(nft.mint(tokenId)).to.be.revertedWith("already minted");
    });

    it("should not allow minting of token ID greater than 100", async function () {
      const tokenId = 101;
      await expect(nft.mint(tokenId)).to.be.revertedWith("_tokenId too large");
    });
  });

  describe("ownerOf", function () {
    it("should return the owner of a valid NFT", async function () {
      const tokenId = 1;
      await nft.mint(tokenId);
      expect(await nft.ownerOf(tokenId)).to.equal(
        await ethers.provider.getSigner().getAddress()
      );
    });

    it("should revert if NFT does not exist", async function () {
      const tokenId = 99;
      await expect(nft.ownerOf(tokenId)).to.be.revertedWith("no such token");
    });
  });

  describe("transferFrom", function () {
    it("should transfer ownership of a valid NFT", async function () {
      const tokenId = 1;
      await nft.mint(tokenId);
      await nft.transferFrom(owner.address, addr1.address, tokenId);
      expect(await nft.ownerOf(tokenId)).to.equal(addr1.address);
    });

    it("should revert if the token does not exist", async function () {
      const tokenId = 99;
      await expect(
        nft.transferFrom(owner.address, addr1.address, tokenId)
      ).to.be.revertedWith("token does not exist");
    });

    it("should revert if the sender is not the owner of the token", async function () {
      const tokenId = 1;
      await nft.mint(tokenId);
      await expect(
        nft.connect(addr1).transferFrom(owner.address, addr1.address, tokenId)
      ).to.be.revertedWith("require to be the owner");
    });

    it("should revert if _from is not the owner of the token", async function () {
      const tokenId = 1;
      await nft.mint(tokenId);
      await expect(
        nft.transferFrom(addr1.address, owner.address, tokenId)
      ).to.be.revertedWith("cannot transfer from");
    });
  });

  describe("tokenURI", function () {
    it("should return the correct token URI for a valid token ID", async function () {
      const tokenId = 1;
      await nft.mint(tokenId);
      const expectedTokenURI = "https://example.com/images/1.jpeg";
      expect(await nft.tokenURI(tokenId)).to.equal(expectedTokenURI);
    });

    it("should revert if the token ID does not exist", async function () {
      const tokenId = 99;
      await expect(nft.tokenURI(tokenId)).to.be.revertedWith("does not exist");
    });
  });
});
