require('dotenv').config();
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
  },
  solidity: {

    compilers: [
      {
        version: "0.4.18"
      },
      {
        version: "0.7.6"
      },
      {
        version: "0.8.0"
      }
    ]
  }
};
