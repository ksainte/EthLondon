// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";


/**
 * @title Chainlink Functions example on-demand consumer contract example
 */
contract Swap {
  

  ISwapRouter public immutable swapRouter = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
  address public constant WETH = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;
  address public constant WMATIC = 0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889;
    address public constant MATIC = 0x0000000000000000000000000000000000001010;

  uint24 public constant poolFee = 3000;

        event Received(address, uint);
    
        receive() external payable {
        emit Received(msg.sender, msg.value);
        }   
 
  function swapExactInputSingle(uint256 amountIn) public returns (uint256 amountOut) {
    // uint256 amountIn = checkBalance();
    // Approve the router to spend WMATIC.
    TransferHelper.safeApprove(MATIC, address(swapRouter), amountIn);
    // Naively set amountOutMinimum to 0. In production, use an oracle or other data source to choose a safer value for amountOutMinimum.
    // We also set the sqrtPriceLimitx96 to be 0 to ensure we swap our exact input amount.
    ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
      tokenIn: MATIC,
      tokenOut: WMATIC,
      fee: poolFee,
      recipient: address(this),
      deadline: block.timestamp,
      amountIn: amountIn,
      amountOutMinimum: 0,
      sqrtPriceLimitX96: 0
    });

    // The call to `exactInputSingle` executes the swap.
    amountOut = swapRouter.exactInputSingle(params);
  }

  function checkBalance() internal view returns (uint256 balance) {
    IERC20 wrappedMatic = IERC20(WMATIC);
    balance = wrappedMatic.balanceOf(address(this));
  }
}
