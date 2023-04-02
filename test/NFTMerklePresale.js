const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTMerklePresale", function () {
  let NFTMerklePresale, nftMerklePresale, owner, addr1, addr2, addrs;

  beforeEach(async function () {
    NFTMerklePresale = await ethers.getContractFactory("NFTMerklePresale");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    nftMerklePresale = await NFTMerklePresale.deploy(
      "0x1234567890123456789012345678901234567890123456789012345678901234",
      100
    );
    await nftMerklePresale.deployed();
  });

  describe("Deployment", function () {
    it("Should set the correct merkle root and presale price", async function () {
      const merkleRoot = await nftMerklePresale.merkleRoot();
      expect(merkleRoot).to.equal(
        "0x1234567890123456789012345678901234567890123456789012345678901234"
      );

      const presalePrice = await nftMerklePresale.presalePrice();
      expect(presalePrice).to.equal(100);
    });

    it("Should have the correct name and symbol", async function () {
      const name = await nftMerklePresale.name();
      expect(name).to.equal("MerklePresaleNFT");

      const symbol = await nftMerklePresale.symbol();
      expect(symbol).to.equal("MPNFT");
    });

    it("Should set the correct owner", async function () {
      const contractOwner = await nftMerklePresale.owner();
      expect(contractOwner).to.equal(owner.address);
    });
  });
});
