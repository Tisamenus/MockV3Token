pragma solidity ^0.7.6;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IUniswapV3Factory.sol} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol"
import {
    INonfungiblePositionManager
} from "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import { WETH9 } from "./WETH9.sol";

// testnet ether weth9 0xc778417E063141139Fce010982780140Aa0cD5Ab


contract MockToken is ERC20 {

    bool public poolDeployed;
    IUniswapV3Factory public v3Factory;
    INonfungiblePositionManager public v3NPM;
    WETH9 public weth9c;
    address public poolAddress;

    event PoolInitialized(address PoolAddress, uint160 sqrtPriceX96);


    constructor () ERC20("MockToken", "MOCK2536") {
        poolDeployed = false;
        v3Factory = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);
        v3NPM = INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);
        weth9c = WETH9(0xc778417E063141139Fce010982780140Aa0cD5Ab);
        _mint(address(this), 100000000);
        poolAddress = address(0);
    }

    function selfDeployPool() external {
        require(!poolDeployed, "only once");
        // deploy pool with 1% fee in hundreths of bip so 0.0001*10000 = 1%

        poolAddress = v3Factory.createPool(0xc778417E063141139Fce010982780140Aa0cD5Ab, address(this), 10000);

        // ok so the price of the pools:
        /// Price is represented as a sqrt(amountToken1/amountToken0) Q64.96 value
        // 0 = weth9, 1 = this so sqrt(this/weth9)
        /// sqrtPriceX96 the initial sqrt price of the pool as a Q64.96 // so 64 integer 96 fractional parts
        // we will set 25,000,000 so root 5000

        uint160 sqrtPrice = uint160(5000 << 96);
        poolAddress.initialize(sqrtPrice);
        PoolInitialized(poolAddress, sqrtPrice);
        poolDeployed = true;
    }

    function addWETH() external payable {
        address payable weth9cAddress = address(weth9c);
        // has fallback function
        weth9cAddress.send(msg.value);
    }

    // function mintNonfungibleLiquidityPosition() external {



    // }

}