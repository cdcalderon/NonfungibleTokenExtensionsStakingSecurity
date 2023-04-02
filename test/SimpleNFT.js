// SPDX-License-Identifier: MIT
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SimpleNFT", function () {
  let nft;

  beforeEach(async function () {
    const NFT = await ethers.getContractFactory("SimpleNFT");
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
});
