const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BasicNft", function () {
  let BasicNft, basicNft, owner, addr1, addr2, addrs;

  beforeEach(async function () {
    BasicNft = await ethers.getContractFactory("BasicNft");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    basicNft = await BasicNft.deploy();
    await basicNft.deployed();
  });

  describe("Deployment", function () {
    it("Should have the correct name and symbol", async function () {
      const name = await basicNft.name();
      expect(name).to.equal("Poncho");

      const symbol = await basicNft.symbol();
      expect(symbol).to.equal("PONCHO");
    });

    it("Should initialize the token counter to 0", async function () {
      const tokenCounter = await basicNft.getTokenCounter();
      expect(tokenCounter).to.equal(0);
    });
  });

  describe("Minting NFTs", function () {
    it("Should mint an NFT and increment the token counter", async function () {
      const initialTokenCounter = await basicNft.getTokenCounter();

      // Call the mintNft function
      const tx = await basicNft.mintNft();

      // Wait for the transaction to be mined
      await tx.wait();

      // Check that the token counter has incremented
      const newTokenCounter = await basicNft.getTokenCounter();
      expect(newTokenCounter).to.equal(initialTokenCounter.add(1));
    });

    it("Should mint an NFT and assign ownership to the caller", async function () {
      // Call the mintNft function
      const tx = await basicNft.mintNft();

      // Wait for the transaction to be mined
      await tx.wait();

      // Get the token ID of the newly minted NFT
      const tokenId = await basicNft.getTokenIdForOwner(owner.address);

      // Check that the owner of the token is the caller
      const tokenOwner = await basicNft.ownerOf(tokenId);
      expect(tokenOwner).to.equal(owner.address);
    });
  });
});
