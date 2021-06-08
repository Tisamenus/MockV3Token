pragma solidity ^0.7.6;
pragma abicoder v2;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    IUniswapV3Factory
} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import {
    INonfungiblePositionManager
} from "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import {
    TransferHelper
} from "@uniswap/v3-core/contracts/libraries/TransferHelper.sol";
import {
    IUniswapV3PoolActions
} from "@uniswap/v3-core/contracts/interfaces/pool/IUniswapV3PoolActions.sol";
import {IWETH9} from "./IWETH9.sol";
import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";
// testnet ether weth9 0xc778417E063141139Fce010982780140Aa0cD5Ab

contract MockToken is ERC20 {
    using TransferHelper for address;
    using SafeMath for uint256;

    address public poolAddress;
    bool public poolDeployed;
    uint256 public tokenId;

    IUniswapV3Factory public v3Factory;
    INonfungiblePositionManager public v3NPM;
    IUniswapV3PoolActions public deployedPool;
    IWETH9 public weth9c;

    event PoolInitialized(address PoolAddress, uint160 sqrtPriceX96);
    event NonfungibleLiquidityPositionMinted(
        uint256 tokenId,
        uint128 liquidity,
        uint256 amountToken0Used,
        uint256 amountToken1Used
    );

    event BalanceCheck(uint256);

    constructor(uint256 ownerBalance) ERC20("MockToken", "MOCK2536") {
        poolDeployed = false;
        v3Factory = IUniswapV3Factory(
            0x1F98431c8aD98523631AE4a59f267346ea31F984
        );
        v3NPM = INonfungiblePositionManager(
            0xC36442b4a4522E871399CD717aBDD847Ab11FE88
        );
        weth9c = IWETH9(0xc778417E063141139Fce010982780140Aa0cD5Ab);
        // mint an unnecessarily huge amount
        _mint(msg.sender, ownerBalance);
        BalanceCheck(balanceOf(msg.sender));
    }

    function selfDeployPool(uint24 fee, uint160 initialPrice) external {
        require(!poolDeployed, "only once");

        // fee is for one percent 10^-5

        poolAddress = v3Factory.createPool(

            address(this),
            0xc778417E063141139Fce010982780140Aa0cD5Ab,
            fee
        );
        deployedPool = IUniswapV3PoolActions(poolAddress);

        // ok so the price of the pools:
        // 0 = weth9, 1 = this so sqrt(this/weth9)

        uint160 sqrtPrice = uint160(initialPrice << 96);
        deployedPool.initialize(sqrtPrice);
        PoolInitialized(poolAddress, sqrtPrice);
        poolDeployed = true;
    }
}
