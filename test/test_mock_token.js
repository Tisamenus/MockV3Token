const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");
const provider = waffle.provider;
const chalk = require("chalk");

describe("Test Mock V3 Token", function () {

    //contract
    let mockTokenContract;

    // wallet
    let deployingWallet;
    const deploy = async (name, ...args) => (await ethers.getContractFactory(name)).deploy(...args);

    let extraGasInfo;

    before(async function () {
        [deployingWallet] = await ethers.getSigners();

        it("should deploy contract successfully", async function () {
            mockTokenContract = await deploy('MockTocken');

            const gasUsed = mockTokenContract.deployTransaction.gasLimit.mul(deployed.deployTransaction.gasPrice)
            extraGasInfo = `${utils.formatEther(gasUsed)} ETH, tx hash ${deployed.deployTransaction.hash}, \n`

            expect(mockTokenContract.address).to.exist();

        });

        console.log(
            chalk.cyan("MockToken"),
            "deployed to:",
            chalk.magenta(mockTokenContract.address)
        );
        console.log(
            chalk.grey(extraGasInfo)
        );
    });

    describe("SelfDeployPool()", () => {

        it("Should deploy the pool", async () => {

        const deploTX = await mockTokenContract.selfDeployPool();
        expect('selfDeployPool').to.be.calledOnContract(mockTokenContract);

        });

        const deploReceipt = await deploTX.wait();

        console.log(receipt.events[0].decode, '\n', receipt.events[1].decode);


    });


});
