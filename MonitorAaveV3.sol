// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;


import {IPoolAaveV3} from "./IPoolAaveV3.sol";
import {IERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.0/token/ERC20/IERC20.sol";
import {IWrappedTokenGatewayV3} from "./IWrappedTokenGatewayV3.sol";




contract MonitorAaveV3
{
       event Received(address, uint);
    
        receive() external payable {
        emit Received(msg.sender, msg.value);
        }   

        address public AaveLendingAddress = 0x8dA9412AbB78db20d0B496573D9066C474eA21B8;
        address public WrappedMaticTokenAddress = 0xaD3C5a67275dE4b5554CdD1d961e957f408eF75a;
        address public OnBehalfOf = 0x4415bd986532a2B8A1e702b18EF4A65075d42Db8;
        address public AaveProxyLendingAddress = 0xcC6114B983E4Ed2737E9BD3961c9924e6216c704;

        address public aPolWmatic = 0xaCA5e6a7117F54B34B476aB95Bf3034c304e7a81;


    function getHealthFactor(address ProxyAddress, address OnWhichBehalf) external view returns (uint256) {
        (, , , , , uint256 healthFactor) = IPoolAaveV3(ProxyAddress)
            .getUserAccountData(OnWhichBehalf);
        
            return healthFactor;
    }

    function gettotalDebtBase(address ProxyAddress, address OnWhichBehalf) external view returns (uint256) {

               (, uint256 totalDebtBase, , , ,) = IPoolAaveV3(
            ProxyAddress).getUserAccountData(OnWhichBehalf);

        return totalDebtBase;
    }

    function approve(address token, address spender, uint256 amount) public {
            
            IERC20 TokenContract = IERC20(token);

            TokenContract.approve(spender, amount);    
            
        }

    
 
        function fund() external payable {
        
        emit Received(msg.sender, msg.value);
           
        }

    

    function deposit(uint256 amount) external payable {


        IWrappedTokenGatewayV3 aaveContract = IWrappedTokenGatewayV3(AaveLendingAddress);
        aaveContract.depositETH{value: amount}(WrappedMaticTokenAddress, OnBehalfOf, 0);    
        }

    function withdraw(uint256 amount) public {

        IERC20 aPolWmaticContract = IERC20(aPolWmatic);

        aPolWmaticContract.approve(AaveLendingAddress, type(uint256).max); 

        IWrappedTokenGatewayV3 aaveContract = IWrappedTokenGatewayV3(AaveLendingAddress);
        aaveContract.withdrawETH(AaveProxyLendingAddress, amount, OnBehalfOf);    
        }

    

        function withdraw2(uint256 amount) public {

        IWrappedTokenGatewayV3 aaveContract = IWrappedTokenGatewayV3(AaveLendingAddress);
        aaveContract.withdrawETH(AaveProxyLendingAddress, amount, OnBehalfOf);    
        }
        

    }




    