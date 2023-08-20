const {expect} = require("chai");
const hre = require("hardhat");

describe("Validating NFT",function(){
    let token;
    let owner;
    let addressOne;
    let addressTwo;
    beforeEach(async function(){
        token = await hre.ethers.deployContract("kyorakuAshesi");
        [owner,addressOne,addressTwo] = await hre.ethers.getSigners();
    });
    it("Should assign ownership to deployer",async function(){
        const getOwner = await token.owner();
        console.log(getOwner);
        expect(getOwner).to.equal(owner.address);
    });
    it("Should get exact tokens deployed",async function(){
        const ftTokne = await token.balanceOf(owner.address,0);
        const nftTokne = await token.balanceOf(owner.address,1);
        console.log(ftTokne);
        console.log(nftTokne);
        expect(ftTokne).to.equal(50);
        expect(nftTokne).to.equal(1);
    });
    
})