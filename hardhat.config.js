/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.7.6",
  networks: {
    hardhat: {},
    ropsten: {
      url: process.env.ropstenInfura,
      accounts: [process.env.ropstenWalletPK]
    }
  }
};
