const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");
const provider = waffle.provider;
const chalk = require("chalk");

describe("Test MockToken", function () {

    //factory
    let mockTokenFactory;

    //contract
    let mockTokenContract;

    // wallet
    let deployingWallet;

    let extraGasInfo;

    console.log(ethers.utils.parseEther("1.0"));

    let overrides = {
        gasLimit: ethers.utils.parseUnits("4000000", "wei"),
        gasPrice: ethers.utils.parseUnits("4", "gwei")
    }

    let ownerBalance = ethers.utils.parseEther("100"); // in 10^18 (ether)

    before(async function () {

        [deployingWallet] = await ethers.getSigners();

        mockTokenFactory = await ethers.getContractFactory('MockToken');

        mockTokenContract = await mockTokenFactory.deploy(ownerBalance, overrides);

        const gasUsed = mockTokenContract.deployTransaction.gasLimit.mul(mockTokenContract.deployTransaction.gasPrice)
        extraGasInfo = `${ethers.utils.formatEther(gasUsed)} ETH, tx hash ${mockTokenContract.deployTransaction.hash}, \n`

        console.log(
            chalk.cyan("MockToken"),
            "deployed to:",
            chalk.magenta(mockTokenContract.address)
        );
        console.log(
            chalk.grey(extraGasInfo)
        );

        WETH9Contract = await ethers.getContractAt('IWETH9', '0xad5bfebf0bb23adbd35d1d60407d21a0ba4e84ab');
    });

    describe("SelfDeployPool() && mintNonfungibleLiquidityPosition()", () => {

        let deploTX;
        let deploReceipt;

        let fee = ethers.utils.parseUnits("10000", "wei");
        let initialPrice = ethers.utils.parseUnits("100", "wei");

        it("Should deploy the pool", async () => {

            await expect(deploTX = await mockTokenContract.selfDeployPool(fee, initialPrice)).to.emit(mockTokenContract, 'PoolInitialized');
        });
    });
});
