require('dotenv').config();
require("@nomiclabs/hardhat-waffle");
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
        version: "0.6.5"
      },
      {
        version: "0.7.6"
      }
    ]
   //overrides: {
   //  "node_modules/@uniswap/v3-periphery/contracts/libraries/PoolAddress.sol": {
   //    version: "0.5.0",
   //    settings: {}
   //  }
   //}
  },
  mocha: { timeout: 999999 }
};
