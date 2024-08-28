// SPDX-License-Identfier: MIT

pragma solidity 0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundeMeTest is Test {
    FundMe fundMe;
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        
    }

    function testMinimumUsd() public {
        assertEq(fundMe.MINIMUM_USD(),5e18);
    }

    function testOwnerisSender() public{
        assertEq(fundMe.i_owner(),msg.sender);
    }
    function testFundFailsNotEnoughETH() public {
        vm.expectRevert();
        fundMe.fund();
    }
}