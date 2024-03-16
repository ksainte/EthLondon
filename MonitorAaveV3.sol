// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;


import {IPoolAaveV3} from "./IPoolAaveV3.sol";
import {IERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.0/token/ERC20/IERC20.sol";
import {IWrappedTokenGatewayV3} from "./IWrappedTokenGatewayV3.sol";




contract MonitorAaveV3

{

       uint256 public healthFactor;

function getHealthFactor() external view returns (uint256) {
        (, , , , , uint256 healthFactor) = IPoolAaveV3(0xcC6114B983E4Ed2737E9BD3961c9924e6216c704)
            .getUserAccountData(0x4415bd986532a2B8A1e702b18EF4A65075d42Db8);
        
        return healthFactor;
    }

    function gettotalDebtBase() external view returns (uint256) {

               (, uint256 totalDebtBase, , , , uint256 healthFactor) = IPoolAaveV3(
            0xcC6114B983E4Ed2737E9BD3961c9924e6216c704
        ).getUserAccountData(0x4415bd986532a2B8A1e702b18EF4A65075d42Db8);
        return totalDebtBase;
    }

    function approve() public {
            // IERC20(0xaD3C5a67275dE4b5554CdD1d961e957f408eF75a).approve(0x8dA9412AbB78db20d0B496573D9066C474eA21B8, 500000000000000000);
            
            IERC20 maticContract = IERC20(0xaD3C5a67275dE4b5554CdD1d961e957f408eF75a);

            maticContract.approve(0x8dA9412AbB78db20d0B496573D9066C474eA21B8, 500000000000000000);    
            
        }


        address public aaveContractAddress = 0x8dA9412AbB78db20d0B496573D9066C474eA21B8;

    function deposit(uint256 amount) external payable {


        IWrappedTokenGatewayV3 aaveContract = IWrappedTokenGatewayV3(0x8dA9412AbB78db20d0B496573D9066C474eA21B8);
        // (bool success, ) = aaveContractAddress.call{value: amount}("");
        // aaveContract.depositETH{value: msg.value}(0xaD3C5a67275dE4b5554CdD1d961e957f408eF75a, 0x4415bd986532a2B8A1e702b18EF4A65075d42Db8, 0);
        // require(success, "Transfer failed.");
        aaveContract.depositETH{value: amount}(0xaD3C5a67275dE4b5554CdD1d961e957f408eF75a, 0x4415bd986532a2B8A1e702b18EF4A65075d42Db8, 0);    
        }

    }




    